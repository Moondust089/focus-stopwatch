# MẪU MISSION BUG

TASK_ID: TASK-XXX
STATUS: IN_PROGRESS
TYPE: BUG
OWNER: GEMINI
NEXT_EXECUTOR: GEMINI
LOG_PATH: logs/execution/TASK-XXX.log
RETRY_COUNT: 0
FAILURE_SIGNATURE: <mô tả ngắn lỗi đang lặp lại>
LAST_EXECUTION_STATUS: PENDING
LAST_VERIFY_RESULT: PENDING
NEXT_ACTION: GEMINI_EXECUTE

SONNET_HANDOFF_FOR_GEMINI:
- ROOT CAUSE: [để trống khi mission mới]
- FIX FOR GEMINI: [để trống khi mission mới]
- VERIFY: [để trống khi mission mới]
- WHY NOT OPUS YET: [để trống khi mission mới]

TASK:
Sửa lỗi <mô tả lỗi ngắn gọn, đúng 1 mục tiêu>.

SCOPE:
- Chỉ sửa trong phạm vi lỗi này
- Không refactor rộng
- Không đổi solution ngoài phạm vi bug

FILES:
- path/file_a
- path/file_b

STEPS:
1. Tái hiện lỗi theo cách ngắn nhất.
2. Tìm nguyên nhân trực tiếp trong các file liên quan.
3. Sửa với diff nhỏ nhất có thể.
4. Chạy lại VERIFY.
5. Ghi log đúng format vào LOG_PATH.

EXPECTED:
- Lỗi <...> không còn xảy ra.
- Hành vi đúng sau sửa là <...>.

VERIFY:
- Command:
  - <ví dụ: npm test -- auth.redirect.test.ts>
  - <ví dụ: npm run build>
- Pass signal:
  - test <tên test> pass
  - không còn error <...>
  - app chạy tới <màn hình / route / trạng thái> đúng

CONSTRAINTS:
- Không đổi architecture
- Không xoá file ngoài scope
- Không sửa logic không liên quan
- Nếu vẫn fail cùng FAILURE_SIGNATURE sau 2 retry thì dừng và log rõ

GHI CHÚ CHO SONNET:
- Nếu Gemini báo EXECUTION_DONE nhưng VERIFY mơ hồ => FAIL_UNVERIFIED
- Nếu verify fail mà task còn đường sửa => cập nhật lại mission hiện tại cho Gemini
- Nếu lỗi đổi bản chất, cập nhật FAILURE_SIGNATURE mới
- Nếu không có file log vật lý ở LOG_PATH => chưa pass
