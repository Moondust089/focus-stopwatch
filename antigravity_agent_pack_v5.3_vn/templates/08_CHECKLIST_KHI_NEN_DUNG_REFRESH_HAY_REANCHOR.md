# Checklist: khi nào dùng Refresh, khi nào dùng Re-anchor

## Dùng Refresh khi

- agent chỉ lệch nhẹ
- quên 1 vài rule nhỏ
- vẫn còn đúng vai trò tổng thể
- chỉ cần kéo lại đúng đường ray

Ví dụ:
- Gemini hơi mở rộng scope
- Sonnet quên verify kỹ
- Sonnet quên ưu tiên Stitch cho UI mức vừa/lớn
- Opus nói hơi dài nhưng vẫn đúng vai trò

## Dùng Re-anchor khi

- agent lệch vai trò rõ rệt
- refresh rồi nhưng vẫn lệch
- chat quá dài làm agent quên prompt gốc
- agent xử lý ngược hẳn rule quan trọng

Ví dụ:
- Gemini tự thiết kế lại solution lớn
- Gemini tự xoá/đổi file ngoài scope
- Sonnet tự code và takeover quá nhiều
- Opus làm như executor thay vì architect escalation

## Quy tắc thực dụng

- Lệch nhẹ -> dùng Refresh
- Lệch vừa -> Refresh + nhắc 2-3 rule sống còn
- Lệch nặng -> Re-anchor
- Re-anchor không đủ -> dán lại prompt role đầy đủ
