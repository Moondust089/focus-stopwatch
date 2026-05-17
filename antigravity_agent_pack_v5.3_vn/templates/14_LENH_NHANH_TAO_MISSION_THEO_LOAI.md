# LỆNH NHANH TẠO MISSION THEO LOẠI

## 1) Bảo Sonnet tạo mission BUG

Đọc `agents/_shared_workflow.md`, `agents/sonnet_role.md` và `templates/11_MAU_MISSION_BUG.md` rồi tạo mission mới trong `missions/active/`.
Đây là role refresh, không phải task mới.

Thông tin task:
- Mục tiêu: ...
- Lỗi hiện tại: ...
- File nghi ngờ: ...
- Verify mong muốn: ...

Yêu cầu:
- mission ngắn
- chỉ 1 mục tiêu
- FILES thật gọn
- có FAILURE_SIGNATURE, RETRY_COUNT, LOG_PATH
- có LAST_EXECUTION_STATUS, LAST_VERIFY_RESULT, NEXT_ACTION, SONNET_HANDOFF_FOR_GEMINI

---

## 2) Bảo Sonnet tạo mission FEATURE

Đọc `agents/_shared_workflow.md`, `agents/sonnet_role.md` và `templates/12_MAU_MISSION_FEATURE.md` rồi tạo mission mới trong `missions/active/`.
Đây là role refresh, không phải task mới.

Thông tin task:
- Tính năng cần thêm: ...
- Phạm vi: ...
- File liên quan: ...
- Verify mong muốn: ...

Yêu cầu:
- không mở rộng scope
- không nhét phân tích dài
- VERIFY phải đo được
- có LOG_PATH
- có field để Sonnet writeback lại mission nếu verify fail

---

## 3) Bảo Sonnet tạo mission UI / STITCH

Đọc `agents/_shared_workflow.md`, `agents/sonnet_role.md` và `templates/13_MAU_MISSION_UI_STITCH.md` rồi tạo mission mới trong `missions/active/`.
Đây là role refresh, không phải task mới.

Thông tin task:
- Màn hình / flow: ...
- Mức độ: UI nhỏ | UI vừa/lớn
- File liên quan: ...
- Verify mong muốn: ...

Yêu cầu:
- nếu UI vừa/lớn thì đánh dấu `STITCH_REQUIRED: YES`
- `STITCH_EXECUTOR: GEMINI`
- mission ngắn, đủ để Gemini chạy stitch_loop
- Sonnet sẽ verify design sau khi Gemini ghi log/evidence
- nếu verify fail mà còn đường sửa thì Sonnet sẽ cập nhật lại mission hiện tại
