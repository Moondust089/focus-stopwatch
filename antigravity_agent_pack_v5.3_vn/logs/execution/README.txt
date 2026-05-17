Mỗi lần Gemini execute / retry / chạy UI-Stitch đều phải ghi file log vật lý tại đây.

Quy tắc tối thiểu:
1. Mặc định tên file: <TASK_ID>.log
2. Nội dung log phải có dòng [LOG_PATH]: logs/execution/<TASK_ID>.log
3. Nếu task là UI/Stitch phase design thì phải có [STITCH_STATUS] và [ARTIFACTS]
4. Nếu không có file log vật lý thì Sonnet không nên verify pass
