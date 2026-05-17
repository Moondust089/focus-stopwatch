# HƯỚNG DẪN DÙNG MISSION MẪU

Bộ này giúp Claude Sonnet tạo mission ngắn, rõ, dễ giao cho Gemini và dễ verify hơn.

## Khi dùng từng mẫu

- `11_MAU_MISSION_BUG.md`
  - dùng khi sửa lỗi
  - có lỗi tái hiện được
  - có verify rõ ràng
  - phù hợp bug syntax, runtime, import, logic hẹp, test fail, build fail

- `12_MAU_MISSION_FEATURE.md`
  - dùng khi thêm tính năng mới
  - có phạm vi rõ
  - cần mô tả trạng thái sau khi hoàn thành
  - phù hợp API nhỏ, chức năng mới, màn hình nhỏ không cần Stitch

- `13_MAU_MISSION_UI_STITCH.md`
  - dùng khi task thiên về UI vừa hoặc lớn
  - màn hình mới
  - redesign layout
  - cần visual polish, flow, consistency
  - theo flow mới: Sonnet tạo mission, Gemini chạy stitch_loop, Sonnet verify design

## Cách dùng nhanh cho Sonnet

1. Chọn đúng mẫu
2. Chỉ điền phần thật sự cần
3. Không nhét phân tích dài
4. FILES phải ít và đúng
5. VERIFY phải đo được
6. Luôn điền `LOG_PATH`
7. Với UI/STITCH:
   - tách rõ đây là phase design hay phase implementation
   - phase design: Gemini chạy stitch_loop
   - phase implementation: Gemini chỉ integrate theo design đã khóa
8. Nếu task lớn:
   - chia thành nhiều mission nhỏ
   - mỗi mission chỉ có 1 mục tiêu

## Nguyên tắc viết mission tốt

- ngắn hơn đẹp
- đủ để Gemini làm đúng
- không lặp lại yêu cầu người dùng dài dòng
- không suy diễn solution nếu chưa chốt
- EXPECTED phải mô tả kết quả quan sát được
- VERIFY phải có tín hiệu pass cụ thể
- với UI vừa/lớn, VERIFY ở phase design phải nói rõ “đủ để Sonnet lock design”

## Mẹo tiết kiệm token

- không mô tả toàn bộ repo
- không copy log dài vào mission
- chỉ ghi failure signature ngắn
- chỉ nêu file liên quan trực tiếp
- nếu cần context dài, để sang `mission_detail` ngắn riêng
