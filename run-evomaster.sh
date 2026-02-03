#!/bin/bash

# ============================================
# CẤU HÌNH - Thay đổi các giá trị bên dưới
# ============================================

# JWT Token để authenticate với API
# Lấy token từ login hoặc developer tools của browser
export TEST_TOKEN="YOUR_JWT_TOKEN_HERE"

# URL của OpenAPI/Swagger JSON spec
SWAGGER_URL="https://your-api.com/docs-json"

# Thời gian chạy tối đa (ví dụ: 10m, 30m, 1h)
MAX_TIME="30m"

# ============================================
# CHẠY EVOMASTER - Không cần sửa phần này
# ============================================

java -jar evomaster.jar \
  --blackBox true \
  --bbSwaggerUrl "$SWAGGER_URL" \
  --outputFormat JS_JEST \
  --outputFolder ./evomaster-tests \
  --maxTime "$MAX_TIME" \
  --header0 "Authorization:Bearer $TEST_TOKEN"
