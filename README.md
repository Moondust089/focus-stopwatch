# Focus Stopwatch

A minimalist stopwatch designed to anchor deep work and study sessions. Strips away notification badges and cluttered interfaces to provide a serene, hyper-focused timing experience.

## 🇬🇧 English Instructions

### Features
- **Local Storage Memory:** If you refresh (F5) the page, the timer keeps running.
- **Lap & Total Time Tracking:** Copy the total time or individual laps straight to Excel without formatting issues.

### How to Run on a New Computer
1. **Download/Clone** this repository to your computer.
2. Go to the project folder.
3. Double-click **`run stopwatch.bat`**. This will open the stopwatch in your default browser.
4. *(Optional) Create a Shortcut:* Right-click `run stopwatch.bat` > **Send to** > **Desktop (create shortcut)**. You can then right-click that new shortcut on your Desktop and choose **Pin to Start**.

*(Note: The `.bat` file uses `%~dp0` to automatically find the folder path, so you do NOT need to edit the code inside `.bat` when moving it to a new computer!)*

---

## 🇻🇳 Hướng Dẫn Sử Dụng (Tiếng Việt)

### Tính năng
- **Tự động lưu (Memory):** Nếu bạn vô tình F5 hoặc tắt nhầm, bấm lại vào web timer vẫn sẽ chạy tiếp.
- **Copy kết quả:** Copy riêng biệt tổng thời gian hoặc từng lap (dạng `hh:mm:ss`) để dán thẳng vào Excel.

### Cách chạy trên máy tính mới
1. **Tải về (Download)** toàn bộ thư mục này xuống máy tính.
2. Mở thư mục dự án vừa tải.
3. Bấm đúp (double-click) vào file **`run stopwatch.bat`** để chạy.
4. *(Tùy chọn) Pin to Start / Desktop:* Windows không cho phép Pin trực tiếp file `.bat`. Hãy sử dụng file **`Focus Stopwatch.lnk`** có sẵn trong thư mục này. Bạn có thể click chuột phải vào file `.lnk` đó và chọn **Pin to Start**, hoặc copy nó ra Desktop để dùng.

*(Lưu ý: File `.bat` đã được lập trình để tự động nhận diện thư mục hiện tại `%~dp0`, nên bạn **không cần** phải mở code ra để sửa đường dẫn khi mang sang máy khác! Tuy nhiên, file shortcut `.lnk` thì ghi nhớ đường dẫn cứng, nên khi sang máy khác bạn cần tự tạo lại shortcut bằng cách: Click phải Desktop -> New -> Shortcut -> nhập `cmd.exe /c "đường_dẫn_tới_file_run_stopwatch.bat"`)*
