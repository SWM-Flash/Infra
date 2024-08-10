variable "create_solution_lambda_function_arn" {
	description = "Create Solution Lambda 함수의 ARN"
}

variable "env_name" {
  description = "현재 환경 이름"
  type        = string
}

variable "mediaconvert_queue_arn" {
  description = "MediaConvert 작업 Queue의 ARN"
}
