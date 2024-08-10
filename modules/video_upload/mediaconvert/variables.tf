variable "mediaconvert_iam_role_arn" {
	description = "MediaConvert IAM Role의 ARN"
}

variable "s3_input_bucket_name" {
	description = "S3 Input Bucket의 이름"
}

variable "s3_output_bucket_name" {
	description = "S3 Output Bucket의 이름"
}

variable "env_name" {
	description = "현재 환경 이름"
}
