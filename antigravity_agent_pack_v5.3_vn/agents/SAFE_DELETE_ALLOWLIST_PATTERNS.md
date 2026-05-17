# SAFE DELETE ALLOWLIST PATTERNS

Tài liệu này không cho phép agent xoá bừa. Nó chỉ giúp xác định nhóm candidate **an toàn hơn mặc định** để cleanup.

## 1) Nguyên tắc gốc
Chỉ cleanup khi vẫn thỏa toàn bộ rule trong:
- `agents/_shared_workflow.md`
- `QUY_TAC_DON_RAC_VA_BAO_VE_FILE.md`

Nếu candidate khớp pattern dưới đây nhưng lại là file user muốn giữ, file đang được tham chiếu, hoặc nằm trong `memo files/` thì **vẫn không được xoá**.

## 2) Thư mục thường an toàn hơn để cleanup
Ưu tiên cao hơn nếu thư mục này rõ ràng là artifact có thể tái tạo:
- `.tmp/`
- `tmp/`
- `temp/`
- `.cache/`
- `.pytest_cache/`
- `coverage/`
- `dist/`
- `build/`

## 3) Prefix filename thường an toàn hơn để cleanup
Ưu tiên cao hơn cho file do agent tạo với prefix:
- `zz_tmp_`
- `tmp_`
- `scratch_`
- `debug_`
- `throwaway_`

Ví dụ:
- `zz_tmp_login_probe.js`
- `scratch_state_dump.txt`
- `debug_auth_capture.png`

## 4) Suffix / extension thường an toàn hơn để cleanup
Chỉ là tín hiệu hỗ trợ, không phải quyền xoá tự động:
- `.tmp`
- `.temp`
- `.cache`
- `.bak`
- `.old`
- `.orig`

## 5) File debug / artifact thử nghiệm thường an toàn hơn nếu đúng ngữ cảnh
- ảnh chụp debug tạm
- output test ad-hoc
- script một lần để probe / reproduce bug
- report coverage sinh tự động
- build artifact sinh tự động

## 6) Nhóm cần cực kỳ thận trọng
Dù tên có vẻ tạm, mặc định **không tự xoá** nếu chưa chắc:
- `.md`
- `.txt`
- `.csv`
- `.json`
- `.yaml` / `.yml`
- `.sql`
- `.env*`

Lý do: đây thường là note, checklist, seed, config hoặc dữ liệu user giữ lại.

## 7) Pattern bảo vệ mặc định
Không tự xoá:
- mọi thứ trong `memo files/`
- `missions/**`
- `logs/execution/**`
- `agents/**`
- `templates/**`
- file docs của pack
- source code chính, config, migration, seed, lockfile

## 8) Cách dùng khuyến nghị
Nếu muốn agent cleanup an toàn hơn:
1. bảo mọi file nhớ quan trọng phải để trong `memo files/`
2. file tạm do agent tạo nên đặt trong `.tmp/`, `tmp/`, `temp/`
3. hoặc dùng prefix `zz_tmp_` cho file throwaway
4. nếu agent không chắc, chỉ đánh dấu `CLEANUP_CANDIDATE`, không xoá
