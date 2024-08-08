variable "s3_bucket_name" {
  description = "s3 bucket의 이름"
  type        = string
}

variable "origin_access_identity_arn" {
  description = "CloudFront Origin Access Identity의 ARN"
  type        = string
}