# SƠ ĐỒ LỆNH TỔNG 1 TRANG

## Sonnet
### Lệnh 1
Khởi động task mới, tạo đúng 1 mission active.

### Lệnh 4
Tạo mission UI/STITCH.
Hãy tạo mission để Gemini chạy stitch_loop và Sonnet sẽ verify design sau đó.

### Lệnh 5
Gọi Gemini thực thi.
Nhắc rõ Gemini chỉ được báo `EXECUTION_DONE`, không được tự chốt `DONE`.

### Lệnh 6
Hãy đọc mission và log để verify.
- cần kiểm tra có bằng chứng verify chưa
- nếu fail nhưng còn đường sửa: phải cập nhật lại mission active hiện tại cho Gemini

### Lệnh 7
Viết lại mission hiện tại cho Gemini retry.
Không tạo mission mới, không thực thi retry.

### Lệnh 8
Escalate sang Opus khi cần.

### Lệnh 9
Chỉ move `missions/active/ -> missions/done/` khi đủ cả 2:
1. Sonnet verify pass
2. user đã xác nhận

## Gemini
### Lệnh 1
Thực thi mission thường.
Khi xong chỉ báo `EXECUTION_DONE` hoặc `FAIL`.

### Lệnh 2
Làm retry theo hướng dẫn writeback mới nhất của Sonnet trong mission hiện tại.

### Lệnh 3
UI vừa/lớn: Gemini chạy stitch_loop.

### Lệnh 4
Dừng và báo fail sau 2 retry.

## Nhớ
- UI vừa/lớn: Sonnet viết mission, Gemini chạy stitch_loop, Sonnet verify design
- Sonnet verify fail thì phải viết lại mission hiện tại cho Gemini
