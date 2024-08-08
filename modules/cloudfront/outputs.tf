output "oai_arn" {
  value = aws_cloudfront_origin_access_identity.oai.iam_arn
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
