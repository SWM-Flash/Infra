# API Gateway 모듈에서 필요한 변수 선언
variable "lambda_function_arn" {
  description = "API Gateway가 호출할 Lambda 함수의 ARN"
}

variable "create_problem_lambda_arn" {
  description = "API Gateway가 호출할 문제 생성 Lambda 함수의 ARN"
}

variable "aws_region" {
  description = "AWS 리전"
}

variable "stage_name" {
  description = "배포 스테이지 이름"
}

variable "api_gateway_name" {
  description = "API Gateway의 이름"
}
