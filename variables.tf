# Common
variable "aws_access_key" {
  description = "AWS 계정 access key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS 계정 secret key"
  type        = string
}

variable "aws_region" {
  description = "AWS 리소스가 생성될 지역"
	type        = string
  default     = "ap-northeast-2"
}

variable "env_name" {
  description = "현재 환경 이름"
  type        = string
}

# IAM
variable "lambda_iam_role_name" {
  description = "lambda 함수의 IAM Role 이름"
  type        = string
}

# Lambda
variable "api_url" {
  description = "외부 API 서버의 기본 URL"
  type        = string
}

variable "create_problem_lambda_function_name" {
  description = "Lambda 문제 생성 함수의 이름"
  type        = string
}

variable "create_problem_lambda_function_code_path" {
  description = "Lambda 문제 생성 함수 코드의 경로"
  type        = string
  default     = "src/create_problem.zip"
}

variable "get_presigned_url_lambda_function_name" {
  description = "Lambda presigned url 함수의 이름"
  type        = string
}

variable "get_presigned_url_lambda_function_code_path" {
  description = "Lambda presigned url 함수 코드의 경로"
  type        = string
  default     = "src/problem_bucket_get_presigned_url.zip"
}

variable "api_gateway_name" {
  description = "API Gateway의 이름"
  type        = string
}
