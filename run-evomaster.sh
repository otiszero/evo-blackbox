#!/bin/bash

export TEST_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMDAxNSIsImVtYWlsIjoidHJ1bmcuaG9hbmcrdGVzdHVzZXJAc290YXRlay5jb20iLCJyb2xlIjoidXNlciIsIm9yZ2FuaXphdGlvbklkIjpudWxsLCJvcmdhbml6YXRpb25Pd25lciI6ZmFsc2UsImtleVRva2VuIjoiNDAwYmI2ODQtOWFmNi00MjkwLTg0ZTEtMDI0MTBlZTNiNDMyIiwidHlwIjoiQUNDRVNTIiwiaWF0IjoxNzY5NjU5NjI3LCJleHAiOjE3Njk3NDYwMjd9.T8zaY4iVD-0MAGYD4IPavzSw3yZrhcbd6iHyaUKEUTA"

java -jar evomaster.jar \
  --blackBox true \
  --bbSwaggerUrl https://test.api.processing.upmount.sotatek.works/docs-json \
  --outputFormat JS_JEST \
  --outputFolder ./evomaster-tests \
  --maxTime 30m \
  --header0 "Authorization:Bearer $TEST_TOKEN"
