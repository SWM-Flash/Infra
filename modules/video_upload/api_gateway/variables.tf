variable "rest_api_id" {
	description = "API Gateway의 ID"
}

variable "root_resource_id" {
	description = "API Gateway의 root 리소스 ID"
}

variable "stage_name" {
  description = "배포 스테이지 이름"
}

variable "aws_region" {
  description = "AWS 리전"
}

variable "get_presigned_url_lambda_function_arn" {
  description = "API Gateway가 호출할 presigned url Lambda 함수의 ARN"
}

variable "request_transcoding_lambda_function_arn" {
  description = "API Gateway가 호출할 request transcoding Lambda 함수의 ARN"
}
