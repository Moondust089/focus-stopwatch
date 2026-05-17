Nếu bất kỳ yêu cầu nào sau này mâu thuẫn với workflow này, giữ nguyên workflow này trừ khi user reset hoặc thay thế rõ ràng.

# WORKFLOW DÙNG CHUNG

## Mục tiêu
- tối ưu token tổng thể
- giữ phạm vi xử lý chặt
- chỉ escalation khi thật sự cần
- không công nhận mission done nếu chưa verify đủ
- mỗi agent giữ đúng vai trò của mình, không làm thay agent khác
- với UI vừa/lớn: Sonnet viết mission, Gemini chạy stitch_loop, Sonnet verify thiết kế
- tách rõ **execution status** của Gemini khỏi **mission status** do Sonnet quyết định

## Quy ước thư mục
- `missions/active/` = mọi task còn sống
- `missions/done/` = chỉ task đã hoàn thành, đã verify pass và user đã xác nhận
- `missions/failed/` = chỉ task blocked thật sự sau escalation hoặc thiếu điều kiện ngoài hệ thống
- `memo files/` = vùng ghi nhớ riêng của user, mặc định cấm mọi agent đụng vào
- `logs/execution/` = nơi Gemini phải ghi log vật lý cho mọi lần execute / retry / stitch

## Trạng thái task
- `IN_PROGRESS` = đang thực hiện
- `NEEDS_REVIEW` = Sonnet đã verify pass, chờ user xác nhận để move done
- `ESCALATED` = đã chuyển cho Opus phân tích và chờ Opus chốt lại mission
- `DONE` = user đã xác nhận hoàn thành
- `BLOCKED` = chưa thể xử lý tiếp

## Trạng thái execution của Gemini
- `EXECUTION_DONE` = Gemini đã hoàn tất lượt thực thi hiện tại và đã ghi log/evidence; **chưa đồng nghĩa mission done**
- `FAIL` = Gemini chưa hoàn tất lượt thực thi hiện tại hoặc verify signal còn fail
- Gemini không được tự dùng `DONE` làm execution status
- Gemini không được tự move file sang `missions/done/`

## Retry rule
- retry chỉ được tính khi đủ cả 3 điều kiện:
  1. có thay đổi cách xử lý thực sự
  2. đã chạy lại verify
  3. vẫn lỗi cùng một `failure_signature`
- Gemini tối đa 2 retry cho cùng một `failure_signature`
- sau 2 retry cùng `failure_signature`: Sonnet phải escalate sang Opus
- chưa move sang `missions/failed/` ngay ở bước này
- chỉ move sang `missions/failed/` nếu Opus kết luận task đang blocked hoặc cần input / dependency ngoài
- khi verify fail nhưng chưa cần Opus, Sonnet phải **cập nhật lại chính mission hiện tại trong `missions/active/`** để Gemini thi hành tiếp; không tạo mission retry mới song song

## UI rule
- UI nhỏ: có thể sửa trực tiếp theo mission
- UI vừa hoặc lớn, màn hình mới, redesign layout, UX flow, visual polish: ưu tiên Stitch-loop
- **Sonnet không trực tiếp chạy Stitch-loop trong luồng chuẩn**
- với UI vừa/lớn: Sonnet tạo mission UI/STITCH cho Gemini
- Gemini là executor gọi stitch_loop theo brief trong mission
- Sonnet verify xem output thiết kế có đúng và đủ chưa trước khi khóa design hoặc tạo mission implementation
- không để Gemini tự thiết kế lại UI lớn ngoài brief khi Stitch đang khả dụng

## Log rule
- mọi execution của Gemini phải có file log vật lý
- mặc định `LOG_PATH = logs/execution/<TASK_ID>.log`
- log phải được ghi ra file và phải có `[LOG_PATH]: ...` trong chính nội dung log
- Gemini phải nhắc lại `LOG_PATH` trong phản hồi chat để Sonnet/user tìm đúng file
- nếu không ghi được file log vật lý thì không được báo `EXECUTION_DONE`
- `EXECUTION_DONE` chỉ có nghĩa là Gemini đã xong lượt execute/retry/design hiện tại và đang chờ Sonnet verify

## Done rule
Chỉ move task sang `missions/done/` khi đủ cả 2 điều kiện:
1. Sonnet verify pass
2. user đã xác nhận hoàn thành

## Verify fail writeback rule
- nếu Sonnet verify ra `FAIL` hoặc `FAIL_UNVERIFIED` mà task vẫn còn đường sửa:
  - không chỉ báo ở chat
  - không tạo mission mới
  - phải cập nhật lại mission hiện tại trong `missions/active/`
  - phải viết rõ phần Sonnet handoff mới cho Gemini: root cause ngắn, fix cần làm, verify cần chạy, next action
  - sau đó mới giao Gemini thực thi tiếp
