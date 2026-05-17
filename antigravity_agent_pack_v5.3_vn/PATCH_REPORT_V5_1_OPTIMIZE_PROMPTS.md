> Lưu ý: đây là patch report lịch sử. Luồng hiện hành được chuẩn hóa theo `PATCH_REPORT_V5_2_GEMINI_STITCH_FLOW.md` và các file hướng dẫn/role hiện tại.

# PATCH REPORT V5.1 - OPTIMIZE PROMPTS

## Mục tiêu
- tối ưu prompt ngắn để gọi agent nhanh hơn
- giữ nguyên ý tưởng cũ, không làm mất rule quan trọng
- sửa các chỗ tham chiếu còn lệch sau khi gộp lệnh Opus

## Đã sửa
- rút gọn và chuẩn hóa lại `PROMPT_NGAN_CHUAN_HOA_CHO_3_AGENT.md`
- đồng bộ bản copy nhanh trong `templates/15_PROMPT_NGAN_COPY_NHANH.md`
- sửa các chỗ còn ghi `Opus dùng lệnh 1 hoặc 2` thành `Opus dùng lệnh 1`
- giữ nguyên logic:
  - Sonnet escalate ngắn
  - Opus phân tích + chốt hướng + cập nhật mission luôn
  - Gemini chỉ thực thi mission

## Lưu ý
- không đổi version package
- không đổi tên folder và zip
- chỉ tối ưu wording và đồng bộ tham chiếu
