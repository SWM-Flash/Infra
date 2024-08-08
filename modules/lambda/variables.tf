# Lambda 모듈에서 필요한 변수 선언
variable "lambda_execution_role_arn" {
  description = "Lambda 함수의 실행 역할 ARN"
}

variable "api_gateway_execution_arn" {
  description = "API Gateway의 실행 ARN"
}

variable "bucket_name" {
  description = "S3 버킷의 이름"
  type        = string
}

variable "api_url" {
  description = "외부 API 서버의 URL"
  type        = string
}

variable "create_problem_lambda_function_name" {
  description = "Lambda 문제 생성 함수의 이름"
  type        = string
}

variable "create_problem_lambda_function_code_path" {
  description = "Lambda 문제 생성 함수 코드의 경로"
  type        = string
}

variable "get_presigned_url_lambda_function_name" {
  description = "Lambda presigned url 함수의 이름"
  type        = string
}

variable "get_presigned_url_lambda_function_code_path" {
  description = "Lambda presigned url 함수 코드의 경로"
  type        = string
}

variable "image_domain_name" {
  description = "이미지가 올라갈 주소"
  type        = string
}
