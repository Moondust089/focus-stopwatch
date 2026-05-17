# Mẫu escalate sang Opus

```text
Đọc agents/_shared_workflow.md và agents/opus_role.md rồi tuân thủ.
Đây là role refresh, không phải task mới.

Task này đang ở trạng thái ESCALATED.

TASK_ID:
[TASK_ID]

Bối cảnh ngắn:
- [mục tiêu task]
- [phạm vi module / service]

FAILURE_SIGNATURE:
- [mô tả lỗi gốc đang lặp lại]

Đã thử:
1. [attempt 1]
2. [attempt 2]

Kết quả verify:
- [vẫn fail thế nào]

Yêu cầu cho Opus:
- phân tích root cause
- đề xuất solution chuẩn, gọn
- nếu có nhiều hướng sửa, so sánh ngắn và chọn hướng tối ưu luôn trong lần này
- cập nhật luôn mission hiện tại thành bản executable cuối cùng cho Gemini nếu task còn đường xử lý tiếp
- đặt lại `STATUS: IN_PROGRESS`, `OWNER: GEMINI` sau khi mission đã chốt xong
- viết handoff cực ngắn để chuyển thẳng sang Gemini
- được phép hỏi thêm vài câu ngắn nếu thiếu dữ kiện quan trọng
- không code mặc định
- không over-engineering
- không đụng `memo files/`
```

## Dùng khi nào

- Gemini fail 2 lần cùng failure_signature
- bug khó, nhiều module, root cause chưa rõ
- cần chọn solution chuẩn trước khi sửa tiếp
- muốn tránh vòng lặp Sonnet -> Opus -> Sonnet chỉ để viết lại mission
