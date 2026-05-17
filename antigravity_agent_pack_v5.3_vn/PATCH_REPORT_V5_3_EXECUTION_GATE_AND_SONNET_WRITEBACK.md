# PATCH REPORT V5.3 - EXECUTION GATE + SONNET WRITEBACK

## Mục tiêu bản vá
Đồng bộ lại toàn bộ pack để giải quyết 2 vấn đề:
1. Gemini tự coi mission là done sau khi làm xong execution.
2. Sonnet khi verify fail thường chỉ báo ở chat mà không cập nhật lại mission cho Gemini.

## Thay đổi chính
- đổi chuẩn execution status của Gemini thành:
  - `EXECUTION_DONE`
  - `FAIL`
- quy định rõ `EXECUTION_DONE` **không đồng nghĩa** task done
- cấm Gemini tự dùng `DONE` như execution status
- cấm Gemini tự move `missions/done/`
- bổ sung rule: khi verify fail nhưng task còn đường sửa, Sonnet phải cập nhật lại **chính mission active hiện tại** cho Gemini tiếp tục thi hành
- giữ nguyên nguyên tắc: không tạo mission retry mới song song cho cùng task

## File đã đồng bộ trọng tâm
- `agents/_shared_workflow.md`
- `agents/gemini_role.md`
- `agents/sonnet_role.md`
- `agents/commands/gemini_commands.md`
- `agents/commands/sonnet_commands.md`
- `agents/refresh/gemini_refresh.md`
- `agents/refresh/sonnet_refresh.md`
- `templates/07_MAU_MISSION_ACTIVE.md`
- `templates/16_MAU_LOG_EXECUTION.md`
- `README.md`
- `CHEAT_SHEET_10_GIAY.md`
- `SO_LENH_TONG_1_TRANG.md`
- `TOM_TAT_LENH_VA_CACH_DUNG.md`
- `PROMPT_NGAN_CHUAN_HOA_CHO_3_AGENT.md`
- `templates/02_GOI_GEMINI_THUC_THI_MISSION.md`
- `templates/03_GOI_GEMINI_RETRY.md`
- `templates/05_GOI_SONNET_VERIFY_VA_CHOT_DONE.md`

## Chuẩn mission mới
Khuyến nghị mission có thêm các field:
- `LAST_EXECUTION_STATUS`
- `LAST_VERIFY_RESULT`
- `NEXT_ACTION`
- `SONNET_HANDOFF_FOR_GEMINI`

## Chuẩn log mới
Log Gemini dùng:
- `[STATUS]: EXECUTION_DONE | FAIL`

## Flow mới sau verify fail
1. Gemini ghi log `EXECUTION_DONE` hoặc `FAIL`
2. Sonnet verify
3. Nếu fail nhưng còn sửa được:
   - cập nhật mission active hiện tại
   - ghi writeback ngắn cho Gemini vào mission
   - giữ task trong `missions/active/`
4. Gemini đọc lại mission mới nhất và làm tiếp

## Kết quả mong đợi
- không còn nhầm giữa “execution xong” và “mission done”
- không còn trường hợp Sonnet chỉ báo lỗi miệng mà mission không được cập nhật
- retry flow rõ hơn, ít lệch trạng thái hơn
