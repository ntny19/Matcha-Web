# Matcha Web - Use Case Gap Analysis & Implementation Plan

> Status: Planning only  
> Source of requirements: `README_USE_CASES.md`  
> Scope: Missing or partially implemented behavior found by comparing the use cases with routes, services, views, and `tkpm.sql`.

## 1. Goal

Close the gaps between the documented use cases and the current application while preserving the existing Express + Handlebars + Knex + MySQL architecture.

This document does not authorize a rewrite. Work should be delivered incrementally, with a database migration and acceptance tests for each behavior-changing phase.

## 2. Current implementation summary

The project already supports the main happy paths for authentication, role-based access, lesson/topic browsing, flashcards, topic tests, daily review, handbook filtering, test history, basic streak display, admin content CRUD, question CRUD, and user lock/unlock.

The remaining work is concentrated in progress persistence, activity history, streak correctness, review consistency, richer vocabulary metadata, business-rule validation, and save/cancel user flows.

## 3. Gap matrix

| Priority | Use case / rule | Current state | Required outcome |
| --- | --- | --- | --- |
| P0 | Schema consistency | `testHistory` is written with `TotalCorrect` and `TotalQuestion`, but those columns are absent from `tkpm.sql`. `topics.LessonID` references a nonexistent `categories` table. | Make the schema reproducible and consistent with running code before adding features. |
| P0 | U07-U10 Memory Level | Daily review updates memory level; topic-test submission only stores history. | Every graded answer updates the corresponding word consistently and atomically. |
| P0 | U11 streak trigger | Opening `/dailytest` can update streak before the learner completes an activity. | Record streak only after a qualifying topic or test completion. Repeated activity on the same day must be idempotent. |
| P0 | U11 activity history | Only the latest login date/current streak is stored. | Persist every qualifying study date and expose a calendar/history view. |
| P0 | U11 best streak | No storage or calculation exists. | Store or reliably calculate current and best streak. |
| P1 | U06 partial flashcard progress | Word/topic history is written only at topic completion. | Save each completed card or a resume cursor and allow continuation after leaving. |
| P1 | U06 unfinished-topic ordering | No explicit unfinished state or pinned ordering. | Show in-progress topics before untouched/completed topics. |
| P1 | U06-U10 exit confirmation | No consistent confirmation flow was found. | Warn when leaving an unfinished learning/test session and respect Save/Discard behavior. |
| P1 | U12 retake | History list/detail exists, but no retake action exists. | Start a new attempt from a historical test without mutating the old attempt. |
| P1 | U18 vocabulary audio | No audio column; UI uses browser speech synthesis. | Allow an admin-managed audio file/URL with speech synthesis as an optional fallback. |
| P1 | U05 exact topic size | No enforcement of exactly 10 active words per topic. | Enforce the chosen product rule at publish/test time without blocking safe draft editing. |
| P1 | U18 required vocabulary data | Most vocabulary columns are nullable and application validation is incomplete. | Validate required word, meaning, type, pronunciation, image, example, and audio policy. |
| P1 | U21 topic description | Topic schema and edit UI have no description field. | Add and manage a topic description. |
| P2 | U25 question authoring | Questions are added individually; no text-selection-to-blank workflow or draft batch save exists. | Support blank creation, multiple draft questions, Save, and Discard. |
| P2 | U27-U28 edit/delete workflow | Changes are persisted immediately; documented Save/Do not save behavior is absent. | Stage edits/deletes in the UI and commit them in one transaction. |
| P2 | U12 history completeness | Retake aside, history is topic-test oriented and daily-review attempts are not represented consistently. | Decide whether all test modes belong in one history model and implement the documented result fields. |

## 4. Proposed data model

Use migrations rather than relying only on edits to the bootstrap SQL file. Keep `tkpm.sql` synchronized for fresh installations.

### 4.1 Schema repair

- Fix `topics.LessonID` to reference `lessons(LessonID)`.
- Add `TotalCorrect` and `TotalQuestion` to `testHistory`, or replace them with an attempt model described below.
- Add missing indexes for foreign keys and common queries: user/date activity, user/word history, topic/word, and user/test creation time.
- Confirm consistent column naming/casing because the code currently mixes forms such as `wordHistory`, `wordhistory`, `WordID`, and `wordid`.

### 4.2 Study activity

Add a `study_activity` table:

| Column | Purpose |
| --- | --- |
| `ActivityID` | UUID primary key |
| `UserID` | Learner |
| `ActivityDate` | Local study date used for streak calculation |
| `ActivityType` | `topic_complete`, `topic_test_complete`, or `daily_review_complete` |
| `ReferenceID` | Optional topic/test attempt ID |
| `CreateTime` | Audit timestamp |

