# Mẫu retry cho Gemini sau khi Sonnet đã đọc log

```text
Đọc agents/_shared_workflow.md, agents/gemini_role.md và missions/active/[TEN_FILE_MISSION].md rồi tuân thủ.
Đây là role refresh, không phải task mới.

Dùng mission active đã được Sonnet cập nhật lại. Không tạo mission mới.
Retry lần này chỉ xử lý đúng lỗi sau:
- FAILURE_SIGNATURE: [mo ta loi nhat quan]

ROOT CAUSE:
- [Sonnet ghi ngắn]

FIX FOR GEMINI:
- [chỉ dẫn rất cụ thể, ngắn]

VERIFY:
- [command hoặc dấu hiệu pass]

WHY NOT OPUS YET:
- [vì sao đây vẫn là lỗi nhẹ / còn đường sửa]

Ràng buộc:
- không đổi architecture
- không mở rộng scope
- chỉ fix trong phạm vi mission
- không đụng `memo files/`
- chỉ xoá file test / file tạm nếu thỏa cleanup rule an toàn
- ưu tiên chỉ cleanup các candidate khớp SAFE_DELETE_ALLOWLIST_PATTERNS.md
- cập nhật log đúng format vào `LOG_PATH` và tăng RETRY nếu vẫn lỗi cùng failure_signature
- nếu xong lượt execution thì dùng `EXECUTION_DONE`, không dùng `DONE`
- phải có file log vật lý và nhắc lại LOG_PATH trong phản hồi
```

## Dùng khi nào

- Gemini fail nhẹ
- Sonnet đã xác định được root cause tương đối rõ
- Sonnet đã cập nhật lại mission hiện tại cho Gemini
- chưa cần escalate sang Opus
