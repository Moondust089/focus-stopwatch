# TÓM TẮT LỆNH VÀ CÁCH DÙNG

## Sonnet
### Lệnh 1 – Khởi động task mới
Dùng khi: có yêu cầu mới.
Sonnet sẽ: tạo mission BUG/FEATURE/UI, scope chặt, file liên quan, cách verify, `LOG_PATH`.

### Lệnh 4 – UI vừa/lớn
Dùng khi: task là UI vừa/lớn.
Sonnet sẽ: tạo mission để **Gemini chạy stitch_loop**, sau đó Sonnet verify thiết kế.

### Lệnh 6 – Verify kết quả
Dùng khi: Gemini đã ghi log và báo `EXECUTION_DONE` hoặc `FAIL`.
Sonnet sẽ: verify theo mission + log + evidence; nếu pass thì để `NEEDS_REVIEW`; nếu fail mà còn sửa được thì cập nhật lại mission active hiện tại cho Gemini.

### Lệnh 7 – Viết lại mission hiện tại cho Gemini
Dùng khi: cần retry sau verify fail.
Sonnet sẽ: cập nhật mission hiện tại + ghi writeback ngắn cho Gemini.

### Lệnh 8 – Escalate sang Opus
Dùng khi: fail khó hoặc đã 2 retry cùng lỗi.

### Lệnh 9 – Chốt done
Dùng khi: Sonnet đã verify pass và user xác nhận xong.
Sonnet sẽ: move task từ `active/` sang `done/`.

## Gemini
### Lệnh 1 – Thực thi mission
Dùng khi: mission thường.
Gemini sẽ: thực thi mission, ghi log vật lý, chỉ báo `EXECUTION_DONE` hoặc `FAIL`.

### Lệnh 2 – Retry
Dùng khi: Sonnet đã cập nhật mission hiện tại sau verify fail.
Gemini sẽ: retry theo writeback mới nhất.

### Lệnh 3 – UI / Stitch
Dùng khi: mission UI cần stitch_loop.
Gemini sẽ: chạy stitch_loop, ghi log vật lý + artifacts/evidence.

### Lệnh 4 – Dừng và báo fail sau 2 retry
Dùng khi: cùng `failure_signature` đã fail 2 lần.

## Flow khuyên dùng
### Bug / feature thường
1. Sonnet tạo mission
2. Gemini thực thi
3. Gemini ghi log vật lý
4. Sonnet verify
5. Nếu fail nhưng còn sửa được: Sonnet viết lại mission hiện tại
6. Nếu pass và user xác nhận: Sonnet move done

### UI vừa/lớn theo flow mới
1. Sonnet tạo mission UI/STITCH
2. Gemini dùng lệnh 3 để chạy stitch_loop
3. Gemini ghi log vật lý + artifacts/evidence
4. Sonnet verify thiết kế đúng và đủ chưa
5. Nếu pass, Sonnet mới tạo/cập nhật mission implementation
6. Gemini implement theo design đã khóa

### Fail 2 lần cùng lỗi
1. Sonnet escalate
2. Opus chốt hướng
3. Gemini thực thi lại theo mission mới

## Điều bắt buộc phải nhớ
- Sonnet không tự làm thay Gemini
- UI vừa/lớn: Gemini mới là agent chạy stitch_loop
- Sonnet verify dựa trên mission + log + evidence
- Không có file log vật lý ở `LOG_PATH` thì chưa được coi là `EXECUTION_DONE` hợp lệ
- Gemini không tự báo `DONE`
