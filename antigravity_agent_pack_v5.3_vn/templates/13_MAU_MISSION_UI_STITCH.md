# MẪU MISSION UI / STITCH

TASK_ID: TASK-UI-XXX
STATUS: IN_PROGRESS
TYPE: UI
OWNER: GEMINI
NEXT_EXECUTOR: GEMINI
LOG_PATH: logs/execution/TASK-UI-XXX.log
RETRY_COUNT: 0
FAILURE_SIGNATURE: NONE
LAST_EXECUTION_STATUS: PENDING
LAST_VERIFY_RESULT: PENDING
NEXT_ACTION: GEMINI_EXECUTE

SONNET_HANDOFF_FOR_GEMINI:
- ROOT CAUSE: [để trống khi mission mới]
- FIX FOR GEMINI: [để trống khi mission mới]
- VERIFY: [để trống khi mission mới]
- WHY NOT OPUS YET: [để trống khi mission mới]

TASK:
Chạy stitch_loop cho <màn hình / flow / khu vực> theo brief dưới đây để tạo proposal thiết kế đủ rõ cho Sonnet verify.

SCOPE:
- Tập trung vào UI/UX của 1 màn hình hoặc 1 flow
- Không mở rộng sang logic backend ngoài phần cần để mô tả đúng UI
- Ở phase design này, chưa tự nhảy sang implement production nếu mission chưa cho phép

FILES:
- path/ui_file_a
- path/ui_file_b
- path/style_file
- path/reference_file (nếu có)

DESIGN MODE:
- STITCH_REQUIRED: YES
- STITCH_EXECUTOR: GEMINI
- PHASE: DESIGN_GENERATION
- IMPLEMENT_AFTER_SONNET_VERIFY: NO

BRIEF FOR STITCH:
- Màn hình / flow: <...>
- Mục tiêu người dùng: <...>
- Khối nội dung bắt buộc: <...>
- State chính: <loading / empty / error / success / form state ...>
- Responsive: <mobile / tablet / desktop>
- Tone / style / design system: <...>
- Ràng buộc không được lệch: <...>

STEPS:
1. Đọc brief trong mission.
2. Chạy stitch_loop bám đúng brief.
3. Nếu có nhiều biến thể, chốt 1 hướng chính và 1 fallback ngắn.
4. Ghi rõ output / artifacts / evidence vào LOG_PATH.
5. Chỉ báo EXECUTION_DONE cho phase hiện tại và chờ Sonnet verify.

EXPECTED:
- Có proposal thiết kế bám đúng brief.
- Có đủ khối chính, state chính và ghi chú responsive cần thiết.
- Sonnet có đủ dữ kiện để quyết định lock design hoặc yêu cầu chỉnh tiếp.

VERIFY:
- Evidence cần có trong log:
  - tóm tắt proposal chính
  - trạng thái / khu vực chính đã cover
  - ghi chú responsive
  - artifacts hoặc nơi lưu output nếu có
- Pass signal:
  - thiết kế bám brief
  - không thiếu khối chính
  - đủ để Sonnet review mà không phải đoán lại ý đồ thiết kế

CONSTRAINTS:
- Không tự implement production code trong phase design này
- Không tự sáng tác UI ngoài brief
- Nếu stitch_loop bị block hoặc output quá mơ hồ, ghi FAIL rõ vào LOG_PATH
- Không đụng `memo files/`

GHI CHÚ CHO SONNET:
- Dùng mẫu này khi task là màn hình mới, redesign layout, dashboard, form phức tạp, visual polish, flow nhiều trạng thái
- Sau khi verify pass, Sonnet mới tạo/cập nhật mission implementation cho Gemini
- Nếu verify fail nhưng còn đường sửa => cập nhật lại mission hiện tại cho Gemini
- Nếu không có file log vật lý ở LOG_PATH => coi là chưa hoàn tất phase design
