# ANTIGRAVITY AGENT PACK v5.2 VN

Bộ này giúp bạn điều phối 3 agent theo vai trò tách bạch:
- **Claude Sonnet** = controller / tạo mission / verify / quyết định retry-escalate-done
- **Gemini** = executor / chỉ thi hành mission / ghi log execution
- **Opus** = escalation architect / chốt hướng khi task khó

## Điểm cốt lõi của bản đồng bộ này
- Gemini chỉ được báo **`EXECUTION_DONE`** hoặc `FAIL` cho từng lượt execute / retry / stitch
- `EXECUTION_DONE` **không** đồng nghĩa task đã done
- Chỉ Sonnet mới được verify pass và chuyển mission sang `NEEDS_REVIEW` / `missions/done`
- Nếu Sonnet verify fail nhưng task vẫn còn đường sửa, Sonnet phải **cập nhật lại chính mission active hiện tại** cho Gemini tiếp tục làm; không tạo mission retry mới song song

## Flow ngắn
1. Sonnet tạo mission trong `missions/active/`
2. Gemini thực thi và ghi log vật lý tại `LOG_PATH`
3. Gemini chỉ báo `EXECUTION_DONE` hoặc `FAIL`
4. Sonnet đọc mission + log + evidence để verify
5. Nếu pass: Sonnet cập nhật `NEEDS_REVIEW`
6. Nếu user xác nhận: Sonnet move sang `missions/done/`
7. Nếu fail nhưng còn đường sửa: Sonnet viết lại mission hiện tại cho Gemini retry
8. Nếu fail 2 lần cùng `FAILURE_SIGNATURE`: Sonnet escalate sang Opus

## Quy ước thư mục
```text
missions/
  active/
  done/
  failed/
logs/
  execution/
agents/
templates/
memo files/
```

## Luật quan trọng
- Không có file log vật lý ở `LOG_PATH` thì không được coi là `EXECUTION_DONE` hợp lệ
- Gemini không tự verify thay Sonnet
- Gemini không tự move `missions/done/`
- Sonnet không tự làm thay Gemini trong luồng chuẩn
- Opus không tự implement hay verify thay Sonnet trừ ngoại lệ escalation writeback đã quy định

## Khi verify fail
Sonnet phải làm đủ 2 việc:
1. báo kết luận verify ngắn trong chat
2. cập nhật lại mission active hiện tại với:
   - `LAST_VERIFY_RESULT`
   - `NEXT_ACTION`
   - `SONNET_HANDOFF_FOR_GEMINI`

## Khi nào mới move done
Chỉ khi đủ cả 2 điều kiện:
1. Sonnet verify pass
2. user xác nhận hoàn thành

## Gợi ý dùng nhanh
- tạo mission: xem `agents/commands/sonnet_commands.md`
- thực thi mission: xem `agents/commands/gemini_commands.md`
- escalate: xem `agents/commands/opus_commands.md`
- mẫu prompt nhanh: xem `PROMPT_NGAN_CHUAN_HOA_CHO_3_AGENT.md`
- mẫu mission/log: xem `templates/07_MAU_MISSION_ACTIVE.md` và `templates/16_MAU_LOG_EXECUTION.md`
