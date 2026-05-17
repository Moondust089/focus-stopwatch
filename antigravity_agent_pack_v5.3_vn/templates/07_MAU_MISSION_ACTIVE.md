# Mẫu file mission trong missions/active/

```md
TASK_ID: TASK-001
STATUS: IN_PROGRESS
TYPE: BUG | FEATURE | REFACTOR | UI
OWNER: GEMINI
NEXT_EXECUTOR: GEMINI
LOG_PATH: logs/execution/TASK-001.log

TASK:
[Mô tả 1 mục tiêu duy nhất của mission]

SCOPE:
[Phạm vi rất cụ thể]

FILES:
- [file 1]
- [file 2]

STEPS:
1. [bước 1]
2. [bước 2]
3. [bước 3]

EXPECTED:
- [trạng thái đúng sau khi xong]

VERIFY:
- Command: [lệnh cần chạy hoặc loại evidence cần có]
- Pass signal: [dấu hiệu pass]
- Nếu là UI/app: [dấu hiệu màn hình render / app chạy thật]

CONSTRAINTS:
- không mở rộng scope
- không đổi architecture nếu không được nêu
- chỉ sửa file liên quan trực tiếp

FAILURE_SIGNATURE:
[mô tả lỗi gốc ngắn gọn, nhất quán]

RETRY_COUNT:
0

LAST_EXECUTION_STATUS:
PENDING

LAST_VERIFY_RESULT:
PENDING

NEXT_ACTION:
GEMINI_EXECUTE | GEMINI_RETRY | WAIT_USER_CONFIRM | ESCALATE_OPUS

SONNET_HANDOFF_FOR_GEMINI:
- ROOT CAUSE: [để trống khi mission mới]
- FIX FOR GEMINI: [để trống khi mission mới]
- VERIFY: [để trống khi mission mới]
- WHY NOT OPUS YET: [để trống khi mission mới]

ESCALATION_REASON:
[để trống nếu chưa escalated]

ATTEMPT_HISTORY:
- [attempt 1]
- [attempt 2]

OPUS_ROOT_CAUSE:
[để trống nếu chưa qua Opus]

OPUS_DECISION:
[để trống nếu chưa qua Opus]
```

## Gợi ý

- mỗi mission chỉ 1 mục tiêu
- FILES càng ít càng tốt
- FAILURE_SIGNATURE phải đủ ngắn để dùng lại qua các lần retry
- `LOG_PATH` nên giữ đúng chuẩn để Sonnet dễ verify
- `LAST_EXECUTION_STATUS` chỉ ghi `EXECUTION_DONE` hoặc `FAIL` sau khi Gemini chạy xong một lượt
- `DONE` không phải execution status của Gemini
- khi task đã escalated, Opus nên cập nhật lại chính file mission này thay vì tạo mission mới song song
