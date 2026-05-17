# SỔ LỆNH SONNET

Mục đích của file này là để bạn chọn Claude Sonnet xong chỉ cần nói: “Đọc lệnh số X trong file này rồi thực hiện”.

Nguyên tắc chung:
- Luôn đọc `agents/_shared_workflow.md` và `agents/sonnet_role.md` trước khi thực hiện lệnh.
- Mỗi lệnh dưới đây là một “khung hành vi”. Task cụ thể vẫn phải được truyền ngắn gọn trong tin nhắn hiện tại.
- Đây là sổ lệnh. Không xem đây là task backlog.
- Trừ khi user ghi đè rất rõ rằng Sonnet phải tự code, toàn bộ lệnh trong file này mặc định là control-only: không được tự thực thi task của Gemini, không được nhập vai Gemini, không được tạo “retry mission” mới chỉ vì có retry, và không được sửa code ngoài phạm vi lệnh đang gọi.
- Sonnet được phép hỏi thêm vài câu ngắn khi thiếu thông tin làm thay đổi đáng kể mission, verify, root cause hoặc decision path. Không hỏi lại điều đã có. Không dùng hỏi thêm như cái cớ để takeover implementation.
- Không được đụng vào `memo files/` dưới bất kỳ hình thức nào nếu user chưa yêu cầu rất rõ.

## LỆNH 1 - KHỞI ĐỘNG TASK MỚI
Đọc `agents/_shared_workflow.md` và `agents/sonnet_role.md` rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- phân tích yêu cầu user
- làm rõ phạm vi, stack, constraint
- nếu còn thiếu thông tin trọng yếu, hỏi ngắn các câu cần thiết trước khi chốt mission
- tạo đúng 1 mission ngắn, rõ, executable trong `missions/active/`
- mọi mission phải có `LOG_PATH`
- mọi mission nên chừa chỗ cho `LAST_EXECUTION_STATUS`, `LAST_VERIFY_RESULT`, `NEXT_ACTION`, `SONNET_HANDOFF_FOR_GEMINI`
- chưa code mặc định
- chưa gọi Opus nếu chưa cần
- nếu task là UI vừa/lớn thì **route sang mission UI/STITCH cho Gemini**, không tự chạy Stitch-loop

Không được làm:
- không tự code hoặc tự sửa bug thay Gemini
- không tự thực thi mission sau khi tạo xong
- không tạo nhiều hơn 1 mission active mới

Output mong muốn:
- nếu chưa đủ dữ kiện: vài câu hỏi làm rõ ngắn, có thứ tự ưu tiên
- nếu đã đủ dữ kiện: tóm tắt ngắn yêu cầu + mission theo đúng format + lý do chọn BUG / FEATURE / REFACTOR / UI
- nếu là UI vừa/lớn thì nêu rõ sẽ để Gemini chạy stitch_loop

## LỆNH 2 - TẠO MISSION BUG
Đọc `agents/_shared_workflow.md` và `agents/sonnet_role.md` rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- đọc yêu cầu bug hiện tại
- nếu thiếu reproduction, expected behavior hoặc dấu hiệu pass, hỏi thêm ngắn trước khi chốt mission
- tạo mission loại BUG
- điền `FAILURE_SIGNATURE` rõ ràng
- đặt `RETRY_COUNT` đúng trạng thái hiện tại
- đặt `LAST_EXECUTION_STATUS: PENDING` và `LAST_VERIFY_RESULT: PENDING` khi khởi tạo mission mới
- `VERIFY` phải có command hoặc dấu hiệu pass thật
- mission phải có `LOG_PATH`

Không được làm:
- không tự sửa code hoặc verify thay bước của lệnh khác
- không tạo thêm mission retry tách riêng cho cùng bug nếu chỉ đang retry cùng task

Output mong muốn:
- nếu thiếu dữ kiện quan trọng: câu hỏi làm rõ ngắn
- nếu đủ dữ kiện: 1 mission BUG hoàn chỉnh để Gemini thực thi

## LỆNH 3 - TẠO MISSION FEATURE
Đọc `agents/_shared_workflow.md` và `agents/sonnet_role.md` rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- đọc yêu cầu tính năng hiện tại
- nếu còn mơ hồ về scope, UX, data flow hoặc acceptance criteria, hỏi ngắn trước khi tạo mission
- tạo mission loại FEATURE
- scope phải chặt
- `FILES` chỉ chứa file thật sự liên quan
- `VERIFY` phải xác định rõ cách kiểm tra feature đã hoạt động
- đặt `LAST_EXECUTION_STATUS: PENDING` và `LAST_VERIFY_RESULT: PENDING`
- mission phải có `LOG_PATH`

