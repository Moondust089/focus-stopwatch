# Khi nào dùng Re-anchor và khi nào dùng Refresh?

## 1) Refresh = nhắc lại nhanh vai trò hiện tại
Dùng khi agent chỉ lệch nhẹ hoặc vừa, ví dụ:
- bắt đầu mở rộng scope
- quên một vài rule như verify, retry, active/done/failed
- Gemini bắt đầu suy diễn ngoài mission
- Sonnet quên ưu tiên Stitch cho UI vừa / lớn
- Opus nói dài hơn mức cần thiết nhưng vẫn đúng vai trò

### Mục tiêu của refresh
- kéo agent về đúng vai trò hiện tại
- nhắc lại 3–6 rule quan trọng nhất
- không cần dán lại full prompt

### Dấu hiệu nên dùng refresh
- agent vẫn còn đúng vai trò tổng thể
- chỉ quên một số luật vận hành
- chat đã dài và bạn muốn “nhắc nhẹ” để neo lại

### Cách dùng
- gửi file refresh tương ứng
- nếu cần, thêm task hiện tại và 2–4 ràng buộc quan trọng

### Ví dụ
- Gemini vẫn là executor nhưng đang mở rộng scope -> dùng `agents/refresh/gemini_refresh.md`
- Sonnet vẫn là controller nhưng bắt đầu bỏ qua verify -> dùng `agents/refresh/sonnet_refresh.md`

---

## 2) Re-anchor = neo lại mạnh hơn
Dùng khi agent có dấu hiệu quên prompt gốc rõ ràng, ví dụ:
- hành xử sai hẳn vai trò
- làm trái rule nhiều lần liên tiếp
- sau chat dài bị trôi gần hết prompt ban đầu
- Gemini bắt đầu tự thiết kế solution lớn
- Sonnet bắt đầu code, tự takeover, hoặc bỏ hẳn workflow
- Opus bắt đầu xử lý như một executor bình thường

### Mục tiêu của re-anchor
- buộc agent quay lại đúng hệ luật gốc
- tái xác nhận file role + workflow đang là nguồn luật chính
- giảm nguy cơ “trôi prompt” sau thread dài

### Dấu hiệu nên dùng re-anchor
- refresh rồi nhưng agent vẫn lệch
- agent vi phạm vai trò cốt lõi
- bạn thấy không thể chỉ nhắc vài dòng là đủ

### Cách dùng
Gửi một tin kiểu này:

```text
Đây là re-anchor, không phải task mới.
Bạn vẫn giữ nguyên vai trò cũ.
Đọc lại `agents/_shared_workflow.md` và file role tương ứng rồi tuân thủ toàn bộ.
Không tự đổi vai trò.
Task hiện tại: ...
Ràng buộc quan trọng:
- ...
- ...
```

### Re-anchor mạnh hơn refresh ở đâu?
- refresh = nhắc ngắn
- re-anchor = yêu cầu agent đọc lại nguồn luật chính và khóa lại vai trò

---

## 3) Quy tắc thực chiến nên dùng
- lệch nhẹ / vừa -> dùng refresh trước
- lệch nặng hoặc refresh không đủ -> dùng re-anchor
- không cần dán lại full prompt sau mọi turn
- chỉ dán lại full prompt khi agent lệch nặng nhiều lần hoặc file role bị sửa / thay thế

---

## 4) Gợi ý nhanh theo từng agent
### Với Gemini
- dễ drift hơn -> dùng refresh thường xuyên hơn
- nếu đã tự mở scope, tự đổi solution, hoặc xử lý quá tay -> re-anchor

### Với Sonnet
- dùng refresh khi quên verify, quên retry rule, quên Stitch rule
- dùng re-anchor khi bắt đầu code nhiều, takeover task, hoặc làm sai vai trò controller

### Với Opus
- thường không cần refresh thường xuyên
- dùng re-anchor nếu Opus xử lý như executor hoặc nói quá dài, quá rộng so với vai trò escalation


---

## Quy tắc bổ sung
- mỗi agent giữ đúng nhiệm vụ của mình, không làm thay agent khác
- Sonnet và Opus được phép hỏi thêm ngắn khi thiếu dữ kiện quan trọng cho thiết kế / sửa lỗi / phân tích
- Gemini chỉ được xoá file test / file rác khi đủ điều kiện an toàn
- `memo files/` là vùng cấm mặc định, agent không được đụng vào nếu user chưa yêu cầu rất rõ
