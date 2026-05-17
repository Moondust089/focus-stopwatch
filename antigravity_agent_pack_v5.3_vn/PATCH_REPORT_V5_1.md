> Lưu ý: đây là patch report lịch sử. Luồng hiện hành được chuẩn hóa theo `PATCH_REPORT_V5_2_GEMINI_STITCH_FLOW.md` và các file hướng dẫn/role hiện tại.

# PATCH REPORT V5.1

## Mục tiêu bản vá
- gộp hành vi phân tích root cause và chọn hướng sửa của Opus vào một lệnh chuẩn duy nhất
- giữ nguyên các ý cũ, không lược bớt nội dung quan trọng
- đồng bộ lại prompt ngắn, hướng dẫn, template và mục lục để tránh lệch số lệnh
- chốt rõ mô hình: Sonnet escalate ngắn -> Opus writeback mission -> Gemini thực thi

## Thay đổi chính
- gộp `LỆNH 1` và `LỆNH 2` trong `agents/commands/opus_commands.md` thành một lệnh chuẩn duy nhất
- đổi `PROMPT_NGAN_CHUAN_HOA_CHO_3_AGENT.md` để gộp mục 10 và 11 thành một mục Opus duy nhất
- renumber các lệnh còn lại của Opus:
  - mission_detail nâng cao: từ lệnh 3 -> lệnh 2
  - kết luận blocked: từ lệnh 4 -> lệnh 3
  - re-anchor Opus: từ lệnh 5 -> lệnh 4
- cập nhật đồng bộ các file hướng dẫn nhanh, tóm tắt và template liên quan

## Tinh thần thiết kế sau bản vá
- Opus không chỉ dừng ở phân tích
- khi task đã escalated, Opus phải chốt hướng sửa trong cùng lượt nếu đã đủ dữ kiện
- Opus phải cập nhật mission luôn để tránh vòng lặp quay lại Sonnet chỉ để viết mission lần nữa
- Gemini vẫn chỉ là executor, không tự mở rộng scope, không tự quyết kiến trúc
