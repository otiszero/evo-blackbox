# EvoMaster - API Fuzzing Tool

EvoMaster là công cụ tự động sinh test case cho REST API sử dụng thuật toán tiến hóa (evolutionary algorithm). Nó phân tích OpenAPI/Swagger spec và tự động tạo các test case để tìm lỗi trong API.

## Yêu cầu hệ thống

- macOS (hoặc Linux/Windows)
- Java 11 trở lên
- Node.js 16+ và npm (để chạy test)

## Cài đặt

### 1. Cài đặt Java

```bash
# Sử dụng Homebrew
brew install openjdk@17

# Hoặc tải từ https://adoptium.net/
```

Kiểm tra phiên bản Java:
```bash
java -version
```

### 2. Tải EvoMaster

Tải file `evomaster.jar` từ GitHub Releases:

```bash
# Tải phiên bản mới nhất (v5.0.2)
curl -L -o evomaster.jar https://github.com/WebFuzzing/EvoMaster/releases/download/v5.0.2/evomaster.jar

# Hoặc tải thủ công từ:
# https://github.com/WebFuzzing/EvoMaster/releases
```

### 3. Cài đặt Node.js dependencies

```bash
npm install
```

Các package cần thiết:
- `superagent` - HTTP client cho test
- `jest` - Test framework
- `urijs` - Xử lý URI

## Cấu hình

### File `em.yaml`

File cấu hình chính cho EvoMaster. Các tham số quan trọng:

| Tham số | Mô tả | Ví dụ |
|---------|-------|-------|
| `blackBox` | Chế độ black-box testing | `true` |
| `bbSwaggerUrl` | URL của OpenAPI/Swagger spec | `https://api.example.com/docs-json` |
| `outputFormat` | Định dạng output test | `JS_JEST`, `JAVA_JUNIT5`, `PYTHON_UNITTEST` |
| `outputFolder` | Thư mục chứa test được sinh ra | `./evomaster-tests` |
| `maxTime` | Thời gian chạy tối đa | `30m`, `1h` |
| `header0` | Header tùy chỉnh (authentication) | `Authorization:Bearer <token>` |

### Cấu hình Authentication

Thêm header authentication trong `em.yaml` hoặc script:

```yaml
configs:
  header0: "Authorization:Bearer YOUR_JWT_TOKEN"
```

## Chạy EvoMaster

### Cách 1: Sử dụng script có sẵn

```bash
chmod +x run-evomaster.sh
./run-evomaster.sh
```

### Cách 2: Chạy trực tiếp với Java

```bash
java -jar evomaster.jar \
  --blackBox true \
  --bbSwaggerUrl https://your-api.com/docs-json \
  --outputFormat JS_JEST \
  --outputFolder ./evomaster-tests \
  --maxTime 30m \
  --header0 "Authorization:Bearer YOUR_TOKEN"
```

### Cách 3: Sử dụng file cấu hình

```bash
java -jar evomaster.jar --configPath em.yaml
```

## Chạy Test đã sinh

Sau khi EvoMaster hoàn thành, chạy test với Jest:

```bash
# Chạy tất cả test
npx jest evomaster-tests/

# Chạy từng file test
npx jest evomaster-tests/EvoMaster_successes_Test.js
npx jest evomaster-tests/EvoMaster_faults_Test.js
npx jest evomaster-tests/EvoMaster_others_Test.js
```

## Cấu trúc Output

```
evomaster-tests/
├── EvoMaster_successes_Test.js  # Test cases thành công (2xx)
├── EvoMaster_faults_Test.js     # Test cases phát hiện lỗi (5xx)
├── EvoMaster_others_Test.js     # Test cases khác (4xx, redirect)
├── EMTestUtils.js               # Utility functions
├── report.json                  # Báo cáo chi tiết JSON
├── index.html                   # Báo cáo HTML
└── assets/                      # CSS/JS cho báo cáo
```

## Giải thích các loại Test

### 1. Successes Test
Test các endpoint trả về response thành công (HTTP 2xx). Kiểm tra:
- Response status code
- Content-Type header
- Cấu trúc response body

### 2. Faults Test
Test phát hiện các lỗi tiềm ẩn:
- HTTP 500 Internal Server Error
- Lỗi authentication không đúng
- Security vulnerabilities

### 3. Others Test
Test các trường hợp khác:
- HTTP 400 Bad Request (validation errors)
- HTTP 401 Unauthorized
- HTTP 403 Forbidden
- HTTP 404 Not Found

## Xem báo cáo

### Web Report
```bash
# macOS
./evomaster-tests/webreport.command

# Hoặc sử dụng Python
python evomaster-tests/webreport.py
```

### JSON Report
File `evomaster-tests/report.json` chứa:
- Tổng số lỗi phát hiện
- Danh sách endpoints được test
- HTTP status codes covered
- Chi tiết từng test case

## Tham số nâng cao

```bash
java -jar evomaster.jar --help
```

Một số tham số hữu ích:

| Tham số | Mô tả |
|---------|-------|
| `--endpointFocus` | Chỉ test các endpoint cụ thể |
| `--endpointExclude` | Loại trừ endpoint khỏi test |
| `--ratePerMinute` | Giới hạn số request/phút |
| `--testTimeout` | Timeout cho mỗi test (giây) |

## Tài liệu tham khảo

- [EvoMaster GitHub](https://github.com/WebFuzzing/EvoMaster)
- [Danh sách đầy đủ các options](https://github.com/WebFuzzing/EvoMaster/blob/master/docs/options.md)
- [Hướng dẫn Authentication](https://github.com/WebFuzzing/EvoMaster/blob/master/docs/auth.md)
