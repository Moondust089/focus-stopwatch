# HƯỚNG DẪN ĐẦY ĐỦ DÙNG COMMANDS VÀ AGENT

Tài liệu này là bản đầy đủ để bạn dùng bộ agent theo cách ổn định, tiết kiệm token và ít lệch vai trò.

---

## 1) Cấu trúc thư mục quan trọng

```text
missions/
  active/
  done/
  failed/

logs/
  execution/
```

- `missions/`: nơi chứa task theo trạng thái
- `logs/execution/`: nơi Gemini ghi log thực thi **bắt buộc**
- mặc định `LOG_PATH = logs/execution/<TASK_ID>.log`

---

## 2) Vai trò từng agent

### Claude Sonnet
Dùng cho:
- phân tích yêu cầu
- tạo mission
- kiểm tra log
- verify kết quả
- quyết định retry / escalate / done
- cập nhật lại mission hiện tại khi verify fail nhưng task vẫn còn đường sửa

Không nên dùng Sonnet cho:
- xử lý thay hết việc của Gemini
- tự code mặc định
- tự chạy Stitch-loop trong luồng UI vừa/lớn
- tự ý chốt done khi chưa verify và chưa có user confirm

### Gemini Pro High
Dùng cho:
- thực thi mission đã rõ
- sửa file trong phạm vi mission
- retry theo phần Sonnet writeback mới nhất trong mission hiện tại
- chạy **stitch_loop** khi mission UI yêu cầu
- ghi log vào `logs/execution/`
- báo `EXECUTION_DONE` hoặc `FAIL`

Không nên dùng Gemini cho:
- tự tạo mission mới
- tự verify thay Sonnet
- tự đổi kiến trúc lớn
- tự sáng tác UI lớn ngoài brief
- tự báo `DONE`
- tự move `missions/done/`

### Claude Opus
Dùng cho:
- bug khó
- root cause nhiều lớp
- cần chọn solution giữa nhiều hướng
- cập nhật mission escalated cho Gemini

Không nên dùng Opus cho:
- task nhỏ đã đủ rõ
- execution thường ngày
- verify thay Sonnet

---

## 3) Rule sống còn

### Rule 1 - Không tin self-report
Nếu Gemini báo `EXECUTION_DONE` nhưng log/evidence không đủ thì Sonnet phải coi là `FAIL_UNVERIFIED`.

### Rule 2 - Không có log vật lý thì chưa pass
Gemini phải:
- ghi file log vật lý vào `LOG_PATH`
- có `[LOG_PATH]: ...` trong log
- nhắc lại `LOG_PATH` trong phản hồi chat

Nếu thiếu 1 trong các ý trên, Sonnet dễ báo “không có log”.

### Rule 3 - UI vừa/lớn theo flow mới
- Sonnet tạo mission UI/STITCH
- Gemini chạy stitch_loop
- Sonnet verify xem thiết kế đúng và đủ chưa
- chỉ sau đó mới sang implementation

### Rule 4 - Retry đúng cách
Retry chỉ tính khi đủ cả 3:
1. Gemini đổi cách xử lý thực sự
2. đã chạy lại verify
3. vẫn lỗi cùng `FAILURE_SIGNATURE`

### Rule 5 - 2 retry chưa phải failed
Gemini fail 2 lần cùng lỗi chỉ là điều kiện để Sonnet escalate sang Opus. Chưa move `failed/` ngay.

### Rule 6 - Verify fail phải writeback lại mission
Nếu Sonnet verify ra `FAIL` hoặc `FAIL_UNVERIFIED` mà task vẫn còn đường sửa:
- Sonnet không chỉ báo ở chat
- Sonnet phải cập nhật lại chính mission active hiện tại
- Gemini sẽ tiếp tục làm dựa trên mission đã được Sonnet viết lại

---

## 4) Cách dùng “đọc lệnh số X”

### Với Sonnet
Ví dụ khởi động task mới:
```text
Đọc lệnh số 1 trong file agents/commands/sonnet_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới.
Context task: ...
Ràng buộc quan trọng:
- không code mặc định
- nếu là UI vừa/lớn thì tạo mission cho Gemini chạy stitch_loop
```

Ví dụ verify:
```text
Đọc lệnh số 6 trong file agents/commands/sonnet_commands.md rồi thực hiện.
Mission file: missions/active/TASK-017.md
Log file: logs/execution/TASK-017.log
Nếu verify fail nhưng còn đường sửa, hãy cập nhật lại mission active hiện tại cho Gemini.
```

### Với Gemini
Ví dụ thực thi mission thường:
```text
Đọc lệnh số 1 trong file agents/commands/gemini_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới.
Mission file: missions/active/TASK-017.md
Chỉ làm đúng mission.
Khi xong lượt execution chỉ báo EXECUTION_DONE.
```