Add a uniqueness rule that prevents the same completion event from being counted twice. Calculate streaks from distinct activity dates, or cache `CurrentStreak` and `BestStreak` in `archives` while treating activity rows as the source of truth.

Timezone rule: derive `ActivityDate` in the configured application timezone, not by slicing a UTC timestamp in route code.

### 4.3 Flashcard progress

Add a `topic_progress` table:

| Column | Purpose |
| --- | --- |
| `UserID`, `TopicID` | Composite identity |
| `LastWordID` or `CurrentIndex` | Resume position |
| `CompletedWordCount` | Progress display |
| `Status` | `not_started`, `in_progress`, `completed` |
| `UpdateTime`, `CompletedTime` | Ordering and audit |

Do not use only a client-side cursor. Persist progress server-side so it survives device/browser changes. Word-level completion should remain idempotent when inserting into `wordHistory`.

### 4.4 Vocabulary and topic metadata

- Add `topics.TopicDescription`.
- Add `words.WordAudio` for an uploaded asset path or validated URL.
- Define upload restrictions: allowed MIME types, maximum size, generated filename, and deletion/replacement behavior.
- Keep speech synthesis as fallback when `WordAudio` is absent during migration.

### 4.5 Test attempts

Prefer extending the existing history tables instead of creating parallel tables unless daily tests must also be retained:

- Add an attempt type (`topic_test`, `daily_review`).
- Store `StartedTime`, `CompletedTime`, score, total, and status.
- Ensure each detail row can resolve `WordID`, question type, expected answer, and learner answer even if an admin later edits or soft-deletes the source question.
- Retake creates a new attempt linked by optional `RetakeOfTestID`; the historical record remains immutable.

## 5. API and service changes

Routes below are suggested interfaces; final naming should follow the existing route style or be normalized consistently in a separate refactor.

### 5.1 Progress

- `POST /topic/:id/progress`: record a completed card/resume cursor idempotently.
- `POST /topic/:id/finish`: transactionally finalize word history, topic progress, topic history, and study activity.
- Extend topic-list queries with progress status and order by `in_progress` first, then most recently updated.

### 5.2 Test submission

- Replace per-answer client calls to `/resultdailytest` with one completion submission containing the full attempt.
- Validate answers on the server; never trust client-provided `check`, score, or correct-answer values.
- In one transaction: store attempt/details, update each word's memory level, and create a qualifying study activity.
- Apply the same grading service to topic tests and daily review to prevent rule drift.

### 5.3 Activity and streak

- Add a service to record an activity and recalculate current/best streak idempotently.
- Add a history endpoint or server-rendered route accepting month/year.
- Remove streak mutation from `GET /dailytest`; GET requests must be read-only.

### 5.4 Retake

- Add `POST /tests/:testId/retake` or a GET confirmation followed by POST.
- Generate a fresh attempt using the original topic/question scope while preserving the old history.
- Define behavior when original questions or vocabulary have been soft-deleted: omit unavailable questions and inform the learner, or use the stored snapshot.

### 5.5 Admin validation and drafts

- Centralize Lesson, Topic, Vocabulary, and Question validation in services rather than only in browser JavaScript.
- Validate the 10-word rule when a topic becomes learner-visible or a test starts. This is safer than rejecting draft topics with fewer than 10 words.
- Add batch question create/update/delete endpoints that execute in one transaction.
- Keep staged edits client-side until Save; Cancel discards local changes.

## 6. UI changes

### Learner

- Show progress percentage and “Continue” on in-progress topic cards.
- Resume flashcards at the persisted position.
- Add a shared dirty-session exit modal to flashcard, topic-test, and daily-review pages. Also handle browser navigation through `beforeunload` as a last-resort warning.
- Add calendar navigation, marked study days, current streak, and best streak.
- Add Retake to test-history detail/list and clearly label the new attempt.
- Play `WordAudio` when available; use Web Speech API only as fallback.

### Admin

- Add topic-description fields to create/detail/edit screens.
- Add audio upload/preview/replacement to vocabulary screens.
- Show required-field validation next to each input.
- Show active-word count and prevent publishing/testing a topic unless it contains exactly 10 valid words.
- Add question draft rows, automatic blank insertion from selected text, and explicit Save/Discard controls.

## 7. Delivery plan

### Phase 0 - Baseline and safety net

1. Document the environment variables and create a reproducible development database setup.
2. Introduce a migration mechanism and a test database configuration.
3. Repair schema drift and foreign keys.
4. Add request/service integration tests for login permissions and the existing primary learning flows.
5. Replace raw interpolated SQL touched by this work with parameterized Knex queries.

Exit criteria:

- A clean database can be created from migrations/bootstrap SQL.
- Existing learner/admin happy paths pass smoke tests.
- `testHistory` inserts work against the committed schema.

