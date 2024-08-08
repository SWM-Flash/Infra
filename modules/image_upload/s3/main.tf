resource "aws_s3_bucket" "problem_image_bucket" {
  bucket = var.s3_bucket_name
  force_destroy = true

  tags = {
    Name        = "ProblemImageBucket"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.problem_image_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "problem_image_bucket_policy" {
  bucket = aws_s3_bucket.problem_image_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.problem_image_bucket.arn}/*"
        Principal = {
          AWS = var.origin_access_identity_arn
        }
      }
    ]
  })
}

resource "aws_s3_bucket_cors_configuration" "problem_image_bucket_cors" {
  bucket = aws_s3_bucket.problem_image_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