Không được làm:
- không tự implement feature
- không chia nhỏ thành nhiều mission nếu user chưa yêu cầu hoặc chưa thật sự cần

Output mong muốn:
- nếu thiếu dữ kiện: câu hỏi làm rõ ngắn
- nếu đủ dữ kiện: 1 mission FEATURE hoàn chỉnh để Gemini thực thi

## LỆNH 4 - TẠO MISSION UI / STITCH
Đọc `agents/_shared_workflow.md` và `agents/sonnet_role.md` rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- đánh giá đây có phải UI vừa/lớn không
- nếu còn mơ hồ về flow, layout, component state hoặc responsive behavior, hỏi ngắn trước khi chốt hướng
- nếu đúng, tạo mission UI/STITCH cho Gemini với các cờ tối thiểu:
  - `STITCH_REQUIRED: YES`
  - `STITCH_EXECUTOR: GEMINI`
  - `PHASE: DESIGN_GENERATION`
  - `IMPLEMENT_AFTER_SONNET_VERIFY: NO`
- mission phải có `LOG_PATH`
- mission nên có `LAST_EXECUTION_STATUS: PENDING` và `LAST_VERIFY_RESULT: PENDING`
- brief phải đủ để Gemini gọi stitch_loop đúng brief
- nếu UI nhỏ thì có thể tạo mission UI thường

Không được làm:
- không tự code toàn bộ UI trong lệnh này
- không tự chạy Stitch-loop trong lệnh này
- không giao luôn implementation production nếu thiết kế chưa được verify

Output mong muốn:
- nếu thiếu dữ kiện: câu hỏi làm rõ ngắn
- nếu đủ dữ kiện: mission UI/STITCH hoàn chỉnh để Gemini chạy stitch_loop
- nêu rõ Sonnet sẽ verify design sau khi Gemini ghi log/evidence

## LỆNH 5 - GỌI GEMINI THỰC THI
Đọc `agents/_shared_workflow.md` và `agents/sonnet_role.md` rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- đọc mission hiện tại
- chuẩn bị handoff cực ngắn cho Gemini
- chỉ gửi objective, files, failure_signature, constraints, acceptance criteria
- nhắc rõ `LOG_PATH`
- nhắc rõ Gemini chỉ được báo `EXECUTION_DONE`, không được tự chốt `DONE`
- nếu mission UI/STITCH thì hướng user gọi Gemini bằng lệnh 3
- nếu mission thường thì hướng user gọi Gemini bằng lệnh 1
- không gửi phân tích dài
- nhắc rõ Gemini không được đụng `memo files/`

Không được làm:
- không tự thực thi mission
- không thêm phân tích dài, không thêm kế hoạch ngoài mission

Output mong muốn:
- 1 brief ngắn để copy sang Gemini

## LỆNH 6 - VERIFY KẾT QUẢ GEMINI
Đọc `agents/_shared_workflow.md` và `agents/sonnet_role.md` rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- đọc `missions/active/...`
- đọc `LOG_PATH` trong mission hoặc `logs/execution/...`
- nếu thiếu log vật lý, thiếu bằng chứng verify hoặc thiếu current/expected behavior, hỏi / nêu thiếu input ngắn trước khi kết luận
- kiểm tra Gemini có làm đúng phạm vi mission không
- kiểm tra có bằng chứng verify khớp `VERIFY` không
- nếu là mission UI/STITCH ở `PHASE: DESIGN_GENERATION`, phải kiểm tra thêm:
  - thiết kế có bám brief không
  - có đủ khối màn hình / state / responsive / note chính chưa
  - đã đủ để lock design chưa
- nếu đủ thì cập nhật mission thành `STATUS: NEEDS_REVIEW` và `LAST_VERIFY_RESULT: PASS`
- nếu chưa đủ nhưng còn đường sửa thì **phải cập nhật lại chính mission hiện tại**:
  - `STATUS: IN_PROGRESS`
  - `LAST_VERIFY_RESULT: FAIL_UNVERIFIED` hoặc `FAIL`
  - `NEXT_ACTION: GEMINI_RETRY`
  - `SONNET_HANDOFF_FOR_GEMINI:` với root cause ngắn + fix + verify + why not opus yet
- chưa move `done` nếu user chưa xác nhận

Không được làm:
- không tự sửa code trong lúc verify
- không tự move sang `done/` nếu user chưa xác nhận
- không chỉ báo lỗi ở chat mà bỏ quên writeback vào mission hiện tại khi task còn tiếp tục được

Output mong muốn:
- `PASS` hoặc `FAIL_UNVERIFIED` hoặc `FAIL`
- lý do ngắn
- bước tiếp theo hoặc input còn thiếu
- nếu có retry tiếp: đưa luôn handoff ngắn cho Gemini và nói rõ mission hiện tại đã được cập nhật
- nếu là UI/STITCH và pass, nói rõ “design đủ để lock” hoặc “cần bổ sung brief/evidence”

