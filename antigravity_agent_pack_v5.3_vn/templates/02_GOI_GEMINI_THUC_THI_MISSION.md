# Mẫu gọi Gemini để thực thi mission

```text
Đọc agents/_shared_workflow.md, agents/gemini_role.md và missions/active/[TEN_FILE_MISSION].md rồi tuân thủ.
Đây là role refresh, không phải task mới.

Chỉ làm đúng mission.
Không mở rộng scope.
Không đụng `memo files/`.
Chỉ xoá file test / file tạm nếu thỏa cleanup rule an toàn.
Ưu tiên chỉ cleanup các candidate khớp SAFE_DELETE_ALLOWLIST_PATTERNS.md.
Nếu mission là UI/STITCH thì dùng lệnh 3 thay vì lệnh 1.

Sau khi làm xong:
1. Ghi log đúng format vào `LOG_PATH`
2. Đảm bảo có file log vật lý thật
3. Nhắc lại `LOG_PATH` trong phản hồi chat
4. Chỉ báo `EXECUTION_DONE` thay vì `DONE`
```

## Dùng khi nào

- Sonnet đã tạo xong mission thường
- bạn muốn Gemini bắt đầu execute
