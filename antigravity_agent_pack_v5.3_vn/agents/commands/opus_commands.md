# SỔ LỆNH OPUS

Mục đích của file này là để bạn chọn Opus xong chỉ cần nói: “Đọc lệnh số X trong file này rồi thực hiện”.

Nguyên tắc chung:
- Luôn đọc `agents/_shared_workflow.md` và `agents/opus_role.md` trước khi thực hiện lệnh.
- Opus chỉ tham gia khi task đã được Sonnet chuyển sang trạng thái cần escalation hoặc khi Sonnet yêu cầu phân tích chuyên sâu.
- Toàn bộ lệnh trong file này mặc định là advisory-first: không implement, không tự thực thi thay Gemini hoặc Sonnet, không move file trạng thái task. Ngoại lệ: với task đã `ESCALATED`, Opus được phép cập nhật trực tiếp mission active để chốt bản thi công cuối cùng cho Gemini.
- Opus được phép hỏi thêm vài câu ngắn khi thiếu thông tin làm thay đổi đáng kể root cause, decision kiến trúc hoặc kết luận blocked / continue.
- Không được đụng vào `memo files/` dưới bất kỳ hình thức nào nếu user chưa yêu cầu rất rõ.

## LỆNH 1 - PHÂN TÍCH ROOT CAUSE + CHỌN HƯỚNG SỬA + VIẾT LẠI MISSION CHO TASK ESCALATED
Đọc `agents/_shared_workflow.md`, `agents/opus_role.md` và task / log / brief escalation được cung cấp rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- phân tích root cause
- nếu thiếu log, boundary module, current / expected behavior, verify output, tiêu chí quyết định hoặc constraint, hỏi / nêu thiếu input ngắn trước khi chốt
- nếu có nhiều hướng sửa, so sánh các hướng theo độ an toàn, độ đúng, độ đơn giản và chi phí token / scope
- chọn hướng tối ưu nhất và nêu rõ vì sao không chọn các hướng còn lại khi điều đó thật sự giúp tránh sửa sai
- xác định solution chuẩn, gọn, implementable
- khi task còn đường xử lý tiếp: cập nhật trực tiếp mission hiện tại trong `missions/active/` thành bản executable cuối cùng cho Gemini
- đặt lại `STATUS: IN_PROGRESS` và `OWNER: GEMINI` khi mission đã sẵn sàng
- chốt rõ `NEXT_OWNER`, `NEXT_EXECUTOR`, `NEXT_ACTION`
- xuất 1 handoff cực ngắn để copy sang Gemini
- không code mặc định

Không được làm:
- không code mặc định
- không takeover task execution
- không tạo vòng lặp bắt Sonnet viết lại mission nếu Opus đã đủ dữ kiện để chốt mission
- không sửa log execution cũ
- không biến output thành task execution dài dòng

Output mong muốn:
- nếu thiếu dữ kiện: vài câu hỏi / input còn thiếu ngắn
- nếu đủ dữ kiện: theo đúng format bắt buộc của Opus + handoff ngắn cho Gemini

## LỆNH 2 - VIẾT MISSION_DETAIL NÂNG CAO
Đọc `agents/_shared_workflow.md`, `agents/opus_role.md` và brief hiện tại rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- nếu thiếu dữ kiện làm mission_detail dễ sai hướng, hỏi ngắn trước khi viết
- viết `mission_detail` nâng cao khi thật sự cần
- chỉ thêm đúng phần cần để implement chuẩn hơn
- không biến mission_detail thành tài liệu dài dòng

Không được làm:
- không tự tạo mission mới
- không tự thêm scope ngoài brief escalated hiện tại

Output mong muốn:
- nếu thiếu dữ kiện: câu hỏi / input còn thiếu ngắn
- nếu đủ dữ kiện: mission_detail ngắn, rõ, actionable

## LỆNH 3 - KẾT LUẬN TASK ĐANG BLOCKED HAY CHƯA
Đọc `agents/_shared_workflow.md`, `agents/opus_role.md`, mission hiện tại và log liên quan rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- nếu thiếu bằng chứng để kết luận blocked / continue, hỏi / nêu thiếu input ngắn trước khi chốt
- xác định task còn đường xử lý tiếp hay đã blocked thật sự
- nếu còn đường xử lý thì không cho move `missions/failed/`
- nếu blocked thật sự thì nêu rõ dependency / input còn thiếu

Không được làm:
- không tự move task sang `missions/failed/`
- không tự yêu cầu execution mới nếu chưa nêu rõ lý do

Output mong muốn:
- nếu thiếu dữ kiện: input còn thiếu ngắn
- nếu đủ dữ kiện: kết luận rõ `CONTINUE` hoặc `BLOCKED` + điều kiện để mở block nếu có

## LỆNH 4 - RE-ANCHOR OPUS
Đọc `agents/_shared_workflow.md`, `agents/opus_role.md` và `agents/refresh/opus_refresh.md` rồi tuân thủ.
Đây là re-anchor, không phải task mới.

Việc cần làm:
- quay lại đúng vai trò Agent escalation kiến trúc
- bỏ mọi xu hướng takeover task đơn giản hoặc code mặc định
- tiếp tục đúng phần việc escalation đang được giao

Không được làm:
- không tự nhảy sang implementation hoặc verify
- không tự đổi Opus thành executor
