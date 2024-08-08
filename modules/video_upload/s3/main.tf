resource "aws_s3_bucket" "solution-video-input-bucket" {
  bucket = "solution-video-input-bucket-${var.account_id}-${var.env_name}"

}
