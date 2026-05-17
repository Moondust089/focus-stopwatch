> Lưu ý: đây là patch report lịch sử. Luồng hiện hành được chuẩn hóa theo `PATCH_REPORT_V5_2_GEMINI_STITCH_FLOW.md` và các file hướng dẫn/role hiện tại.

# PATCH REPORT V2

## Mục tiêu bản vá này
- khóa chặt hơn ranh giới vai trò giữa Sonnet / Gemini / Opus
- cho phép dọn file test và file rác an toàn
- bảo vệ tuyệt đối thư mục `memo files/`
- cho Sonnet và Opus hỏi thêm ngắn để làm rõ thiết kế hoặc sửa lỗi khi cần

## Các thay đổi chính
1. Thêm `Role boundary rule` vào `agents/_shared_workflow.md`
2. Thêm `Filesystem protection rule` và `Safe cleanup rule` vào workflow chung
3. Siết `gemini_role.md` để chỉ xóa file tạm khi đủ điều kiện an toàn và phải log lại
4. Siết `sonnet_role.md` để Sonnet không làm thay Gemini / Opus và có `Clarification gate`
5. Siết `opus_role.md` để Opus advisory-only rõ hơn và có `Clarification gate`
6. Cập nhật command docs cho Sonnet / Gemini / Opus
7. Cập nhật template gọi agent để nhắc `memo files/` và cleanup rule
8. Tạo sẵn thư mục `memo files/` cùng file `README.txt`

## Hiệu lực mong muốn
- Sonnet không còn tự tạo retry mission hoặc thực thi thay Gemini khi dùng command controller-only
- Opus không còn takeover implementation khi đang ở vai advisory
- Gemini có thể dọn file test / file rác an toàn nhưng không xóa nhầm file ghi nhớ của user
- mọi agent mặc định tránh đụng vào `memo files/`
