variable "env_name" {
  description = "현재 환경 이름"
  type        = string
}

variable "account_id" {
	description = "AWS 계정의 ID"
	type        = string
}

variable "lambda_execution_role_arn" {
	description = "Lambda 함수 IAM Role의 ARN"
	type        = string
}

variable "api_gateway_execution_arn" {
  description = "API Gateway의 실행 ARN"
}
