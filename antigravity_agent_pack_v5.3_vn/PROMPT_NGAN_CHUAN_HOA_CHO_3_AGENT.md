# PROMPT NGẮN CHUẨN HÓA CHO 3 AGENT

Các mẫu dưới đây ưu tiên ngắn, rõ, giữ đúng vai trò, và hạn chế agent làm thay nhau.

---

## 1) Sonnet - khởi động task mới
```text
Đọc lệnh số 1 trong file agents/commands/sonnet_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Context task: ...
Nếu thiếu dữ kiện trọng yếu để chốt mission, hãy hỏi gộp ngắn trước.
```

## 2) Sonnet - tạo mission bug
```text
Đọc lệnh số 2 trong file agents/commands/sonnet_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Yêu cầu bug: ...
Nếu thiếu reproduction, expected behavior hoặc verify signal, hãy hỏi gộp ngắn trước.
```

## 3) Sonnet - viết lại mission hiện tại cho Gemini
```text
Đọc lệnh số 7 trong file agents/commands/sonnet_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Task hiện tại: TASK-XXX
Không tạo mission mới. Hãy cập nhật mission active hiện tại cho Gemini và kèm 1 retry note ngắn.
Không sửa code. Không retry thay Gemini. Phải cập nhật lại mission hiện tại nếu task còn tiếp tục.
Nếu thiếu dữ kiện làm writeback dễ sai, hãy nêu thiếu input thật ngắn.
```

## 4) Sonnet - verify kết quả
```text
Đọc lệnh số 6 trong file agents/commands/sonnet_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Task hiện tại: TASK-XXX
Hãy verify theo mission và log.
Nếu thiếu log vật lý, thiếu bằng chứng verify hoặc thiếu current/expected behavior, hãy nêu thiếu input ngắn trước khi kết luận.
Nếu verify fail nhưng task còn đường sửa, hãy cập nhật lại mission active hiện tại cho Gemini.
```

## 5) Sonnet - escalate sang Opus
```text
Đọc lệnh số 8 trong file agents/commands/sonnet_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Task hiện tại: TASK-XXX
Task này có dấu hiệu cần ESCALATED.
Hãy cập nhật mission hiện tại bằng block escalation ngắn rồi viết brief ngắn cho Opus.
Không phân tích sâu thay Opus. Không implement. Không move task sang failed.
Mục tiêu là để Opus chốt mission thi công cuối cùng và route thẳng sang Gemini.
Nếu thiếu log, verify output hoặc boundary module, hãy nêu thiếu input thật ngắn trước khi chốt escalation.
```

## 6) Sonnet - UI vừa/lớn
```text
Đọc lệnh số 4 trong file agents/commands/sonnet_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Task này là UI mức vừa/lớn.
Hãy tạo mission để Gemini chạy stitch_loop, rồi Sonnet sẽ verify xem thiết kế có đúng và đủ chưa.
Nếu thiếu flow, layout hoặc acceptance criteria, hãy hỏi gộp ngắn trước khi chốt hướng.
Context task: ...
```

## 7) Gemini - thực thi mission thường
```text
Đọc lệnh số 1 trong file agents/commands/gemini_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Mission file: missions/active/TASK-XXX.md
Chỉ làm đúng mission. Không mở rộng scope. Không đụng `memo files/`.
Ghi log vật lý vào LOG_PATH và nhắc lại LOG_PATH trong phản hồi.
Chỉ báo `EXECUTION_DONE` khi xong lượt execution, không báo `DONE`.
Chỉ cleanup candidate thỏa rule an toàn và ưu tiên khớp agents/SAFE_DELETE_ALLOWLIST_PATTERNS.md.
```

## 8) Gemini - UI / Stitch
```text
Đọc lệnh số 3 trong file agents/commands/gemini_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Mission file: missions/active/TASK-XXX.md
Nếu mission có STITCH_REQUIRED: YES thì bạn là agent gọi stitch_loop.
Nếu đang ở PHASE: DESIGN_GENERATION thì chưa tự nhảy sang implement production.
Ghi log vật lý vào LOG_PATH và nhắc lại LOG_PATH trong phản hồi.
Chỉ báo `EXECUTION_DONE` khi xong lượt execution, không báo `DONE`.
Không mở rộng scope. Không đụng `memo files/`.
```

## 9) Gemini - retry
```text
Đọc lệnh số 2 trong file agents/commands/gemini_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Mission file: missions/active/TASK-XXX.md
Retry đúng theo phần Sonnet writeback mới nhất trong mission.
Không mở rộng scope. Không đụng `memo files/`.
Ghi log vật lý vào LOG_PATH và nhắc lại LOG_PATH trong phản hồi.
Chỉ báo `EXECUTION_DONE` khi xong lượt execution, không báo `DONE`.
Chỉ cleanup candidate thỏa rule an toàn và ưu tiên khớp agents/SAFE_DELETE_ALLOWLIST_PATTERNS.md.
```

## 10) Gemini - dừng và báo fail khi user test vẫn lỗi dù trước đó Gemini báo execution done
```text
Đọc lệnh số 4 trong file agents/commands/gemini_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Mission file: missions/active/TASK-XXX.md
Người dùng đã test và xác nhận kết quả vẫn FAIL dù trước đó Gemini báo EXECUTION_DONE.
Hãy coi lần báo EXECUTION_DONE trước là chưa hợp lệ ở góc độ verify thực tế.
Không tiếp tục nhận là đã pass. Không tự retry thêm trong prompt này. Không mở rộng scope.
Hãy dừng và trả FAIL rõ ràng cho Sonnet, kèm:
- FAILURE_SIGNATURE ngắn, nhất quán
- root cause giả thuyết ngắn
- next_hint ngắn để Sonnet quyết định retry hay escalate
Ghi log vật lý vào LOG_PATH.
Không đụng `memo files/`.
```

## 11) Opus - escalation root cause + chốt hướng + viết mission
```text
Đọc lệnh số 1 trong file agents/commands/opus_commands.md rồi thực hiện.
Đây là role refresh, không phải task mới ở cấp vai trò.
Task này đang ở trạng thái ESCALATED.
Hãy phân tích root cause; nếu có nhiều hướng sửa thì so sánh và chọn hướng tối ưu; rồi cập nhật luôn mission hiện tại thành bản executable cuối cùng cho Gemini.
Sau khi mission đã rõ, đặt `STATUS: IN_PROGRESS`, `OWNER: GEMINI`, chốt `NEXT_OWNER`, `NEXT_EXECUTOR`, `NEXT_ACTION`, rồi viết handoff cực ngắn để chuyển thẳng sang Gemini.
Không code. Không verify thay Sonnet. Không đẩy ngược về Sonnet chỉ để viết lại mission.
Nếu thiếu log, boundary module, current/expected behavior hoặc tiêu chí quyết định, hãy hỏi gộp ngắn trước khi chốt.
```

## 12) Re-anchor chung
```text
Đây là re-anchor, không phải task mới.
Bạn vẫn giữ nguyên vai trò cũ.
Đọc lại agents/_shared_workflow.md và file role tương ứng rồi tuân thủ toàn bộ.
Không tự đổi vai trò. Không làm thay agent khác.
Task hiện tại: ...
Ràng buộc quan trọng:
- Gemini chỉ được báo `EXECUTION_DONE`, không tự báo `DONE`
- Sonnet verify fail thì phải cập nhật lại mission hiện tại cho Gemini
- ...
```
