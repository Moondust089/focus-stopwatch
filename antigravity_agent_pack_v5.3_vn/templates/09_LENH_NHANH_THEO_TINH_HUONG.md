# Lệnh nhanh theo tình huống

## 1) Bắt đầu task mới
Dùng file: `01_GOI_SONNET_KHOI_DONG_TASK_MOI.md`

## 2) Đã có mission, muốn Gemini làm ngay
Dùng file: `02_GOI_GEMINI_THUC_THI_MISSION.md`

## 3) Gemini fail nhẹ, còn đường sửa
Dùng file: `03_GOI_GEMINI_RETRY.md`

## 4) Gemini fail 2 lần cùng lỗi hoặc bug khó
Dùng file: `04_ESCALATE_SANG_OPUS.md`
Sau bước này, Opus sẽ viết lại mission và route thẳng sang Gemini nếu task còn đường xử lý tiếp.

## 5) Cần Sonnet verify trước khi chốt
Dùng file: `05_GOI_SONNET_VERIFY_VA_CHOT_DONE.md`

## 6) Agent bị trôi prompt
- lệch nhẹ/vừa: dùng file refresh tương ứng trong `agents/refresh/`
- lệch nặng: dùng `06_REANCHOR_CHUNG.md`

## 7) Muốn copy prompt cực ngắn cho đúng agent
- dùng file: `15_PROMPT_NGAN_COPY_NHANH.md`
