# Mẫu gọi Sonnet khi bắt đầu task mới

```text
Đọc agents/_shared_workflow.md và agents/sonnet_role.md rồi tuân thủ.
Đây là role refresh, không phải task mới.

Nhiệm vụ hiện tại:
- [mô tả task ngắn gọn]

Mục tiêu:
- [đầu ra mong muốn]

Phạm vi:
- [module / màn hình / repo / service liên quan]

Ràng buộc quan trọng:
- không code mặc định
- không mở rộng scope
- tối ưu token
- nếu là UI mức vừa/lớn thì tạo mission cho Gemini chạy stitch_loop
- được phép hỏi thêm vài câu ngắn nếu thiếu dữ kiện làm thay đổi mission
- không đụng `memo files/`

Hãy làm các việc sau:
1. Làm rõ mục tiêu và phạm vi nếu còn mơ hồ
2. Tạo mission ngắn, executable
3. Chỉ rõ VERIFY, FAILURE_SIGNATURE, RETRY_COUNT, LOG_PATH ban đầu
4. Chưa move done ở bước này
```

## Dùng khi nào

- bắt đầu task mới
- task còn mơ hồ, cần Sonnet phân tích lại
- cần Sonnet tạo mission cho Gemini
