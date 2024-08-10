# Lambda 모듈에서 필요한 변수 선언
variable "env_name" {
  description = "현재 환경 이름"
  type        = string
}

variable "lambda_execution_role_arn" {
  description = "Lambda 함수의 실행 역할 ARN"
}

variable "api_gateway_execution_arn" {
  description = "API Gateway의 실행 ARN"
}

variable "input_bucket_name" {
  description = "S3 Input Bucket의 이름"
}

variable "output_bucket_name" {
  description = "S3 Output Bucket의 이름"
}

variable "mediaconvert_role_arn" {
  description = "MediaConvert의 IAM Role ARN"
}

variable "lambda_mediaconvert_role_arn" {
  description = "Lambda의 MediaConvert 컨트롤 IAM Role ARN"
}

variable "mediaconvert_queue_arn" {
  description = "MediaConvert Queue의 ARN"
}

variable "api_server_url" {
	description = "외부 API 서버의 기본 URL"
}

variable "cloudfront_domain" {
	description = "CloudFront의 도메인"
}

variable "mediaconvert_job_complete_rule_arn" {
  description = "EventBridge의 MediaConvert 트리거 Rule ARN"
}
