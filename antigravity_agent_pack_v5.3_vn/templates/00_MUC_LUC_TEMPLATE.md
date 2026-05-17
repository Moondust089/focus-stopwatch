# Bộ template copy-paste cho Antigravity

Bộ này dùng để bạn gọi đúng agent trong các tình huống phổ biến mà không cần gõ lại dài dòng.

## Danh sách file

- `01_GOI_SONNET_KHOI_DONG_TASK_MOI.md`
- `02_GOI_GEMINI_THUC_THI_MISSION.md`
- `03_GOI_GEMINI_RETRY.md`
- `04_ESCALATE_SANG_OPUS.md`
- `05_GOI_SONNET_VERIFY_VA_CHOT_DONE.md`
- `06_REANCHOR_CHUNG.md`
- `07_MAU_MISSION_ACTIVE.md`
- `08_CHECKLIST_KHI_NEN_DUNG_REFRESH_HAY_REANCHOR.md`
- `13_MAU_MISSION_UI_STITCH.md`
- `15_PROMPT_NGAN_COPY_NHANH.md`
- `16_MAU_LOG_EXECUTION.md`

## Cách dùng nhanh

- Task mới hoặc cần phân tích yêu cầu: gọi Sonnet
- Đã có mission rõ: gọi Gemini
- UI vừa/lớn: Sonnet tạo mission rồi Gemini chạy stitch_loop
- Gemini fail nhẹ nhưng còn đường sửa: Sonnet cập nhật lại mission hiện tại rồi gọi Gemini retry
- Gemini fail 2 lần cùng failure_signature hoặc bug khó: escalate sang Opus
- Cần verify và quyết định move done: gọi lại Sonnet

## Lưu ý

- Chỗ nào có `[...]` thì thay bằng nội dung thật
- Giữ nguyên các dòng neo vai trò như: `Đây là role refresh, không phải task mới.`
- Nếu agent trôi vai trò rõ rệt thì dùng template re-anchor trước rồi mới giao việc
- Nếu Sonnet báo không có log, kiểm tra `LOG_PATH` và file log vật lý trước
