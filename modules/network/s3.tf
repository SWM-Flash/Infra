resource "aws_s3_bucket" "environment_file_bucket" {
  bucket = "environment-${var.account_id}-${var.env_suffix}"
}
