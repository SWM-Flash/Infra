variable "env_name" {
  description = "현재 환경 이름"
  type        = string
}

variable "account_id" {
	description = "AWS 계정의 ID"
	type        = string
}

variable "origin_access_identity_arn" {
  description = "CloudFront Origin Access Identity의 ARN"
  type        = string
}
