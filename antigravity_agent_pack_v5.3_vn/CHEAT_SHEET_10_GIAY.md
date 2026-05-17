# CHEAT SHEET 10 GIÂY

## 2 điều kiện để move done
1. Sonnet verify pass
2. User xác nhận hoàn thành

## Gemini được phép báo gì
- `EXECUTION_DONE` = đã xong lượt execution hiện tại, chờ Sonnet verify
- `FAIL` = execution chưa xong hoặc verify signal còn fail
- Gemini **không** được báo `DONE`

## Flow ngắn
1. Sonnet tạo mission
2. Gemini thực thi + ghi log vật lý
3. Sonnet verify
4. Nếu fail nhưng còn sửa được: Sonnet cập nhật lại mission hiện tại cho Gemini
5. Nếu pass: Sonnet để `NEEDS_REVIEW`
6. User confirm xong thì Sonnet move `done/`

## Nhắc lại
- Gemini không tự verify thay Sonnet
- Gemini không tự move `missions/done/`
- Sonnet verify fail thì không chỉ báo miệng; phải viết lại mission hiện tại
