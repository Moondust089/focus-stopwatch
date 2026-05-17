# QUY TẮC DỌN RÁC VÀ BẢO VỆ FILE

## 1) Mục tiêu
Tài liệu này giúp agent có thể dọn file test / file rác trong project mà không xóa nhầm file nguồn, file note hoặc file ghi nhớ của user.

## 2) Vùng cấm tuyệt đối
- `memo files/`
- mọi file note / memo / checklist / plan do user tạo để ghi nhớ mà agent chưa chắc là file tạm
- mission, log execution, docs hướng dẫn agent

## 3) Được phép xóa khi nào
Chỉ được xóa khi đủ cả các điều kiện sau:
1. file là artifact tạm, throwaway, test ad-hoc hoặc output debug
2. không nằm trong `memo files/`
3. không phải file user giữ lại để ghi nhớ
4. không ảnh hưởng source, config, migration, env, lockfile, docs chính

## 4) Ví dụ thường an toàn để xóa
- file scratch do agent vừa tạo
- ảnh debug tạm
- output test tạm
- cache / temp / build artifact có thể tái tạo
- script thử nghiệm một lần không còn được tham chiếu

## 5) Ví dụ không được tự xóa
- mọi thứ trong `memo files/`
- file `.md`, `.txt`, note, plan của user
- mission / log / template / tài liệu pack
- source code, config, migration, seed, env, lockfile

## 6) Khi không chắc
Không xóa. Chỉ ghi nhận là `cleanup candidate` để user hoặc Sonnet quyết định.


## 7) Pattern an toàn hơn mặc định
Ưu tiên cao hơn cho candidate nằm trong:
- `.tmp/`, `tmp/`, `temp/`
- `.cache/`, `.pytest_cache/`, `coverage/`, `dist/`, `build/`

Ưu tiên cao hơn cho candidate có prefix:
- `zz_tmp_`
- `tmp_`
- `scratch_`
- `debug_`
- `throwaway_`

Nhưng đây chỉ là tín hiệu an toàn hơn, không thay thế rule kiểm tra thủ công.

## 8) Khuyến nghị đặt tên file tạm
Nếu bạn muốn agent cleanup dễ và an toàn hơn về sau:
- file tạm -> bỏ vào `.tmp/`, `tmp/`, `temp/`
- file throwaway -> đặt prefix `zz_tmp_`
- file cần giữ -> bỏ vào `memo files/`

## 9) Tài liệu tham chiếu nhanh
Xem thêm:
- `SAFE_DELETE_ALLOWLIST_PATTERNS.md`
- `PROMPT_NGAN_CHUAN_HOA_CHO_3_AGENT.md`
