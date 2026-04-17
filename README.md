```markdown
# DOCX Translator – Universal DOC/DOCX to HTML Converter

Công cụ chuyển đổi file Microsoft Word (`.doc` và `.docx`) sang HTML với định dạng gọn gàng, nhúng CSS và ảnh base64, tạo ra file HTML tự chứa (self-contained).

## Tính năng

- Chuyển đổi cả `.docx` (hiện đại) và `.doc` (cũ, nhị phân).
- Tự động chọn converter tốt nhất có sẵn: `mammoth` (ưu tiên cho `.docx`), `pandoc`, `LibreOffice`, hoặc Word COM (Windows).
- Nhúng CSS mặc định đẹp mắt (bảng, heading, danh sách, ...).
- Nhúng ảnh dưới dạng base64 – không cần thư mục ảnh đi kèm.
- Hoạt động trên Windows, Linux, macOS.

## Yêu cầu hệ thống

- Python 3.8 trở lên.
- **Tùy chọn 1 (khuyến nghị):** `mammoth` cho `.docx` + `pandoc` cho `.doc`
- **Tùy chọn 2:** `LibreOffice` (cho cả `.doc` và `.docx`)
- **Tùy chọn 3 (Windows):** Microsoft Word + `pywin32`

## Cài đặt

### 1. Clone / tải dự án về

Giả sử thư mục dự án có cấu trúc:

```
docx_translator/
├── pandoc_converter.py
├── input/                 # Chứa file .doc, .docx cần chuyển
├── output/                # Kết quả HTML sẽ được tạo ở đây
└── README.md
```

### 2. Tạo môi trường ảo (khuyến nghị)

```bash
python -m venv .venv
.venv\Scripts\activate      # Windows
source .venv/bin/activate   # Linux/macOS
```

### 3. Cài đặt các thư viện Python

```bash
pip install mammoth pypandoc pywin32   # pywin32 chỉ cần nếu dùng Word COM
```

Nếu bạn dùng `pandoc`, cần cài riêng binary Pandoc:

- **Windows:** `winget install --id JohnMacFarlane.Pandoc -e`
- **macOS:** `brew install pandoc`
- **Linux:** `sudo apt install pandoc`

Hoặc tải từ [pandoc.org](https://pandoc.org/installing.html)

### 4. (Không bắt buộc) Cài LibreOffice nếu không có Pandoc

- **Windows:** tải từ [libreoffice.org](https://www.libreoffice.org/download/)
- **Linux:** `sudo apt install libreoffice`
- **macOS:** `brew install --cask libreoffice`

## Cách sử dụng

### Lệnh cơ bản

```bash
python pandoc_converter.py input\ten_file.doc output\ten_file.html
```

Ví dụ:

```bash
python pandoc_converter.py input\legacy.doc output\legacy.html
python pandoc_converter.py input\report.docx output\report.html
```

### Các tùy chọn bổ sung

- `--prefer-pandoc` : dùng Pandoc cho `.docx` thay vì `mammoth`
- `--check-deps`    : kiểm tra các công cụ đã cài đặt

```bash
python pandoc_converter.py --check-deps
python pandoc_converter.py input\file.docx output\file.html --prefer-pandoc
```

### Xử lý file `.doc` cũ

Script sẽ tự động nâng cấp `.doc` lên `.docx` tạm thời (dùng LibreOffice hoặc Word COM) rồi dùng `mammoth` để chuyển. Bạn không cần làm gì thêm.

## Cấu trúc thư mục khuyến nghị

- Đặt tất cả file nguồn (`.doc`, `.docx`) vào thư mục `input/`.
- Kết quả HTML sẽ được ghi vào thư mục `output/`.
- File `pandoc_converter.py` nên để ở thư mục gốc (cùng cấp với `input`, `output`).

## Xử lý lỗi thường gặp

### Lỗi `No such file or directory`

**Nguyên nhân:** Đường dẫn đến script hoặc file nguồn sai.  
**Khắc phục:** Kiểm tra lại vị trí file `.py` và file `.doc`. Dùng lệnh `dir` (Windows) hoặc `ls` (Linux/macOS) để xem.

### Lỗi `Cannot convert legacy .doc file: no suitable converter found`

**Nguyên nhân:** Thiếu Pandoc, LibreOffice hoặc Word COM.  
**Khắc phục:** Cài một trong các công cụ đó theo hướng dẫn ở mục **Cài đặt**.

### Lỗi `mammoth is required for .docx conversion`

**Nguyên nhân:** Chưa cài `mammoth`.  
**Khắc phục:** `pip install mammoth`

## Ví dụ minh họa

```bash
# Kiểm tra dependencies
python pandoc_converter.py --check-deps

# Chuyển file .doc cũ
python pandoc_converter.py input\legacy.doc output\legacy.html

# Chuyển file .docx hiện đại
python pandoc_converter.py input\report.docx output\report.html

# Kết quả: file HTML có thể mở bằng bất kỳ trình duyệt nào

```markdown
## Sử dụng với Docker

### Build image

```bash
docker build -t code2html .
```

### Yêu cầu

- Docker đã cài đặt.
- Image bao gồm Python, Pandoc, **LibreOffice** (cần thiết để đọc file `.doc` cũ).

### Chạy chuyển đổi

**Windows (PowerShell):**
```powershell
docker run --rm -v "${PWD}:/data" code2html /data/input/legacy.doc /data/output/legacy.html
```

**Windows (CMD):**
```cmd
docker run --rm -v "%cd%:/data" code2html /data/input/legacy.doc /data/output/legacy.html
```

**Linux/macOS:**
```bash
docker run --rm -v "$(pwd):/data" code2html /data/input/legacy.doc /data/output/legacy.html
```

### Kiểm tra dependencies trong container

```bash
docker run --rm code2html --check-deps
```

MIT
