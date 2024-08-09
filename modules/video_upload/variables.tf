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

variable "rest_api_id" {
	description = "API Gateway의 ID"
}

variable "root_resource_id" {
	description = "API Gateway의 root 리소스 ID"
}

variable "aws_region" {
  description = "AWS 리전"
}

variable "origin_access_identity_arn" {
  description = "CloudFront Origin Access Identity의 ARN"
  type        = string
}