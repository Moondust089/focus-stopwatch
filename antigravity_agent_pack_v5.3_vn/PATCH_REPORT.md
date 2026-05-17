> Lưu ý: đây là patch report lịch sử. Luồng hiện hành được chuẩn hóa theo `PATCH_REPORT_V5_2_GEMINI_STITCH_FLOW.md` và các file hướng dẫn/role hiện tại.

# PATCH REPORT

## Đã sửa
- Siết ràng buộc control-only cho `agents/commands/sonnet_commands.md`
- Siết ràng buộc advisory-only cho `agents/commands/opus_commands.md`
- Vô hiệu hóa exception tự code của Sonnet khi đang chạy command controller-only
- Bổ sung ràng buộc vai trò cho Opus
- Sửa mapping sai số lệnh trong `CHEAT_SHEET_10_GIAY.md`
- Sửa mapping sai số lệnh và flow retry/verify/escalate/UI trong `SO_LENH_TONG_1_TRANG.md`

## Lỗi gốc đã xử lý
1. Lệnh 7 của Sonnet chưa cấm rõ việc tạo mission retry mới hoặc tự thực thi retry
2. Tài liệu điều hướng nhanh map sai số lệnh Sonnet, dễ làm agent hoặc người dùng đi nhầm flow
3. Exception rule của Sonnet có thể rò sang command controller-only nếu không chặn

## Khuyến nghị dùng prompt an toàn hơn cho Sonnet Lệnh 7
```text
Đọc lệnh số 7 trong file agents/commands/sonnet_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới.
Task hiện tại: TASK-XXX
Chỉ viết writeback / retry note cho Gemini dựa trên mission hiện tại và log thất bại mới nhất.
Không tạo mission mới. Không sửa code. Không thực thi retry thay Gemini.
Yêu cầu hiện tại: ...
```
