# SỔ LỆNH GEMINI

Mục đích của file này là để bạn chọn Gemini xong chỉ cần nói: “Đọc lệnh số X trong file này rồi thực hiện”.

Nguyên tắc chung:
- Luôn đọc `agents/_shared_workflow.md` và `agents/gemini_role.md` trước khi thực hiện lệnh.
- Luôn đọc đúng mission file được chỉ định.
- Không tự mở rộng scope.
- Không được đụng `memo files/` dưới bất kỳ hình thức nào nếu user chưa yêu cầu rất rõ.
- Chỉ được xoá file test / file rác khi thỏa rule cleanup an toàn.
- Ưu tiên cleanup các candidate khớp `agents/SAFE_DELETE_ALLOWLIST_PATTERNS.md`; ngoài allowlist thì mặc định thận trọng hơn.
- Khi xong lượt làm việc, Gemini chỉ được báo `EXECUTION_DONE`, không được tự báo `DONE`.

## LỆNH 1 - THỰC THI MISSION
Đọc `agents/_shared_workflow.md`, `agents/gemini_role.md` và file mission được chỉ định rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- thực thi đúng mission
- chỉ sửa file trong `FILES` hoặc file liên quan trực tiếp
- ưu tiên diff nhỏ
- ghi log đúng format vào `LOG_PATH`
- nhắc lại `LOG_PATH` trong phản hồi chat
- nếu execution đã xong, dùng `[STATUS]: EXECUTION_DONE`
- dọn file test tạm nếu và chỉ nếu thỏa cleanup rule an toàn

Output mong muốn:
- kết quả theo format log / phản hồi chuẩn
- tuyệt đối không tự kết luận task đã `DONE`

## LỆNH 2 - RETRY THEO HƯỚNG DẪN MỚI
Đọc `agents/_shared_workflow.md`, `agents/gemini_role.md`, mission hiện tại và phần Sonnet writeback / retry mới nhất trong mission rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- thực hiện retry theo hướng dẫn mới nhất của Sonnet trong mission hiện tại
- đổi cách xử lý thực sự
- chạy lại verify
- cập nhật `FAILURE_SIGNATURE` nếu lỗi đã đổi bản chất
- ghi log đúng format vào `LOG_PATH`
- nhắc lại `LOG_PATH` trong phản hồi chat
- nếu execution đã xong, dùng `[STATUS]: EXECUTION_DONE`
- dọn file test tạm nếu và chỉ nếu thỏa cleanup rule an toàn

Output mong muốn:
- log `FAIL` hoặc `EXECUTION_DONE` đúng format
- nêu rõ `RETRY: 1/2` hoặc `2/2`

## LỆNH 3 - THỰC THI UI / STITCH MISSION
Đọc `agents/_shared_workflow.md`, `agents/gemini_role.md` và mission hiện tại rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- nếu mission có `STITCH_REQUIRED: YES` và `STITCH_EXECUTOR: GEMINI`:
  - Gemini là agent gọi stitch_loop
  - chạy stitch_loop bám đúng brief trong mission
  - ghi rõ `[MODE]: UI_STITCH_DESIGN` nếu đang ở `PHASE: DESIGN_GENERATION`
  - ghi rõ `[MODE]: UI_IMPLEMENT` nếu đang ở `PHASE: IMPLEMENTATION`
- nếu đang ở `PHASE: DESIGN_GENERATION`:
  - ưu tiên tạo design proposal / artifact / evidence
  - chưa tự nhảy sang implement production nếu mission chưa cho phép
- nếu đang ở `PHASE: IMPLEMENTATION`:
  - chỉ implement đúng theo output/decision đã được Sonnet khóa
- luôn ghi log đúng format vào `LOG_PATH`
- luôn nhắc lại `LOG_PATH` trong phản hồi chat
- nếu execution của pha hiện tại đã xong, dùng `[STATUS]: EXECUTION_DONE`
- không tự thiết kế lại UI ngoài brief
- dọn file test tạm nếu và chỉ nếu thỏa cleanup rule an toàn

Output mong muốn:
- log đúng format
- liệt kê file đã thay đổi hoặc artifact/evidence đã tạo
- nếu đang ở pha design thì phải có `[STITCH_STATUS]` và `[ARTIFACTS]`
- không tự dùng từ `DONE`

## LỆNH 4 - DỪNG VÀ BÁO FAIL SAU 2 RETRY
Đọc `agents/_shared_workflow.md`, `agents/gemini_role.md` và mission hiện tại rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- nếu đã fail 2 lần cùng `FAILURE_SIGNATURE`, dừng tiếp tục sửa
- ghi log rõ ràng vào `LOG_PATH`
- không tự escalate nếu Sonnet chưa yêu cầu
- trả lại thông tin ngắn để Sonnet quyết định bước tiếp theo

Output mong muốn:
- FAIL rõ ràng
- root cause giả thuyết ngắn
- next_hint ngắn cho Sonnet

## LỆNH 5 - RE-ANCHOR GEMINI
Đọc `agents/_shared_workflow.md`, `agents/gemini_role.md` và `agents/refresh/gemini_refresh.md` rồi tuân thủ.
Đây là re-anchor, không phải task mới.

Việc cần làm:
- quay lại đúng vai trò Agent thực thi
- bỏ mọi xu hướng mở scope, redesign solution, hoặc đụng file ngoài mission
- nhớ rằng với UI vừa/lớn, Gemini là agent gọi stitch_loop nếu mission yêu cầu
- luôn ghi file log vật lý + nhắc lại `LOG_PATH`
- chỉ được báo `EXECUTION_DONE` thay vì `DONE`
- tiếp tục task hiện tại trong phạm vi đã được giao