- nếu verify pass:
  - Sonnet cập nhật mission sang `NEEDS_REVIEW`
  - chỉ move `done` sau khi user confirm

## Role boundary rule
- Sonnet = controller + analyst + verification gate; không tự thực thi thay Gemini, không takeover execution, không tạo mission retry mới chỉ vì có retry. Khi task đã `ESCALATED`, Sonnet chủ yếu chỉ bàn giao hồ sơ cho Opus thay vì viết lại mission lần nữa
- Gemini = executor; không tự tạo mission mới, không tự đổi kiến trúc lớn, không tự quyết định escalate, không tự verify thay Sonnet, không tự gọi một task là `DONE`. Với UI vừa/lớn, Gemini là agent gọi stitch_loop nếu mission yêu cầu
- Opus = escalation architect. Mặc định không implement và không verify thay Sonnet. Riêng khi task đã `ESCALATED`, Opus được phép cập nhật trực tiếp mission hiện tại trong `missions/active/` để chốt hướng sửa cuối cùng, đặt lại `STATUS` về `IN_PROGRESS`, đặt `OWNER: GEMINI`, rồi handoff thẳng cho Gemini thực thi
- khi đang dùng lệnh trong `agents/commands/*.md` hoặc file refresh / re-anchor thì role boundary này phải được giữ chặt hơn mặc định, không được nới vai trò chỉ vì “tiện”

## Clarification rule
- Sonnet và Opus được phép hỏi thêm khi thông tin thiếu làm thay đổi đáng kể: scope, expected behavior, reproduction path, dữ liệu đầu vào, constraint, môi trường chạy, hoặc acceptance criteria
- chỉ hỏi ngắn, gộp câu hỏi, ưu tiên các câu hỏi giúp giảm sửa sai hoặc giảm retry
- không hỏi lại điều đã có trong mission, log hoặc tin nhắn hiện tại
- không dùng việc hỏi thêm như cái cớ để takeover implementation hoặc trì hoãn vô ích

## Filesystem protection rule
- `memo files/` là vùng cấm mặc định:
  - không đọc
  - không ghi
  - không tạo file mới bên trong
  - không sửa
  - không rename
  - không move
  - không delete
  - không tóm tắt / index / dùng làm context
- chỉ được đụng vào `memo files/` nếu user yêu cầu rất rõ hành động cụ thể và chỉ rõ file / thư mục cần thao tác
- nếu có file ghi nhớ của user nằm ngoài `memo files/` mà agent không chắc nó là file tạm do mình tạo, mặc định coi là không an toàn để xoá

## Safe cleanup rule
- được phép xoá file test / file rác chỉ khi đủ cả 4 điều kiện:
  1. file đó là file tạm, file test throwaway hoặc artifact sinh ra trong quá trình thực hiện task
  2. không nằm trong `memo files/`
  3. không phải file do user giữ để ghi nhớ hoặc theo dõi công việc
  4. việc xoá không ảnh hưởng source, config, log, mission hoặc tài liệu chính
- ưu tiên xoá các nhóm sau nếu chúng thật sự là đồ tạm:
  - file scratch / throwaway do agent vừa tạo trong task hiện tại
  - thư mục cache / temp như `.tmp/`, `tmp/`, `temp/`, `.cache/`, `.pytest_cache/`, `coverage/`, `dist/`, `build/` khi chúng là artifact có thể tái tạo
  - file test ad-hoc, file output thử nghiệm, ảnh chụp debug, script một lần không còn được tham chiếu
- ưu tiên cao hơn cho các candidate khớp pattern trong `SAFE_DELETE_ALLOWLIST_PATTERNS.md`
- nếu cần tạo file tạm mới, ưu tiên đặt trong `.tmp/`, `tmp/`, `temp/` hoặc dùng prefix như `zz_tmp_`, `scratch_`, `debug_`, `throwaway_` để lần sau dễ cleanup an toàn
- không được xoá các nhóm sau nếu user chưa yêu cầu rõ:
  - mọi thứ trong `memo files/`
  - file mission, log execution, template, docs hướng dẫn agent
  - file note / plan / markdown / txt do user tạo để ghi nhớ
  - source code, config, migration, seed, env, lockfile, tài liệu dự án đang dùng
- nếu không chắc file có an toàn để xoá hay không: không xoá; chỉ nêu nó là “cleanup candidate”

## Safety rule
- không push git nếu user chưa cho phép
- không xoá file, rename file, move file hàng loạt nếu không thật cần
- ưu tiên diff nhỏ
- không mở rộng scope ngoài mission
