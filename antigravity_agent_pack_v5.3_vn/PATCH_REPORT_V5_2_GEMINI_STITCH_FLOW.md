# PATCH REPORT V5.2 - GEMINI STITCH FLOW + LOG HARDENING

## Mục tiêu của bản vá
- đổi luồng UI vừa/lớn sang: **Sonnet viết mission -> Gemini chạy stitch_loop -> Sonnet verify design**
- khắc phục tình huống Sonnet verify nhưng báo “không có log”
- đồng bộ lại file role, command, template và cheat sheet

## Vì sao trước đây Sonnet dễ báo “không có log”
Có 3 điểm lệch chính:
1. tài liệu cũ còn để Sonnet “có thể tự chạy Stitch-loop”
2. mission UI cũ chưa khóa rõ `STITCH_EXECUTOR: GEMINI`
3. hướng dẫn cũ chỉ nói Gemini “ghi log đúng format” nhưng chưa ép đủ mạnh việc:
   - phải có file log vật lý
   - phải có `LOG_PATH`
   - phải nhắc lại `LOG_PATH` trong phản hồi chat

## Thay đổi chính

### 1) Flow UI mới
- Sonnet không trực tiếp chạy Stitch-loop trong luồng chuẩn
- Sonnet tạo mission UI/STITCH cho Gemini
- Gemini dùng lệnh 3 để chạy stitch_loop theo mission
- Sonnet dùng lệnh 6 để verify design đúng brief và đủ để lock chưa
- chỉ sau khi design pass mới sang implementation

### 2) Log được siết chặt
- mọi mission đều có `LOG_PATH`
- Gemini phải ghi file log vật lý thật
- log phải có `[LOG_PATH]: ...`
- Gemini phải nhắc lại `LOG_PATH` trong phản hồi chat
- không ghi được file log vật lý => không được báo `EXECUTION_DONE`

### 3) Template mission UI mới
- thêm `STITCH_REQUIRED: YES`
- thêm `STITCH_EXECUTOR: GEMINI`
- thêm `PHASE: DESIGN_GENERATION`
- thêm `IMPLEMENT_AFTER_SONNET_VERIFY: NO`
- thêm phần `BRIEF FOR STITCH`

### 4) File hướng dẫn lệnh tắt đã đồng bộ
- cheat sheet
- sổ lệnh 1 trang
- prompt copy nhanh
- hướng dẫn đầy đủ
- mục lục command/template

## File đã chỉnh
- `README.md`
- `agents/_shared_workflow.md`
- `agents/sonnet_role.md`
- `agents/gemini_role.md`
- `agents/commands/00_MUC_LUC_SO_LENH.md`
- `agents/commands/sonnet_commands.md`
- `agents/commands/gemini_commands.md`
- `agents/refresh/sonnet_refresh.md`
- `agents/refresh/gemini_refresh.md`
- `CHEAT_SHEET_10_GIAY.md`
- `SO_LENH_TONG_1_TRANG.md`
- `TOM_TAT_LENH_VA_CACH_DUNG.md`
- `HUONG_DAN_DAY_DU_DUNG_COMMANDS_VA_AGENT.md`
- `PROMPT_NGAN_CHUAN_HOA_CHO_3_AGENT.md`
- `templates/00_MUC_LUC_TEMPLATE.md`
- `templates/01_GOI_SONNET_KHOI_DONG_TASK_MOI.md`
- `templates/02_GOI_GEMINI_THUC_THI_MISSION.md`
- `templates/03_GOI_GEMINI_RETRY.md`
- `templates/05_GOI_SONNET_VERIFY_VA_CHOT_DONE.md`
- `templates/07_MAU_MISSION_ACTIVE.md`
- `templates/10_HUONG_DAN_DUNG_MISSION_MAU.md`
- `templates/11_MAU_MISSION_BUG.md`
- `templates/12_MAU_MISSION_FEATURE.md`
- `templates/13_MAU_MISSION_UI_STITCH.md`
- `templates/14_LENH_NHANH_TAO_MISSION_THEO_LOAI.md`
- `templates/15_PROMPT_NGAN_COPY_NHANH.md`
- `templates/16_MAU_LOG_EXECUTION.md`
- `logs/execution/README.txt`

## Kết quả kỳ vọng sau vá
- vai trò giữa Sonnet và Gemini rõ hơn
- giảm token vì Sonnet không trực tiếp làm Stitch-loop
- verify ổn định hơn do log có path cố định và bắt buộc tồn tại thật
- file hướng dẫn ngắn và file hướng dẫn đầy đủ không còn mâu thuẫn nhau
