CREATE DATABASE IF NOT EXISTS matcha_english_learning_website;
USE matcha_english_learning_website;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	UserID varchar(36) NOT NULL,
    UserName varchar(50) COLLATE utf8_general_ci NOT NULL UNIQUE,
    Pass binary(60) NOT NULL,
    TypeAccount int,
    CreateTime datetime,
	UpdateTime datetime,
    LockAccount bool,
	IsDelete bool default(0),
    PRIMARY KEY(UserID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS archives;  
CREATE TABLE archives (
	UserID varchar(36) NOT NULL,
	LastLoginDate datetime,
	Streak int NOT NULL default(0),
	BestStreak int NOT NULL default(0),
	FOREIGN KEY (UserID) REFERENCES users(UserID),
	PRIMARY KEY(UserID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


DROP TABLE IF EXISTS lessons;
CREATE TABLE lessons (
	LessonID varchar(36) NOT NULL,
    LessonName varchar(100) COLLATE utf8_general_ci NOT NULL UNIQUE,
    LessonAvatar text,
    LessonDes text,
    IsDelete bool default(0),
    PRIMARY KEY(LessonID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS topics;
CREATE TABLE topics (
	TopicID varchar(36) NOT NULL,
	TopicName varchar(100) COLLATE utf8_general_ci NOT NULL UNIQUE,
	TopicAvatar text,
	TopicDescription text COLLATE utf8_general_ci,
	LessonID varchar(36) NOT NULL,
	IsDelete bool default(0),
	FOREIGN KEY (LessonID) REFERENCES lessons(LessonID),
	PRIMARY KEY(TopicID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS words;
CREATE TABLE words (
	WordID varchar(36) NOT NULL,
    WordName varchar(50) COLLATE utf8_general_ci NOT NULL ,
    WordType varchar(10),
    WordMeaning text COLLATE utf8_general_ci,
	WordPronounce varchar(50),
	WordExample text,
	WordAvatar text,
	WordAudio text,
	TopicID  varchar(36) NOT NULL,
    IsDelete bool default(0),
    FOREIGN KEY (TopicID) REFERENCES topics(TopicID),
    PRIMARY KEY(WordID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS wordHistory;
CREATE TABLE wordHistory(
	UserID varchar(36) NOT NULL,
	WordID varchar(36) NOT NULL,
	MemoryLevel int NOT NULL default(1),
    FirstTime datetime,
    UpdateTime date,
	IsStudy bool NOT NULL default(1),
	CONSTRAINT chk_wordhistory_memory_level CHECK (MemoryLevel BETWEEN 1 AND 5),
    FOREIGN KEY (UserID) REFERENCES users(UserID),
    FOREIGN KEY (WordID) REFERENCES words(WordID),
    PRIMARY KEY(UserID,WordID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS multipleChoiceQuestions;
CREATE TABLE multipleChoiceQuestions (
	QuestionID  varchar(36) NOT NULL,
    Question text COLLATE utf8_general_ci,
    OptionA  varchar(50) COLLATE utf8_general_ci,
    OptionB  varchar(50) COLLATE utf8_general_ci,
    OptionC  varchar(50) COLLATE utf8_general_ci,
    OptionD  varchar(50) COLLATE utf8_general_ci,
    Answer varchar(50) COLLATE utf8_general_ci,
    WordID varchar(36) NOT NULL,
    QuestionAvatar text,
    IsDelete bool default(0),
	FOREIGN KEY (WordID) REFERENCES words(WordID),
    PRIMARY KEY(QuestionID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS  topicHistory;
CREATE TABLE topicHistory (
	TopicID  varchar(36) NOT NULL,
    UserID varchar(36) NOT NULL,
    CreateTime datetime,
    FOREIGN KEY (TopicID) REFERENCES topics(TopicID),
    FOREIGN KEY (UserID) REFERENCES users(UserID),
    PRIMARY KEY(TopicID,UserID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS topicProgress;
CREATE TABLE topicProgress (
	UserID varchar(36) NOT NULL,
	TopicID varchar(36) NOT NULL,
	LastWordID varchar(36),
	CurrentIndex int NOT NULL default(0),
	CompletedWordCount int NOT NULL default(0),
	Status enum('not_started', 'in_progress', 'completed') NOT NULL default('not_started'),
	UpdateTime datetime NOT NULL default CURRENT_TIMESTAMP,
	CompletedTime datetime,
	CONSTRAINT chk_topicprogress_current_index CHECK (CurrentIndex >= 0),
	CONSTRAINT chk_topicprogress_completed_count CHECK (CompletedWordCount >= 0),
	FOREIGN KEY (UserID) REFERENCES users(UserID),
	FOREIGN KEY (TopicID) REFERENCES topics(TopicID),
	FOREIGN KEY (LastWordID) REFERENCES words(WordID),
	PRIMARY KEY(UserID, TopicID),
	INDEX idx_topicprogress_user_status_update (UserID, Status, UpdateTime)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS  testHistory;
CREATE TABLE testHistory (
	TestID  varchar(36) NOT NULL,
	UserID varchar(36) NOT NULL,
	TopicID varchar(36),
	TestType enum('topic_test', 'daily_review') NOT NULL default('topic_test'),
	Status enum('in_progress', 'completed', 'abandoned') NOT NULL default('completed'),
	TotalCorrect int NOT NULL default(0),
	TotalQuestion int NOT NULL default(0),
	StartedTime datetime,
	CompletedTime datetime,
	CreateTime datetime NOT NULL default CURRENT_TIMESTAMP,
	RetakeOfTestID varchar(36),
	CONSTRAINT chk_testhistory_total_correct CHECK (TotalCorrect >= 0),
	CONSTRAINT chk_testhistory_total_question CHECK (TotalQuestion >= 0),
	CONSTRAINT chk_testhistory_score CHECK (TotalCorrect <= TotalQuestion),
	FOREIGN KEY (UserID) REFERENCES users(UserID),
	FOREIGN KEY (TopicID) REFERENCES topics(TopicID),
	FOREIGN KEY (RetakeOfTestID) REFERENCES testHistory(TestID),
	PRIMARY KEY(TestID),
	INDEX idx_testhistory_user_created (UserID, CreateTime),
	INDEX idx_testhistory_topic (TopicID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS  testHistoryDetail;
CREATE TABLE testHistoryDetail (
	DetailID bigint unsigned NOT NULL AUTO_INCREMENT,
	TestID varchar(36) NOT NULL,
	QuestionID varchar(36),
	WordID varchar(36),
	QuestionType varchar(30),
	QuestionSnapshot text COLLATE utf8_general_ci,
	QuestionAvatarSnapshot text,
	CorrectAnswer varchar(50) COLLATE utf8_general_ci,
	OptionA  varchar(50) COLLATE utf8_general_ci,
	OptionB  varchar(50) COLLATE utf8_general_ci,
	OptionC  varchar(50) COLLATE utf8_general_ci,
	OptionD  varchar(50) COLLATE utf8_general_ci,
	UserChoose varchar(50) COLLATE utf8_general_ci,
	IsCorrect bool,
	FOREIGN KEY (TestID) REFERENCES testHistory(TestID),
	FOREIGN KEY (QuestionID) REFERENCES multipleChoiceQuestions(QuestionID),
	FOREIGN KEY (WordID) REFERENCES words(WordID),
	PRIMARY KEY(DetailID),
	UNIQUE KEY uq_testhistorydetail_question (TestID, QuestionID),
	INDEX idx_testhistorydetail_test (TestID),
	INDEX idx_testhistorydetail_word (WordID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DROP TABLE IF EXISTS studyActivity;
CREATE TABLE studyActivity (
	ActivityID varchar(36) NOT NULL,
	UserID varchar(36) NOT NULL,
	ActivityDate date NOT NULL,
	ActivityType enum('topic_complete', 'topic_test_complete', 'daily_review_complete') NOT NULL,
	ReferenceID varchar(36) NOT NULL,
	CreateTime datetime NOT NULL default CURRENT_TIMESTAMP,
	FOREIGN KEY (UserID) REFERENCES users(UserID),
	PRIMARY KEY(ActivityID),
	UNIQUE KEY uq_studyactivity_completion (UserID, ActivityType, ReferenceID),
	INDEX idx_studyactivity_user_date (UserID, ActivityDate)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

DELIMITER //

DROP PROCEDURE IF EXISTS update_memlevel//
CREATE PROCEDURE update_memlevel(
  IN p_userid VARCHAR(36),
  IN p_wordid VARCHAR(36),
  IN p_check INT
)
BEGIN
  DECLARE v_memlevel INT;
  -- Get the current memlevel for the user and word
  SELECT MemoryLevel INTO v_memlevel
  FROM wordHistory
  WHERE UserID = p_userid AND WordID = p_wordid;
  IF p_check = 0 THEN
    -- Decrease memlevel by 1, but don't go below 1
    IF v_memlevel > 1 THEN
      UPDATE wordHistory
      SET MemoryLevel = v_memlevel - 1, UpdateTime = NOW()
      WHERE UserID = p_userid AND WordID = p_wordid;
	ELSE
	  UPDATE wordHistory
      SET UpdateTime = NOW()
      WHERE UserID = p_userid AND WordID = p_wordid;
    END IF;
  ELSE
    -- Increase memlevel by 1, but don't go above 5
    IF v_memlevel < 5 THEN
      UPDATE wordHistory
      SET MemoryLevel = v_memlevel + 1, UpdateTime = NOW()
      WHERE UserID = p_userid AND WordID = p_wordid;
	ELSE
	  UPDATE wordHistory
      SET UpdateTime = NOW()
      WHERE UserID = p_userid AND WordID = p_wordid;
    END IF;
  END IF;
END//
DELIMITER ;
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS = 1;
