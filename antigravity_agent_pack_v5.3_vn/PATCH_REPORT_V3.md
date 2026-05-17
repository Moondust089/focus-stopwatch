> Lưu ý: đây là patch report lịch sử. Luồng hiện hành được chuẩn hóa theo `PATCH_REPORT_V5_2_GEMINI_STITCH_FLOW.md` và các file hướng dẫn/role hiện tại.

# PATCH REPORT V3

## Mục tiêu bản vá
Bản v3 bổ sung hai thứ để dùng thực tế dễ hơn:
1. prompt ngắn chuẩn hóa, copy-paste nhanh cho Sonnet / Gemini / Opus
2. allowlist pattern cho cleanup an toàn, giúp Gemini bớt xoá nhầm file

## File mới
- `PROMPT_NGAN_CHUAN_HOA_CHO_3_AGENT.md`
- `SAFE_DELETE_ALLOWLIST_PATTERNS.md`
- `templates/15_PROMPT_NGAN_COPY_NHANH.md`

## File đã cập nhật
- `README.md`
- `CHEAT_SHEET_10_GIAY.md`
- `agents/_shared_workflow.md`
- `agents/gemini_role.md`
- `agents/commands/gemini_commands.md`
- `templates/00_MUC_LUC_TEMPLATE.md`
- `templates/02_GOI_GEMINI_THUC_THI_MISSION.md`
- `templates/03_GOI_GEMINI_RETRY.md`
- `templates/09_LENH_NHANH_THEO_TINH_HUONG.md`
- `QUY_TAC_DON_RAC_VA_BAO_VE_FILE.md`

## Thay đổi chính

### 1) Prompt ngắn chuẩn hóa
Thêm bộ prompt ngắn để bạn gọi:
- Sonnet mở task mới
- Sonnet tạo mission bug
- Sonnet viết writeback / retry note
- Sonnet verify
- Sonnet route UI vừa/lớn
- Gemini execute / retry
- Opus escalation / chọn hướng sửa
- re-anchor chung

### 2) Cleanup theo allowlist
Không thay đổi nguyên tắc an toàn cũ. Chỉ thêm:
- danh sách candidate có độ an toàn cao hơn mặc định
- naming convention cho file tạm: `.tmp/`, `tmp/`, `temp/`, `zz_tmp_`, `scratch_`, `debug_`, `throwaway_`
- cảnh báo cực mạnh với `.md`, `.txt`, `.json`, `.yaml`, `.sql`, `.env*`

### 3) Gemini được siết rõ hơn khi cleanup
Gemini giờ được nhắc:
- ưu tiên chỉ cleanup candidate khớp allowlist
- nếu cần tạo file tạm mới, dùng naming convention dễ cleanup
- nếu không chắc, chỉ ghi `CLEANUP_CANDIDATE`

## Kết quả kỳ vọng
- bạn copy prompt nhanh hơn
- giảm khả năng agent trôi vai
- giảm khả năng xoá nhầm file cần giữ
- dễ tạo quy ước file tạm trong project để cleanup an toàn về sau