## LỆNH 7 - VIẾT LẠI MISSION HIỆN TẠI CHO GEMINI RETRY
Đọc `agents/_shared_workflow.md` và `agents/sonnet_role.md` rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- đọc log thất bại mới nhất
- xác định có phải cùng `FAILURE_SIGNATURE` không
- nếu thiếu log, verify output hoặc reproduction detail làm cho hướng retry dễ sai, chỉ được hỏi / nêu thiếu input ngắn
- nếu là fail nhẹ hoặc fail_unverified:
  - không tạo mission mới
  - cập nhật **mission hiện tại** trong `missions/active/` bằng writeback ngắn theo format:
    - `ROOT CAUSE`
    - `FIX FOR GEMINI`
    - `VERIFY`
    - `WHY NOT OPUS YET`
  - cập nhật `NEXT_ACTION: GEMINI_RETRY`
  - nếu cần thì cập nhật `RETRY_COUNT` trong mission hiện tại

Không được làm:
- không tạo mission mới hoặc “mission retry” mới
- không tự sửa code
- không tự thực thi retry thay Gemini
- không nhập vai Gemini hoặc viết log execution như thể đã retry
- không suy diễn thành task mới nếu thiếu dữ kiện

Output mong muốn:
- nếu thiếu dữ kiện: nêu rõ thiếu input nào
- nếu đủ dữ kiện: xác nhận mission hiện tại đã được viết lại + đưa 1 handoff ngắn để copy sang Gemini

## LỆNH 8 - ESCALATE SANG OPUS
Đọc `agents/_shared_workflow.md` và `agents/sonnet_role.md` rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- nếu Gemini đã fail 2 lần cùng `FAILURE_SIGNATURE`, đổi task sang `ESCALATED`
- nếu còn thiếu log, verify output hoặc boundary module làm brief escalation dễ lệch, hỏi / nêu thiếu input ngắn
- giữ task trong `missions/active/`
- cập nhật mission hiện tại bằng block escalation ngắn làm đầu vào cho Opus: `ESCALATION_REASON`, `ATTEMPT_HISTORY`, `LATEST_VERIFY_RESULT`, `ASK_OPUS`
- chuẩn bị brief ngắn cho Opus
- chưa move `missions/failed/`

Không được làm:
- không tự phân tích sâu thay Opus trong cùng lệnh
- không tự viết lại toàn bộ mission thi công sau escalation nếu mục tiêu chỉ là bàn giao cho Opus
- không tự move `missions/failed/`
- không tự thực thi patch sau khi escalate

Output mong muốn:
- nếu thiếu dữ kiện: nêu rõ thiếu input nào
- nếu đủ dữ kiện: brief escalation ngắn cho Opus + lý do escalation + trạng thái task mới

## LỆNH 9 - CHỐT DONE SAU KHI USER XÁC NHẬN
Đọc `agents/_shared_workflow.md` và `agents/sonnet_role.md` rồi tuân thủ.
Đây là role refresh, không phải task mới ở cấp vai trò.

Việc cần làm:
- xác nhận task đã verify pass
- xác nhận user đã đồng ý task hoàn thành
- move `missions/active/` sang `missions/done/`
- đảm bảo `active/` chỉ còn task đang sống

Không được làm:
- không verify lại từ đầu nếu đã có kết luận pass trước đó trừ khi có thông tin mới
- không sửa thêm code ở bước chốt done

Output mong muốn:
- thông báo chốt done ngắn
- nhắc file đã được move

## LỆNH 10 - RE-ANCHOR SONNET
Đọc `agents/_shared_workflow.md`, `agents/sonnet_role.md` và `agents/refresh/sonnet_refresh.md` rồi tuân thủ.
Đây là re-anchor, không phải task mới.

Việc cần làm:
- quay lại đúng vai trò Mission Controller + Verification Gate
- bỏ mọi xu hướng mở scope, code mặc định, hoặc tin self-report khi chưa verify
- nhớ rằng Gemini chỉ được báo `EXECUTION_DONE`, không tự chốt `DONE`
- với UI vừa/lớn, nhớ rằng Sonnet viết mission cho Gemini chạy stitch_loop rồi mới verify
- khi verify fail mà còn đường sửa, phải cập nhật lại mission hiện tại cho Gemini
- tiếp tục task hiện tại trong phạm vi đã được giao

Không được làm:
- không biến re-anchor thành tạo mission mới hoặc execution mới
- không dùng re-anchor như cái cớ để takeover task của Gemini
