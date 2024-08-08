#!/bin/bash

# 새 Lambda 함수 디렉토리로 이동
cd src/create_problem

# 필요한 패키지 설치
pip3 install -r requirements.txt -t .

# Lambda 배포 패키지 생성
zip -r ../create_problem.zip .