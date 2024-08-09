variable "s3_bucket_domain_name" {
  description = "S3 bucket의 도메인 이름"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket의 이름"
  type        = string
}

variable "s3_bucket_arn" {
  description = "S3 bucket의 ARN"
  type        = string
}

variable "video_s3_bucket_name" {
  description = "Video S3 bucket의 이름"
}

variable "video_s3_bucket_domain_name" {
  description = "Video S3 bucket의 도메인 이름"
}

variable "env_name" {
  description = "환경 변수 이름"
}
