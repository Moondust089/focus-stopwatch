# MẪU LOG EXECUTION

```text
[LOG_PATH]: logs/execution/TASK-XXX.log
[MODE]: EXECUTION | RETRY | UI_STITCH_DESIGN | UI_IMPLEMENT
[STATUS]: EXECUTION_DONE | FAIL
[TASK_ID]: TASK-XXX
[SUMMARY]: mô tả ngắn kết quả execution hiện tại
[STEP]:
- bước 1
- bước 2
[FILES_CHANGED]:
- path/file_a
- path/file_b
[FILES_DELETED]:
- none
[CLEANUP_CANDIDATE]:
- none
[STITCH_STATUS]: NOT_USED | RAN | BLOCKED
[ARTIFACTS]:
- none hoặc mô tả artifact/path/evidence chính
[VERIFY]:
- command/evidence đã chạy
- pass signal hoặc kết quả thực tế
[ERROR]:
- none hoặc lỗi ngắn gọn
[FAILURE_SIGNATURE]:
- NONE hoặc mô tả ngắn lỗi lặp
[RETRY]: 0/2 | 1/2 | 2/2
[NEXT_HINT]:
- gợi ý ngắn cho Sonnet nếu cần
```

## Bắt buộc
- Phải có file log vật lý thật tại đúng `LOG_PATH`
- Phải có `[LOG_PATH]: ...` ngay trong log
- `EXECUTION_DONE` chỉ có nghĩa là Gemini đã xong lượt execute/retry/design hiện tại và đang chờ Sonnet verify
- Với mission UI/STITCH ở phase design, `[STITCH_STATUS]` và `[ARTIFACTS]` không được để trống
- Nếu không ghi được file log vật lý thì không được báo `EXECUTION_DONE`
