output "bucket_regional_domain_name" {
  value = aws_s3_bucket.problem_image_bucket.bucket_regional_domain_name
}

output "bucket_arn" {
  value = aws_s3_bucket.problem_image_bucket.arn
}
