# Matcha – Web Học Tiếng Anh: Tài Liệu Đặc Tả Use Case

> **Phiên bản:** 1.0  
> **Mục đích:** Tài liệu đặc tả yêu cầu chức năng và luồng xử lý Use Case phục vụ triển khai phát triển phần mềm (Software Requirements Specification - SRS).

---

## 📑 Mục lục

1. [Tổng quan hệ thống](#1-tổng-quan-hệ-thống)
2. [Danh sách Actor](#2-danh-sách-actor)
3. [Danh mục Use Case tổng quát](#3-danh-mục-use-case-tổng-quát)
4. [Đặc tả chi tiết Use Case – Phân hệ Người học (Learner)](#4-đặc-tả-chi-tiết-use-case--phân-hệ-người-học-learner)
   - [U06: Học từ vựng qua Flashcard](#u06-học-từ-vựng-qua-flashcard)
   - [U07: Bài kiểm tra trắc nghiệm ABCD](#u07-bài-kiểm-tra-trắc-nghiệm-abcd)
   - [U08: Bài kiểm tra đoán từ (Word Guessing)](#u08-bài-kiểm-tra-đoán-từ-word-guessing)
   - [U09: Bài kiểm tra nghe phát âm (Listening / Dictation)](#u09-bài-kiểm-tra-nghe-phát-âm-listening--dictation)
   - [U10: Bài kiểm tra sắp xếp từ (Word Scramble)](#u10-bài-kiểm-tra-sắp-xếp-từ-word-scramble)
   - [U11: Lịch sử thời gian học (Study Streak & History)](#u11-lịch-sử-thời-gian-học-study-streak--history)
   - [U12: Lịch sử làm bài kiểm tra (Quiz History)](#u12-lịch-sử-làm-bài-kiểm-tra-quiz-history)
   - [U13: Danh sách từ đã học (Learned Vocabulary)](#u13-danh-sách-từ-đã-học-learned-vocabulary)
   - [U14: Tìm từ trong danh sách từ đã học](#u14-tìm-từ-trong-danh-sách-từ-đã-học)
   - [U15: Lọc / Loại bỏ từ khỏi bài ôn tập](#u15-lọc--loại-bỏ-từ-khỏi-bài-ôn-tập)
5. [Đặc tả chi tiết Use Case – Phân hệ Quản trị viên (Admin)](#5-đặc-tả-chi-tiết-use-case--phân-hệ-quản-trị-viên-admin)
   - [U16: Thêm Lesson mới](#u16-thêm-lesson-mới)
   - [U17: Thêm Topic mới](#u17-thêm-topic-mới)
   - [U18: Thêm từ vựng vào Topic](#u18-thêm-từ-vựng-vào-topic)
   - [U21: Chỉnh sửa Topic](#u21-chỉnh-sửa-topic)
   - [U22: Xóa Topic](#u22-xóa-topic)
   - [U25: Thêm câu hỏi cho bài kiểm tra](#u25-thêm-câu-hỏi-cho-bài-kiểm-tra)
   - [U27: Chỉnh sửa câu hỏi bài kiểm tra](#u27-chỉnh-sửa-câu-hỏi-bài-kiểm-tra)
   - [U28: Xóa câu hỏi bài kiểm tra](#u28-xóa-câu-hỏi-bài-kiểm-tra)
6. [Quy tắc nghiệp vụ & Ràng buộc dữ liệu](#6-quy-tắc-nghiệp-vụ--ràng-buộc-dữ-liệu)

---

## 1. Tổng quan hệ thống

**Matcha** là nền tảng web hỗ trợ người dùng học từ vựng tiếng Anh theo phương pháp trực quan và khoa học:
- **Cấu trúc nội dung:** Kiến thức được tổ chức theo cấp bậc phân tầng: `Lesson (Chương/Chủ đề lớn)` ➔ `Topic (Chủ đề nhỏ)` ➔ `Vocabulary (Từ vựng)`.
- **Phương pháp học:** Kết hợp Flashcard tương tác đa phương tiện (âm thanh, hình ảnh minh họa, phiên âm, ngữ cảnh) và 4 dạng bài tập/kiểm tra phản xạ (Trắc nghiệm, Đoán từ, Nghe điền từ, Sắp xếp ký tự).
- **Theo dõi tiến độ:** Tự động ghi nhận thời gian học (streak), lịch sử kiểm tra và phân loại từ vựng theo cấp độ ghi nhớ (*Memory Level*).

---

## 2. Danh sách Actor

| STT | Tên Actor | Mô tả / Quyền hạn |
| :-: | :--- | :--- |
| **1** | **Người học (Learner / User)** | Người dùng đăng ký tài khoản trên hệ thống để học từ vựng tiếng Anh theo lộ trình, làm bài kiểm tra đánh giá, quản lý kho từ cá nhân và theo dõi tiến độ học tập. |
| **2** | **Quản trị viên (Admin)** | Tài khoản đặc quyền do hệ thống cấp, có trách nhiệm quản lý cấu trúc khóa học (Lesson, Topic), cập nhật kho từ vựng đa phương tiện, quản lý ngân hàng câu hỏi kiểm tra và quản lý người dùng. |

---

## 3. Danh mục Use Case tổng quát

### 3.1. Phân hệ Xác thực & Quản lý tài khoản
| ID | Tên Use Case | Actor | Ý nghĩa / Ghi chú |
| :-: | :--- | :--- | :--- |
| **U01** | Đăng nhập | Người học, Admin | Đăng nhập hệ thống bằng username và password. |
| **U02** | Đăng ký | Khách (Guest) | Đăng ký tài khoản người học thông thường. |
| **U03** | Đăng xuất | Người học, Admin | Đăng xuất phiên làm việc hiện tại. |
| **U29** | Quản lý tài khoản user | Admin | Xem danh sách người dùng, kích hoạt hoặc khóa tài khoản vi phạm. |

### 3.2. Phân hệ Học tập & Ôn luyện (Dành cho Người học)
| ID | Tên Use Case | Actor | Ý nghĩa / Ghi chú |
| :-: | :--- | :--- | :--- |
| **U04** | Hiển thị danh sách Lesson | Người học | Hiển thị danh mục các Lesson lớn (IELTS, Chuyên ngành, Giao tiếp,...). |
| **U05** | Phân chia từ vựng theo Topic | Hệ thống | Mỗi Topic được chuẩn hóa gồm 10 từ vựng để tối ưu khả năng ghi nhớ. |
| **U06** | Học qua Flashcard | Người học | Học từ vựng với Flashcard 2 mặt (từ, phiên âm, audio, hình ảnh, nghĩa, ví dụ). |
| **U07** | Bài kiểm tra trắc nghiệm ABCD | Người học | Chọn đáp án tiếng Anh đúng dựa trên câu hỏi, nghĩa tiếng Việt hoặc hình ảnh. |
| **U08** | Bài kiểm tra đoán từ | Người học | Điền từng chữ cái hoặc cả từ vào ô trống với tối đa 3 mạng (Hearts). |
| **U09** | Bài kiểm tra nghe phát âm | Người học | Nghe audio phát âm chuẩn và gõ lại chính xác từ vựng. |
| **U10** | Bài kiểm tra sắp xếp từ | Người học | Sắp xếp lại các chữ cái bị xáo trộn ngẫu nhiên thành từ có nghĩa đúng. |

### 3.3. Phân hệ Quản lý tiến độ & Sổ từ vựng cá nhân
| ID | Tên Use Case | Actor | Ý nghĩa / Ghi chú |
| :-: | :--- | :--- | :--- |
| **U11** | Lịch sử thời gian học | Người học | Xem lịch học tập và chuỗi ngày học liên tục (Streak). |
| **U12** | Lịch sử làm bài kiểm tra | Người học | Xem lại lịch sử các bài kiểm tra đã làm kèm điểm số và tùy chọn làm lại. |
| **U13** | Danh sách từ đã học | Người học | Quản lý kho từ cá nhân được phân nhóm theo cấp độ ghi nhớ (*Memory Level*). |
| **U14** | Tìm từ trong danh sách đã học | Người học | Tìm kiếm nhanh từ vựng trong kho từ đã học. |
| **U15** | Lọc từ muốn học | Người học | Ẩn/loại bỏ từ khỏi danh sách ôn tập và bài kiểm tra định kỳ hàng ngày. |

### 3.4. Phân hệ Quản trị nội dung (Dành cho Admin)
| ID | Tên Use Case | Actor | Ý nghĩa / Ghi chú |
| :-: | :--- | :--- | :--- |
| **U16** | Thêm Lesson | Admin | Tạo một Lesson (chương học lớn) mới. |
| **U17** | Thêm Topic | Admin | Tạo một Topic mới thuộc Lesson. |
| **U18** | Thêm từ vào Topic | Admin | Thêm từ mới kèm thông tin đa phương tiện vào Topic có sẵn. |
| **U19** | Chi tiết & chỉnh sửa từ vựng | Admin | Xem chi tiết, xem thử qua Flashcard và cập nhật thông tin từ vựng. |
| **U20** | Xóa từ vựng | Admin | Xóa từ vựng khỏi Topic. |
| **U21** | Chi tiết & chỉnh sửa Topic | Admin | Cập nhật mô tả Topic, quản lý danh sách từ và bài kiểm tra thuộc Topic. |
| **U22** | Xóa Topic | Admin | Xóa Topic cùng toàn bộ dữ liệu từ vựng/bài kiểm tra bên trong. |
| **U23** | Chi tiết & chỉnh sửa Lesson | Admin | Cập nhật thông tin Lesson và cấu trúc Topic thuộc Lesson. |
| **U24** | Xóa Lesson | Admin | Xóa toàn bộ Lesson khỏi hệ thống. |
| **U25** | Thêm câu hỏi kiểm tra | Admin | Tạo câu hỏi bài tập cho từ vựng trong Topic. |
| **U26** | Xem danh sách câu hỏi theo từ | Admin | Tra cứu các câu hỏi kiểm tra gắn liền với từ vựng cụ thể. |
| **U27** | Chỉnh sửa câu hỏi kiểm tra | Admin | Cập nhật nội dung câu hỏi bài tập. |
| **U28** | Xóa câu hỏi kiểm tra | Admin | Xóa câu hỏi bài tập khỏi hệ thống. |

---

## 4. Đặc tả chi tiết Use Case – Phân hệ Người học (Learner)

### U06: Học từ vựng qua Flashcard

* **Use Case ID:** `U06`
* **Tên Use Case:** Học từ vựng qua Flashcard
* **Actor chính:** Người học
* **Tóm tắt chức năng:** Cung cấp trải nghiệm học từ vựng tương tác thông qua thẻ Flashcard 2 mặt chứa đầy đủ phiên âm, phát âm, hình ảnh minh họa và câu ví dụ ngữ cảnh.
* **Tiền điều kiện (Pre-conditions):** Người học đã đăng nhập; đã chọn Topic có từ vựng cần học.
* **Hậu điều kiện (Post-conditions):** Trạng thái từ vựng được cập nhật sang "Đã học" và được đưa vào ngân hàng từ cần ôn tập/kiểm tra định kỳ.

#### Luồng sự kiện chính (Main Flow)
1. Tại Trang chủ, người dùng chọn mục **Học từ vựng theo chủ đề**.
2. Hệ thống hiển thị danh sách các **Lesson** lớn.
3. Người dùng chọn một **Lesson**; hệ thống hiển thị danh sách các **Topic** thuộc Lesson đó.
4. Người dùng chọn một **Topic** muốn học.
5. Hệ thống hiển thị lần lượt từng thẻ Flashcard:
   - **Mặt trước:** Từ tiếng Anh, phiên âm quốc tế (IPA), nút phát âm thanh chuẩn (Audio), hình ảnh minh họa.
   - **Mặt sau:** Nghĩa tiếng Việt, từ loại (noun, verb, adj,...), câu ví dụ ngữ cảnh có chứa từ đó.
6. Người dùng nhấn vào Flashcard để lật qua lại giữa 2 mặt.
7. Người dùng nhấn nút **Tiếp theo** để chuyển sang từ tiếp theo trong Topic (chuẩn 10 từ/Topic).
8. Sau khi hoàn thành toàn bộ thẻ trong Topic, hệ thống thông báo hoàn thành. Người dùng nhấn **Tiếp tục** để chọn Topic khác hoặc làm bài kiểm tra củng cố.

#### Luồng phụ / Luồng thay thế (Alternative Flow)
* **2a - Tiếp tục chủ đề dở dang:** Nếu người dùng có các Topic đang học dở dang, hệ thống sẽ ưu tiên ghim các Topic này lên đầu danh sách để người dùng bấm vào học tiếp ngay.

#### Điểm mở rộng / Ngoại lệ (Extension Points)
* **4.1 - Thoát giữa chừng:** Khi đang học, người dùng nhấn nút thoát hoặc đóng trình duyệt.
* **4.2 - Xác nhận thoát:** Hệ thống hiển thị popup: *"Bạn có chắc chắn muốn thoát?"* với 2 lựa chọn:
  * **Ở lại:** Đóng popup, người dùng tiếp tục học từ vựng hiện tại.
  * **Thoát:** Lưu lại tiến độ các từ đã học thành công trước đó và điều hướng người dùng về Trang chủ.

---

### U07: Bài kiểm tra trắc nghiệm ABCD

* **Use Case ID:** `U07`
* **Tên Use Case:** Bài kiểm tra trắc nghiệm ABCD
* **Actor chính:** Người học
* **Tóm tắt chức năng:** Đánh giá mức độ ghi nhớ từ vựng qua bài kiểm tra trắc nghiệm 4 lựa chọn (A, B, C, D) dựa trên định nghĩa, nghĩa tiếng Việt hoặc hình ảnh.
* **Tiền điều kiện:** Người dùng có từ vựng trong danh sách cần ôn tập.
* **Hậu điều kiện:** Cập nhật Memory Level (mức độ ghi nhớ) và thời gian ôn tập của từ tương ứng với kết quả trả lời.

#### Luồng sự kiện chính (Main Flow)
1. Tại Trang chủ, người dùng chọn chế độ **Ôn tập từ vựng**.
2. Giao diện ôn tập hiển thị câu hỏi (nghĩa tiếng Việt / câu hỏi ngữ cảnh / hình ảnh) cùng 4 lựa chọn đáp án tiếng Anh **A, B, C, D**.
3. Người dùng chọn 1 đáp án.
4. Hệ thống đối chiếu kết quả:
   - **Đáp án đúng:** Hiển thị popup thông báo màu xanh (chúc mừng trả lời đúng), cộng điểm/tăng Memory Level.
   - **Đáp án sai:** Hiển thị popup thông báo màu đỏ (thông báo sai, hiển thị lại thông tin chi tiết của từ vựng để ôn lại).
5. Người dùng nhấn nút **Tiếp tục** để chuyển sang câu hỏi tiếp theo trong chuỗi ôn tập.

#### Điểm mở rộng / Ngoại lệ (Extension Points)
* **6.1 - Người dùng nhấn nút Thoát:**
  * Hệ thống hiển thị popup *"Bạn có chắc chắn muốn thoát?"* gồm 2 nút: **Ở lại** và **Thoát và không lưu thay đổi**.
  * Chọn **Ở lại:** Tiếp tục làm bài tập hiện tại.
  * Chọn **Thoát:** Hủy kết quả phiên làm bài chưa hoàn tất, không cập nhật trạng thái mới và quay về trang trước đó.

---

### U08: Bài kiểm tra đoán từ (Word Guessing)

* **Use Case ID:** `U08`
* **Tên Use Case:** Bài kiểm tra đoán từ
* **Actor chính:** Người học
* **Tóm tắt chức năng:** Kiểm tra khả năng nhớ chính tả của từ vựng bằng cách đoán từng chữ cái hoặc đoán cả từ dựa trên gợi ý, có cơ chế giới hạn số lần sai qua số "Trái tim" (Lives).
* **Tiền điều kiện:** Người dùng có từ vựng cần ôn tập.
* **Hậu điều kiện:** Cập nhật trạng thái và mức độ ghi nhớ của từ vựng.

#### Luồng sự kiện chính (Main Flow)
1. Người dùng vào chế độ ôn tập từ vựng.
2. Giao diện hiển thị gợi ý (câu hỏi, nghĩa tiếng Việt hoặc hình ảnh) và các ký tự của từ vựng được ẩn dưới dạng dấu gạch dưới `_ _ _ _`.
3. Hệ thống cấp **3 trái tim** (cho phép người dùng đoán sai tối đa 2 lần).
4. Người dùng nhập từng ký tự hoặc nhập trực tiếp toàn bộ từ.
5. Hệ thống xử lý:
   - **Đúng:** Ký tự/từ hiển thị đầy đủ, xuất hiện popup màu xanh xác nhận trả lời đúng.
   - **Sai:** Trừ 1 trái tim.
     - Nếu số tim > 0: Người dùng tiếp tục đoán.
     - Nếu số tim = 0: Xuất hiện popup màu đỏ thông báo thất bại, hiển thị từ vựng đúng để người dùng ghi nhớ lại.
6. Người dùng nhấn **Tiếp tục** để làm câu hỏi tiếp theo.

#### Điểm mở rộng / Ngoại lệ
* **Xác nhận thoát:** Popup xác nhận thoát giữa chừng tương tự như U07 (Ở lại / Thoát không lưu).

---

### U09: Bài kiểm tra nghe phát âm (Listening / Dictation)

* **Use Case ID:** `U09`
* **Tên Use Case:** Bài kiểm tra nghe phát âm
* **Actor chính:** Người học
* **Tóm tắt chức năng:** Rèn luyện và kiểm tra kỹ năng nghe - nhận diện từ bằng cách nghe phát âm audio chuẩn và gõ lại chính xác từ vựng vào ô nhập liệu.
* **Tiền điều kiện:** Người dùng có từ vựng cần ôn tập; thiết bị có hỗ trợ âm thanh.
* **Hậu điều kiện:** Cập nhật Memory Level và lịch sử học tập.

#### Luồng sự kiện chính (Main Flow)
1. Người dùng vào chế độ ôn tập từ vựng.
2. Giao diện hiển thị nút Audio (Loa) để người dùng bấm nghe phát âm của từ vựng (cho phép nghe lại nhiều lần).
3. Người dùng gõ toàn bộ từ vựng nghe được vào ô nhập liệu và nhấn xác nhận.
4. Hệ thống so khớp từ nhập vào với đáp án:
   - **Đúng:** Popup xanh (chính xác).
   - **Sai:** Popup đỏ (sai, hiển thị từ đúng, phiên âm và nghĩa).
5. Người dùng nhấn **Tiếp tục** để chuyển sang câu tiếp theo.

#### Điểm mở rộng / Ngoại lệ
* **Xác nhận thoát:** Popup xác nhận thoát giữa chừng tương tự như U07.

---

### U10: Bài kiểm tra sắp xếp từ (Word Scramble)

* **Use Case ID:** `U10`
* **Tên Use Case:** Bài kiểm tra sắp xếp từ
* **Actor chính:** Người học
* **Tóm tắt chức năng:** Kiểm tra phản xạ cấu trúc từ vựng bằng cách yêu cầu người dùng sắp xếp các chữ cái bị xáo trộn ngẫu nhiên thành từ vựng hoàn chỉnh.
* **Tiền điều kiện:** Người dùng có từ vựng cần ôn tập.
* **Hậu điều kiện:** Cập nhật điểm số và Memory Level của từ vựng.

#### Luồng sự kiện chính (Main Flow)
1. Người dùng vào chế độ ôn tập từ vựng.
2. Giao diện hiển thị gợi ý (nghĩa/hình ảnh) cùng danh sách các chữ cái của từ bị xáo trộn ngẫu nhiên.
3. Người dùng thao tác kéo-thả hoặc nhấp chọn các chữ cái theo đúng thứ tự chính tả.
4. Hệ thống kiểm tra kết quả:
   - **Đúng:** Popup xanh báo thành công.
   - **Sai:** Popup đỏ báo sai và hiển thị đáp án đúng.
5. Người dùng nhấn **Tiếp tục** để thực hiện câu tiếp theo.

#### Điểm mở rộng / Ngoại lệ
* **Xác nhận thoát:** Popup xác nhận thoát giữa chừng tương tự như U07.

---

### U11: Lịch sử thời gian học (Study Streak & History)

* **Use Case ID:** `U11`
* **Tên Use Case:** Lịch sử thời gian học
* **Actor chính:** Người học
* **Tóm tắt chức năng:** Cho phép người dùng theo dõi tính chuyên cần thông qua giao diện lịch biểu ghi nhận các ngày đã học và số ngày học liên tục (Streak).
* **Tiền điều kiện:** Người dùng đã đăng nhập thành công; đã học ít nhất 1 ngày trên hệ thống.
* **Hậu điều kiện:** Người dùng nắm được tiến độ chuyên cần của bản thân.

#### Luồng sự kiện chính (Main Flow)
1. Tại Trang chủ, người dùng chọn mục **Lịch sử**.
2. Trong menu Lịch sử, chọn tab **Lịch sử ngày học**.
3. Hệ thống hiển thị giao diện lịch (Calendar View) trực quan:
   - Đánh dấu các ngày người dùng có phát sinh hoạt động học tập.
   - Hiển thị tổng số ngày đã học và chuỗi ngày học liên tục (Current Streak / Best Streak).

---

### U12: Lịch sử làm bài kiểm tra (Quiz History)

* **Use Case ID:** `U12`
* **Tên Use Case:** Lịch sử làm bài kiểm tra
* **Actor chính:** Người học
* **Tóm tắt chức năng:** Cho phép người dùng xem lại danh sách tất cả các bài kiểm tra đã làm kèm điểm số, thời gian làm bài và hỗ trợ làm lại bài kiểm tra.
* **Tiền điều kiện:** Người dùng đã đăng nhập; đã hoàn thành ít nhất 1 bài kiểm tra.
* **Hậu điều kiện:** Hiển thị chi tiết kết quả bài kiểm tra; cập nhật điểm mới nếu người dùng làm lại bài.

#### Luồng sự kiện chính (Main Flow)
1. Tại Trang chủ, người dùng chọn mục **Lịch sử** ➔ chọn tab **Lịch sử bài kiểm tra**.
2. Hệ thống hiển thị danh sách các bài kiểm tra đã thực hiện, sắp xếp theo thứ tự từ mới nhất đến cũ nhất.
3. Người dùng nhấp vào từng bài kiểm tra để xem chi tiết danh sách câu hỏi, câu trả lời đúng/sai và điểm số tổng kết.

#### Luồng thay thế (Alternative Flow)
* **1a - Truy cập từ danh mục bài học:** Người dùng vào mục **Học theo Chương** ➔ chọn bài **Kiểm tra** ➔ chọn nút **Lịch sử**.

#### Điểm mở rộng (Extension Points)
* **Làm lại bài kiểm tra:** Trong giao diện xem chi tiết bài kiểm tra đã làm, người dùng có thể bấm nút **Làm lại** (Retake) để cải thiện điểm số.

---

### U13: Danh sách từ đã học (Learned Vocabulary)

* **Use Case ID:** `U13`
* **Tên Use Case:** Danh sách từ đã học
* **Actor chính:** Người học
* **Tóm tắt chức năng:** Quản lý kho từ vựng cá nhân, phân loại từ theo cấp độ ghi nhớ (*Memory Level*) từ mới học đến thành thạo.
* **Tiền điều kiện:** Người dùng đã đăng nhập; đã học ít nhất 1 từ vựng.
* **Hậu điều kiện:** Hiển thị đầy đủ danh sách từ đã học kèm cấp độ ghi nhớ.

#### Luồng sự kiện chính (Main Flow)
1. Tại Trang chủ, người dùng chọn mục **Từ vựng của bạn**.
2. Hệ thống hiển thị danh sách toàn bộ từ vựng đã học, được phân loại và sắp xếp theo các mức độ ghi nhớ (*Memory Level*: Mới học, Đang ghi nhớ, Đã thuộc, Thành thạo).

---

### U14: Tìm từ trong danh sách từ đã học

* **Use Case ID:** `U14`
* **Tên Use Case:** Tìm từ trong danh sách từ đã học
* **Actor chính:** Người học
* **Tóm tắt chức năng:** Cung cấp công cụ tìm kiếm nhanh từ vựng trong kho từ cá nhân.
* **Tiền điều kiện:** Người dùng đã đăng nhập; đã có từ vựng trong kho từ đã học.
* **Hậu điều kiện:** Hiển thị danh sách từ vựng khớp với từ khóa tìm kiếm.

#### Luồng sự kiện chính (Main Flow)
1. Tại mục **Từ vựng của bạn**, người dùng nhập từ khóa cần tìm vào ô tìm kiếm (Search Box).
2. Hệ thống tự động lọc và hiển thị danh sách các từ vựng khớp hoặc gần khớp với từ khóa nhập vào (tìm theo từ tiếng Anh hoặc nghĩa tiếng Việt).

#### Luồng phụ / Ngoại lệ
* **Không tìm thấy kết quả:** Nếu từ khóa gõ sai hoặc từ chưa từng học, hệ thống hiển thị thông báo: *"Không tìm thấy từ vựng phù hợp trong danh sách đã học"*.

---

### U15: Lọc / Loại bỏ từ khỏi bài ôn tập

* **Use Case ID:** `U15`
* **Tên Use Case:** Lọc từ muốn học / Tùy chỉnh danh sách ôn tập
* **Actor chính:** Người học
* **Tóm tắt chức năng:** Cho phép người dùng đánh dấu hoặc loại bỏ từ vựng ra khỏi danh sách ôn tập định kỳ hàng ngày để tập trung vào các từ khó hoặc từ hay làm sai.
* **Tiền điều kiện:** Người dùng đã đăng nhập; có từ vựng trong danh sách đã học.
* **Hậu điều kiện:** Từ được chọn sẽ bị loại khỏi danh sách ôn tập/kiểm tra định kỳ hàng ngày.

#### Luồng sự kiện chính (Main Flow)
1. Tại Trang chủ, người dùng vào mục **Từ vựng của bạn**.
2. Người dùng nhấp vào từ vựng cụ thể cần tùy chỉnh.
3. Người dùng chọn biểu tượng/nút **Xóa khỏi ôn tập hàng ngày**.
4. Hệ thống cập nhật trạng thái của từ. Khi xem danh sách hoặc thực hiện bài kiểm tra hàng ngày, từ này sẽ không xuất hiện nữa.

---

## 5. Đặc tả chi tiết Use Case – Phân hệ Quản trị viên (Admin)

### U16: Thêm Lesson mới

* **Use Case ID:** `U16`
* **Tên Use Case:** Thêm Lesson
* **Actor chính:** Admin
* **Tóm tắt chức năng:** Cho phép Admin tạo một Lesson (chương học lớn) mới cho hệ thống.
* **Tiền điều kiện:** Tài khoản đăng nhập là Admin và có quyền quản lý nội dung.
* **Hậu điều kiện:** Lesson mới được tạo và hiển thị trong danh mục quản lý Lesson.

#### Luồng sự kiện chính (Main Flow)
1. Admin nhấp vào nút **Thêm Lesson** trên thanh điều hướng (Navbar).
2. Hệ thống chuyển sang giao diện form tạo Lesson.
3. Admin nhập **Tên Lesson** và **Mô tả** cho Lesson.
4. Admin nhấn nút **Lưu** để xác nhận tạo Lesson mới.
5. Hệ thống lưu dữ liệu và thông báo tạo thành công.

#### Luồng phụ / Luồng thay thế (Alternative Flow)
* **5a - Trùng tên Lesson:** Nếu tên Lesson đã tồn tại trong hệ thống, hệ thống hiển thị thông báo lỗi: *"Tên Lesson đã tồn tại, vui lòng chọn tên khác."*
* **Hủy thao tác:** Admin có thể nhấn nút **Hủy** bất kỳ lúc nào để dừng việc tạo Lesson mà không lưu dữ liệu.

#### Điểm mở rộng (Extension Points)
* Sau khi tạo Lesson thành công, hệ thống tự động gợi ý chuyển hướng sang màn hình **Thêm Topic** cho Lesson vừa tạo.

---

### U17: Thêm Topic mới

* **Use Case ID:** `U17`
* **Tên Use Case:** Thêm chủ đề (Topic)
* **Actor chính:** Admin
* **Tóm tắt chức năng:** Cho phép Admin tạo một Topic mới thuộc một Lesson cụ thể.
* **Tiền điều kiện:** Đăng nhập tài khoản Admin; Lesson cha đã tồn tại.
* **Hậu điều kiện:** Topic mới xuất hiện trong danh sách chủ đề của Lesson tương ứng.

#### Luồng sự kiện chính (Main Flow)
1. Admin nhấn vào nút **Thêm chủ đề** trên Navbar hoặc trong trang chi tiết Lesson.
2. Hệ thống chuyển sang giao diện thêm Topic.
3. Admin chọn Lesson trực thuộc, nhập **Tên chủ đề** và **Mô tả** chủ đề.
4. Admin nhấn nút **Lưu** để tạo chủ đề mới.
5. Hệ thống lưu dữ liệu và hiển thị Topic trong danh sách.

#### Luồng phụ / Luồng thay thế
* **5a - Trùng tên Topic:** Báo lỗi nếu tên Topic bị trùng trong cùng Lesson.
* **Hủy thao tác:** Bấm nút **Hủy** để hủy bỏ việc tạo chủ đề.

#### Điểm mở rộng
* Sau khi tạo Topic thành công, hệ thống tự động chuyển sang giao diện **Thêm từ vựng** cho Topic vừa tạo.

---

### U18: Thêm từ vựng vào Topic

* **Use Case ID:** `U18`
* **Tên Use Case:** Thêm từ vào chủ đề
* **Actor chính:** Admin
* **Tóm tắt chức năng:** Thêm một từ vựng mới kèm đầy đủ thông tin ngữ nghĩa và tệp đa phương tiện (ảnh, audio phát âm) vào Topic có sẵn.
* **Tiền điều kiện:** Đăng nhập tài khoản Admin; Topic đã tồn tại trong hệ thống.
* **Hậu điều kiện:** Từ vựng mới xuất hiện trong danh sách từ của Topic.

#### Luồng sự kiện chính (Main Flow)
1. Tại trang quản trị, Admin chọn một Topic từ **Danh sách chủ đề**.
2. Hệ thống hiển thị chi tiết thông tin Topic (Tên, mô tả, số từ hiện có, danh sách từ và danh sách bài kiểm tra).
3. Admin nhấn nút **Thêm từ**.
4. Hệ thống chuyển sang form thêm từ vựng.
5. Admin điền các trường thông tin:
   - Từ tiếng Anh (Word).
   - Nghĩa tiếng Việt (Meaning).
   - Từ loại (Part of Speech: Noun, Verb, Adj, Adv,...).
   - Phiên âm quốc tế (Phonetics / IPA).
   - Câu ví dụ tiếng Anh có chứa từ (Example sentence).
6. Admin tải lên tệp tin:
   - Tải lên hình ảnh minh họa (Image Upload).
   - Tải lên tệp âm thanh phát âm (Audio Upload).
7. Admin nhấn nút **Lưu từ vựng**.
8. Hệ thống xác thực và lưu từ vựng vào cơ sở dữ liệu.

#### Luồng phụ / Luồng thay thế
* **10a - Trùng từ vựng:** Nếu từ vựng đã tồn tại trong Topic, hệ thống báo lỗi: *"Từ vựng này đã tồn tại trong chủ đề."*
* **10b - Thiếu trường bắt buộc:** Nếu bỏ trống bất kỳ trường bắt buộc nào (Từ, Nghĩa, Audio, Ảnh), hệ thống báo lỗi yêu cầu nhập đầy đủ.
* **Hủy thao tác:** Bấm nút **Hủy** để dừng thêm từ.

---

### U21: Chỉnh sửa Topic

* **Use Case ID:** `U21`
* **Tên Use Case:** Chỉnh sửa chủ đề
* **Actor chính:** Admin
* **Tóm tắt chức năng:** Cập nhật thông tin mô tả của Topic, quản lý xóa từ vựng hoặc xóa bài kiểm tra thuộc Topic đó.
* **Tiền điều kiện:** Đăng nhập tài khoản Admin; Topic đã tồn tại.
* **Hậu điều kiện:** Dữ liệu Topic được cập nhật trên toàn hệ thống.

#### Luồng sự kiện chính (Main Flow)
1. Tại trang quản trị, Admin chọn mục **Chỉnh sửa chủ đề**.
2. Chọn Topic cần chỉnh sửa ➔ nhấn nút **Chỉnh sửa**.
3. Hệ thống hiển thị chi tiết Topic: tên, mô tả, danh sách từ vựng kèm nút xóa từng từ, danh sách bài kiểm tra kèm nút xóa từng bài.
4. Admin thực hiện các chỉnh sửa:
   - Sửa lại tên hoặc mô tả của Topic.
   - Xóa bớt từ vựng không phù hợp bằng nút **Xóa** bên cạnh từ.
   - Xóa bài kiểm tra bằng nút **Xóa** bên cạnh bài kiểm tra tương ứng.
5. Admin nhấn nút **Lưu** để áp dụng toàn bộ thay đổi.

#### Luồng phụ / Ngoại lệ
* **Hủy thao tác:** Admin bấm nút **Hủy**, hệ thống sẽ hủy bỏ toàn bộ thay đổi vừa chỉnh sửa.

---

### U22: Xóa Topic

* **Use Case ID:** `U22`
* **Tên Use Case:** Xóa chủ đề
* **Actor chính:** Admin
* **Tóm tắt chức năng:** Xóa bỏ một Topic và toàn bộ dữ liệu từ vựng, câu hỏi bài tập liên quan ra khỏi hệ thống.
* **Tiền điều kiện:** Đăng nhập tài khoản Admin; Topic đã tồn tại.
* **Hậu điều kiện:** Topic biến mất khỏi danh sách quản lý và danh mục bài học của người dùng.

#### Luồng sự kiện chính (Main Flow)
1. Admin vào mục **Chỉnh sửa chủ đề** ➔ chọn Topic cần xóa ➔ nhấn **Chỉnh sửa**.
2. Admin nhấn nút **Xóa chủ đề**.
3. Hệ thống hiển thị popup cảnh báo: *"Bạn có chắc chắn muốn xóa chủ đề này và toàn bộ nội dung bên trong?"* với 2 nút **Có** và **Không**.
4. Admin nhấn **Có**.
5. Hệ thống thực hiện xóa Topic cùng các từ vựng và bài kiểm tra trực thuộc, sau đó điều hướng về danh sách chủ đề.

#### Luồng phụ / Ngoại lệ
* **5a - Hủy xóa:** Admin nhấn **Không**, popup đóng lại và Topic được giữ nguyên.

---

### U25: Thêm câu hỏi cho bài kiểm tra

* **Use Case ID:** `U25`
* **Tên Use Case:** Thêm câu hỏi cho bài kiểm tra (Tạo câu hỏi ABCD / Điền từ)
* **Actor chính:** Admin
* **Tóm tắt chức năng:** Tạo câu hỏi kiểm tra cho từ vựng trong Topic (dạng câu trắc nghiệm ngữ cảnh hoặc điền từ vào chỗ trống).
* **Tiền điều kiện:** Đăng nhập quyền Admin; từ vựng mục tiêu đã tồn tại trong Topic.
* **Hậu điều kiện:** Câu hỏi kiểm tra được ghi nhận vào hệ thống và tích hợp vào chuỗi bài kiểm tra của Topic.

#### Luồng sự kiện chính (Main Flow)
1. Sau khi thêm từ vựng vào Topic (hoặc từ trang **Chỉnh sửa chủ đề**), Admin nhấn nút **Thêm bài tập**.
2. Giao diện cấu hình câu hỏi hiển thị danh sách từ vựng trong Topic.
3. Admin chọn từ vựng mục tiêu, sau đó:
   - Nhập câu tiếng Anh hoàn chỉnh có chứa từ vựng đó.
   - Chọn/bôi đen vị trí của từ vựng để tạo thành chỗ trống cần điền (`____`).
   - Cấu hình các phương án nhiễu (distractors) nếu là câu trắc nghiệm ABCD.
4. Admin có thể thêm 1 hoặc nhiều câu hỏi kiểm tra cho mỗi từ vựng.
5. Admin nhấn nút **Lưu** để lưu toàn bộ câu hỏi vào hệ thống.

#### Luồng thay thế / Ngoại lệ
* **1a - Truy cập từ danh sách chủ đề:** Tại Trang chủ, Admin chọn **Chỉnh sửa chủ đề** ➔ chọn Topic ➔ chọn **Chỉnh sửa** ➔ chọn **Thêm bài tập**.
* **Thoát chế độ tạo câu hỏi:**
  * Bấm nút thoát: Hệ thống hiện popup *"Lưu thay đổi?"* với 2 nút: **Lưu** (lưu dữ liệu đã tạo) và **Không lưu** (hủy bỏ dữ liệu vừa tạo trên giao diện).

---

### U27: Chỉnh sửa câu hỏi bài kiểm tra

* **Use Case ID:** `U27`
* **Tên Use Case:** Chỉnh sửa bài kiểm tra / câu hỏi
* **Actor chính:** Admin
* **Tóm tắt chức năng:** Cập nhật nội dung câu hỏi, câu ví dụ hoặc vị trí khuyết từ trong bài tập kiểm tra.
* **Tiền điều kiện:** Đăng nhập quyền Admin; câu hỏi bài tập đã tồn tại trong hệ thống.
* **Hậu điều kiện:** Nội dung chỉnh sửa của câu hỏi được cập nhật vào cơ sở dữ liệu.

#### Luồng sự kiện chính (Main Flow)
1. Tại trang quản trị, Admin chọn mục **Chỉnh sửa chủ đề** ➔ chọn Topic ➔ chọn **Chỉnh sửa**.
2. Giao diện quản lý bài tập hiển thị danh sách câu hỏi kiểm tra theo từng từ vựng.
3. Admin chọn câu hỏi muốn sửa và tiến hành chỉnh sửa nội dung (sửa câu tiếng Anh, vị trí từ, nghĩa,...).
4. Admin nhấn nút **Lưu** để cập nhật câu hỏi vào hệ thống.

#### Điểm mở rộng / Ngoại lệ
* **Thoát chế độ sửa:** Bấm thoát sẽ xuất hiện popup *"Lưu thay đổi?"* với tùy chọn **Lưu** hoặc **Không lưu**.

---

### U28: Xóa câu hỏi bài kiểm tra

* **Use Case ID:** `U28`
* **Tên Use Case:** Xóa câu hỏi kiểm tra
* **Actor chính:** Admin
* **Tóm tắt chức năng:** Xóa bỏ câu hỏi bài tập của từ vựng ra khỏi hệ thống.
* **Tiền điều kiện:** Đăng nhập quyền Admin; câu hỏi bài tập đã tồn tại.
* **Hậu điều kiện:** Câu hỏi bài tập bị xóa hoàn toàn khỏi cơ sở dữ liệu.

#### Luồng sự kiện chính (Main Flow)
1. Tại trang quản trị, Admin chọn **Chỉnh sửa chủ đề** ➔ chọn Topic ➔ chọn **Chỉnh sửa**.
2. Giao diện hiển thị danh mục bài tập của các từ vựng trong Topic.
3. Admin chọn câu hỏi bài tập cần xóa và nhấn nút **Xóa**.
4. Admin nhấn nút **Lưu** để xác nhận xóa khỏi hệ thống.
5. Sau khi xóa, Admin có thể tiếp tục thêm câu hỏi mới hoặc chỉnh sửa các câu hỏi khác trong cùng chủ đề.

#### Điểm mở rộng / Ngoại lệ
* **Xác nhận lưu thay đổi:** Bấm nút thoát sẽ có popup xác nhận **Lưu** (xác nhận xóa) hoặc **Không lưu** (giữ nguyên câu hỏi).

---

## 6. Quy tắc nghiệp vụ & Ràng buộc dữ liệu

### 6.1. Cấu trúc và Phân cấp dữ liệu
1. **Phân cấp nội dung:** `1 Lesson` chứa $N$ `Topic` ($N \ge 1$); `1 Topic` chuẩn hóa gồm đúng $10$ `Vocabulary` để đảm bảo thời lượng và khả năng tiếp thu của người học.
2. **Dữ liệu từ vựng (Vocabulary Entity):** Mỗi từ vựng bắt buộc phải có đầy đủ:
   - `word` (Từ tiếng Anh)
   - `meaning` (Nghĩa tiếng Việt)
   - `part_of_speech` (Từ loại)
   - `phonetic` (Phiên âm chuẩn IPA)
   - `audio_url` (File phát âm chuẩn giọng bản xứ)
   - `image_url` (Hình ảnh minh họa trực quan)
   - `example_sentence` (Câu ví dụ minh họa ngữ cảnh)

### 6.2. Thuật toán đánh giá & Cấp độ ghi nhớ (Memory Level)
- Từ vựng mới học bắt đầu ở **Level 1 (Mới học)**.
- Trả lời đúng trong các bài kiểm tra (ABCD, Guess Word, Dictation, Scramble) sẽ tăng dần Memory Level: $	ext{Level 1} 	o 	ext{Level 2 (Đang nhớ)} 	o 	ext{Level 3 (Đã thuộc)} 	o 	ext{Level 4 (Thành thạo)}$.
- Trả lời sai sẽ bị giảm Memory Level và tự động đưa từ vào danh sách **Ưu tiên ôn tập lại**.

### 6.3. Cơ chế Streak & Điểm danh
- Hoạt động học tập hợp lệ trong ngày (hoàn thành ít nhất 1 Topic Flashcard hoặc 1 bài Kiểm tra) sẽ kích hoạt tăng `1 Streak`.
- Nếu bỏ lỡ một ngày không học, `Current Streak` sẽ được reset về 0 (trong khi `Best Streak` vẫn được lưu giữ).
