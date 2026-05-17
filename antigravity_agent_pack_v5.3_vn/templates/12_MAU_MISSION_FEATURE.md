# MẪU MISSION FEATURE

TASK_ID: TASK-XXX
STATUS: IN_PROGRESS
TYPE: FEATURE
OWNER: GEMINI
NEXT_EXECUTOR: GEMINI
LOG_PATH: logs/execution/TASK-XXX.log
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
Triển khai tính năng <mô tả ngắn gọn, chỉ 1 mục tiêu chính>.

SCOPE:
- Chỉ thêm phần cần cho feature này
- Không mở rộng thêm enhancement ngoài yêu cầu
- Không redesign solution nếu mission không yêu cầu

FILES:
- path/file_a
- path/file_b
- path/file_c

STEPS:
1. Thêm logic tối thiểu để feature hoạt động.
2. Cập nhật các file liên quan trực tiếp.
3. Không chạm các phần ngoài scope.
4. Chạy VERIFY.
5. Ghi log đúng format vào LOG_PATH.

EXPECTED:
- Người dùng có thể <hành động chính>.
- Hệ thống phản hồi đúng theo <trạng thái mong đợi>.
- Không làm hỏng luồng cũ liên quan.

VERIFY:
- Command:
  - <ví dụ: npm run test feature_x>
  - <ví dụ: npm run build>
- Pass signal:
  - feature hoạt động đúng theo mô tả
  - test/build pass
  - không phát sinh lỗi blocking mới

CONSTRAINTS:
- Không refactor rộng
- Không thêm tính năng phụ ngoài mission
- Không đổi contract/API nếu mission không yêu cầu
- Nếu phát hiện yêu cầu mơ hồ hoặc phải đổi kiến trúc, dừng và báo lại Sonnet

GHI CHÚ CHO SONNET:
- Nếu feature thực chất là UI vừa/lớn, chuyển sang mẫu UI/STITCH
- Nếu cần chia nhỏ, tách thành nhiều mission
- Nếu verify fail mà task còn đường sửa => cập nhật lại mission hiện tại cho Gemini
- Nếu không có file log vật lý ở LOG_PATH => chưa pass