Ví dụ thực thi mission UI/STITCH:
```text
Đọc lệnh số 3 trong file agents/commands/gemini_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới.
Mission file: missions/active/TASK-021.md
Nếu mission có STITCH_REQUIRED: YES thì bạn là agent gọi stitch_loop.
Ghi log vật lý vào LOG_PATH.
Khi xong lượt execution chỉ báo EXECUTION_DONE.
```

Ví dụ retry:
```text
Đọc lệnh số 2 trong file agents/commands/gemini_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới.
Mission file: missions/active/TASK-017.md
Hãy làm theo phần Sonnet writeback mới nhất trong mission hiện tại.
```

### Với Opus
Ví dụ escalation:
```text
Đọc lệnh số 1 trong file agents/commands/opus_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới.
Task này đang ESCALATED.
Brief escalation: ...
Không code mặc định.
```

---

## 5) Workflow chuẩn từ đầu đến cuối

### Luồng 1 - Bug thường
1. Chọn Sonnet
2. Bảo Sonnet đọc lệnh 2 hoặc lệnh 1 trong `agents/commands/sonnet_commands.md`
3. Sonnet tạo mission BUG trong `missions/active/`
4. Chọn Gemini
5. Bảo Gemini đọc lệnh 1 trong `agents/commands/gemini_commands.md`
6. Gemini thực thi và ghi log vào `LOG_PATH`
7. Gemini chỉ báo `EXECUTION_DONE` hoặc `FAIL`
8. Quay lại Sonnet
9. Bảo Sonnet đọc lệnh 6 để verify
10. Nếu pass -> `NEEDS_REVIEW`
11. Nếu fail nhưng còn sửa được -> Sonnet cập nhật lại mission hiện tại
12. Bạn tự kiểm tra
13. Nếu bạn xác nhận xong -> bảo Sonnet đọc lệnh 9 để move sang `done/`

### Luồng 2 - Bug fail 2 lần cùng lỗi
1. Gemini fail lần 1
2. Sonnet dùng lệnh 7 để viết lại mission hiện tại
3. Gemini retry bằng lệnh 2
4. Nếu vẫn fail cùng `FAILURE_SIGNATURE`
5. Sonnet dùng lệnh 8 để escalate sang Opus
6. Opus dùng lệnh 1 để phân tích root cause, chốt hướng sửa và cập nhật mission luôn
7. Nếu còn đường xử lý -> task vẫn nằm trong `active/`
8. Chỉ move sang `failed/` khi đã blocked thật sự

### Luồng 3 - UI vừa/lớn theo flow mới
1. Chọn Sonnet
2. Bảo Sonnet đọc lệnh 4 trong `agents/commands/sonnet_commands.md`
3. Sonnet xác nhận đây là task UI vừa/lớn
4. Sonnet tạo mission UI/STITCH cho Gemini
5. Chọn Gemini
6. Bảo Gemini đọc lệnh 3 trong `agents/commands/gemini_commands.md`
7. Gemini chạy stitch_loop, ghi log + artifacts/evidence vào `LOG_PATH`
8. Gemini chỉ báo `EXECUTION_DONE` hoặc `FAIL`
9. Quay lại Sonnet
10. Sonnet đọc lệnh 6 để verify design có đúng và đủ chưa
11. Nếu design pass -> Sonnet mới tạo/cập nhật mission implementation cho Gemini
12. Nếu design fail nhưng còn đường sửa -> Sonnet cập nhật lại mission hiện tại cho Gemini chạy tiếp

---

## 6) Khi nào dùng refresh, khi nào dùng re-anchor

### Dùng refresh khi lệch nhẹ hoặc vừa
Ví dụ:
- quên verify
- Gemini hơi mở rộng scope
- Sonnet quên UI vừa/lớn phải giao Gemini chạy Stitch-loop
- Gemini quên ghi log vật lý
- Sonnet verify fail nhưng quên writeback lại mission

### Dùng re-anchor khi lệch nặng
Ví dụ:
- Gemini tự thiết kế lại solution lớn
- Gemini tự nhận task là DONE
- Sonnet bắt đầu code và takeover quá nhiều
- Sonnet lại tự chạy Stitch-loop
- Opus làm như executor

---

## 7) Mẹo dùng ổn định
- luôn để Sonnet tạo mission trước
- luôn bắt Gemini nhắc lại `LOG_PATH`
- khi verify, luôn đối chiếu mission + log + evidence
- với UI vừa/lớn, đừng nhảy thẳng sang code production khi design chưa được Sonnet khóa
- nếu Sonnet báo không có log, kiểm tra lại:
  1. mission có `LOG_PATH` chưa
  2. Gemini có ghi file log vật lý chưa
  3. Gemini có nhắc lại `LOG_PATH` trong phản hồi chat chưa
- nếu verify fail mà task còn sửa được, kiểm tra Sonnet đã update mission active chưa

---

## 8) Kết luận nhanh
- task thường: Sonnet -> Gemini -> Sonnet
- UI vừa/lớn: Sonnet -> Gemini chạy stitch_loop -> Sonnet verify -> Gemini implement
- bug khó: Sonnet -> Opus -> Gemini
