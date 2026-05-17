# Mẫu gọi Sonnet để verify và quyết định move done

```text
Đọc agents/_shared_workflow.md và agents/sonnet_role.md rồi tuân thủ.
Đây là role refresh, không phải task mới.

Hãy kiểm tra mission sau:
- missions/active/[TEN_FILE_MISSION].md

Và đọc log sau:
- [LOG_PATH hoặc logs/execution/[TASK_ID].log]

Yêu cầu:
1. Đối chiếu kết quả với EXPECTED và VERIFY trong mission
2. Không tin self-report nếu thiếu bằng chứng
3. Nếu mission là UI/STITCH ở pha design, hãy kiểm tra xem thiết kế có đúng brief và đủ để lock chưa
4. Nếu pass: cập nhật mission thành NEEDS_REVIEW hoặc đề xuất DONE nếu user đã xác nhận
5. Chỉ move sang missions/done khi đủ verify và user confirm
6. Nếu chưa pass nhưng còn đường sửa: phải cập nhật lại chính mission active hiện tại cho Gemini tiếp tục thi hành
7. Nếu thiếu log vật lý / thiếu bằng chứng thì nêu rõ input còn thiếu, không tự suy diễn thành pass
```

## Dùng khi nào

- Gemini báo `EXECUTION_DONE`
- bạn muốn Sonnet kiểm tra lại trước khi chốt
- bạn đã test xong và muốn move done
