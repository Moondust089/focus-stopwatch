> Lưu ý: đây là patch report lịch sử. Luồng hiện hành được chuẩn hóa theo `PATCH_REPORT_V5_2_GEMINI_STITCH_FLOW.md` và các file hướng dẫn/role hiện tại.

# PATCH REPORT V4

## Mục tiêu bản vá
- bỏ vòng lặp Sonnet -> Opus -> Sonnet khi task đã escalated
- để Opus cập nhật luôn mission sau escalation
- route thẳng sang Gemini để tiết kiệm quota Claude
- vẫn giữ Gemini chỉ là executor, không tự quyết kiến trúc

## Thay đổi chính
- `agents/_shared_workflow.md`
  - thêm cơ chế escalation writeback: Opus được cập nhật mission hiện tại khi task đã `ESCALATED`
  - sau khi chốt hướng sửa, Opus đặt lại `STATUS: IN_PROGRESS`, `OWNER: GEMINI`
- `agents/opus_role.md`
  - đổi từ advisory-only sang advisory-first
  - cho phép Opus write back mission trong pha escalated
  - bắt buộc output có `MISSION_WRITEBACK`, `NEXT_EXECUTOR`, `NEXT_ACTION`
- `agents/commands/opus_commands.md`
  - lệnh 1 giờ buộc Opus cập nhật mission và handoff thẳng cho Gemini
- `agents/commands/sonnet_commands.md`
  - lệnh 8 chỉ ghi block escalation và bàn giao hồ sơ cho Opus
  - Sonnet không phải viết lại mission sau khi đã escalated
- `PROMPT_NGAN_CHUAN_HOA_CHO_3_AGENT.md`
  - prompt ngắn số 10 sửa theo cơ chế mới
- `templates/04_ESCALATE_SANG_OPUS.md`
  - mẫu escalate yêu cầu Opus cập nhật mission và route thẳng Gemini
- `templates/07_MAU_MISSION_ACTIVE.md`
  - thêm các field hỗ trợ escalation writeback
- `templates/09_LENH_NHANH_THEO_TINH_HUONG.md` và `templates/15_PROMPT_NGAN_COPY_NHANH.md`
  - cập nhật theo luồng mới

## Kết quả kỳ vọng
- khi đã escalated, Opus không dừng ở phân tích
- Opus viết / cập nhật mission luôn
- Gemini chỉ cần đọc mission mới nhất và thi công
- giảm thêm 1 vòng dùng Sonnet, tiết kiệm quota Claude
