# Prompt ngắn copy nhanh

## Sonnet - task mới
```text
Đọc lệnh số 1 trong file agents/commands/sonnet_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Context task: ...
Nếu thiếu dữ kiện trọng yếu để chốt mission, hãy hỏi gộp ngắn trước.
```

## Gemini - execute mission thường
```text
Đọc lệnh số 1 trong file agents/commands/gemini_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Mission file: missions/active/TASK-XXX.md
Chỉ làm đúng mission. Không mở rộng scope. Không đụng `memo files/`.
Ghi log vật lý vào LOG_PATH và nhắc lại LOG_PATH trong phản hồi.
Khi xong lượt execution chỉ báo EXECUTION_DONE, không báo DONE.
Chỉ cleanup candidate thỏa rule an toàn và ưu tiên khớp SAFE_DELETE_ALLOWLIST_PATTERNS.md.
```

## Gemini - UI / Stitch
```text
Đọc lệnh số 3 trong file agents/commands/gemini_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Mission file: missions/active/TASK-UI-XXX.md
Nếu mission có STITCH_REQUIRED: YES thì bạn là agent gọi stitch_loop.
Nếu đang ở PHASE: DESIGN_GENERATION thì chưa tự nhảy sang implement production.
Ghi log vật lý vào LOG_PATH và nhắc lại LOG_PATH trong phản hồi.
Khi xong lượt execution chỉ báo EXECUTION_DONE, không báo DONE.
```

## Sonnet - writeback mission hiện tại
```text
Đọc lệnh số 7 trong file agents/commands/sonnet_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Task hiện tại: TASK-XXX
Không tạo mission mới. Hãy cập nhật mission active hiện tại cho Gemini.
Không sửa code. Không retry thay Gemini.
Nếu thiếu dữ kiện làm writeback dễ sai, hãy nêu thiếu input thật ngắn.
```

## Opus - escalation
```text
Đọc lệnh số 1 trong file agents/commands/opus_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Task này đang ESCALATED.
Hãy phân tích root cause, chọn solution tối ưu và cập nhật mission cho Gemini. Không code mặc định.
```
