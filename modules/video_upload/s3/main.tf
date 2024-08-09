resource "aws_s3_bucket" "solution_video_input_bucket" {
  bucket = "solution-video-input-bucket-${var.account_id}-${var.env_name}"

}

resource "aws_s3_bucket" "solution_video_output_bucket" {
  bucket = "solution-video-output-bucket-${var.account_id}-${var.env_name}"

}

resource "aws_s3_bucket_policy" "solution_video_output_bucket_policy" {
  bucket = aws_s3_bucket.solution_video_output_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.solution_video_output_bucket.arn}/*"
        Principal = {
          AWS = var.origin_access_identity_arn
        }
      }
    ]
  })
}

resource "aws_s3_bucket_cors_configuration" "solution_video_output_bucket_cors" {
  bucket = aws_s3_bucket.solution_video_output_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