### Phase 1 - Unified grading and correct activity tracking

1. Extract one server-side grading/memory-level service.
2. Submit daily review as a complete attempt instead of trusting query parameters.
3. Update memory levels for topic-test answers.
4. Add `study_activity`, current streak, and best streak logic.
5. Move streak mutation from page entry to successful completion events.

Exit criteria:

- A correct answer increments at most one level and an incorrect answer decrements at most one level within bounds.
- Retrying a submission does not double-apply results.
- Merely opening a page never changes streak.
- Current and best streak match distinct qualifying activity dates.

### Phase 2 - Flashcard progress and safe exits

1. Add the topic-progress model and endpoint.
2. Save each completed card and resume reliably.
3. Order in-progress topics first.
4. Add shared exit confirmation and Save/Discard behavior.
5. Make topic completion idempotent and transactional.

Exit criteria:

- Refreshing or changing device resumes at the saved position.
- Exiting after several cards preserves only acknowledged progress.
- Completing the same topic twice does not duplicate word/topic history or streak activity.

### Phase 3 - History calendar and retake

1. Build monthly activity queries and calendar UI.
2. Display current and best streak.
3. Add retake from history with immutable old attempts.
4. Decide and implement whether daily-review attempts appear in the same history list.

Exit criteria:

- Calendar days correspond to stored qualifying activity.
- Month navigation works across year boundaries.
- Retake produces a new result and does not alter the source result.

### Phase 4 - Content model and validation

1. Add topic description and vocabulary audio migrations.
2. Update admin and learner views.
3. Add secure audio upload handling and fallback playback.
4. Centralize required-field validation.
5. Enforce exactly 10 active valid words at publish/test boundaries.

Exit criteria:

- Admin can create/edit/display a topic description.
- Uploaded valid audio plays; invalid file type/size is rejected.
- An invalid topic cannot be exposed for learning/testing, while drafts remain editable.

### Phase 5 - Question authoring workflow

1. Add draft question rows and select-text-to-blank behavior.
2. Support multiple questions per vocabulary in one session.
3. Stage edits/deletes and commit them as one transaction.
4. Add Save/Discard exit confirmation.

Exit criteria:

- Cancel/Discard causes no database changes.
- Save applies all valid changes or none if any operation fails.
- Soft-deleted questions no longer appear in new tests but old attempt details remain readable.

### Phase 6 - Regression, cleanup, and documentation

1. Run learner/admin regression tests across all U01-U29 use cases.
2. Test duplicate submissions, browser refresh, back navigation, empty topics, deleted content, timezone boundaries, and database failures.
3. Remove duplicate route/service declarations encountered in touched modules.
4. Update `README_USE_CASES.md`, setup documentation, and route/data-model notes to match final behavior.

## 8. Test strategy

### Unit tests

- Memory-level bounds and scheduling rules.
- Current/best streak calculation with same-day activity, missed days, month/year boundaries, and application timezone.
- Topic publish eligibility and required vocabulary fields.
- Progress-state transitions.

### Integration tests

- Atomic topic completion.
- Atomic test grading/history/memory update.
- Duplicate-submission idempotency.
- Authorization for learner/admin endpoints.
- Retake immutability.
- Audio metadata and upload validation.

### Browser tests

- Flashcard resume and exit modal.
- Four daily-review interaction types.
- Calendar navigation.
- Handbook include/exclude behavior after grading changes.
- Admin Save/Discard question workflow.

## 9. Product decisions required before implementation

These decisions affect the database/API contract and should be confirmed before their corresponding phase:

1. Does “exactly 10 words” apply while editing, only when publishing, or only when starting learner activities? Recommended: enforce at publish/test boundaries.
2. Does completing any one flashcard qualify as daily activity, or only completing the whole topic? The current use-case rule says whole topic or completed test.
3. Should daily-review attempts appear in quiz history? Recommended: yes, with an attempt-type filter.
4. Should retakes use the original question snapshot or current active questions? Recommended: use a snapshot when available for reproducibility.
5. Is uploaded audio mandatory for every new word, or may browser speech remain a supported fallback? Recommended: require audio for published content and retain fallback for legacy data.
6. Should the documented reset value be strictly `0`, even though the first new qualifying activity naturally produces streak `1`? Recommended: show `0` before activity and `1` immediately after completion.

## 10. Definition of done

A gap is considered closed only when:

- The database migration, server-side validation, route/service behavior, and UI are all implemented.
- Authorization and input validation are enforced server-side.
- Success, cancel, retry, duplicate submission, and failure paths are tested.
- The behavior matches `README_USE_CASES.md`, or the requirements document is explicitly updated following an approved product decision.
- Existing user history remains readable after migration.

