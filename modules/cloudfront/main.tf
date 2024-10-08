resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "${var.env_name} OAI for S3 access"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.s3_bucket_domain_name
    origin_id   = "S3-${var.s3_bucket_name}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  origin {
    domain_name = var.video_s3_bucket_domain_name
    origin_id   = "S3-${var.video_s3_bucket_name}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.env_name} S3 bucket distribution"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "S3-${var.s3_bucket_name}"

    viewer_protocol_policy = "redirect-to-https"

    cache_policy_id                = "658327ea-f89d-4fab-a63d-7e88639e58f6"  # CachingOptimized
    origin_request_policy_id       = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf"  # CORS-S3Origin
    response_headers_policy_id     = "5cc3b908-e619-4b99-88e5-2cf7f45965bd"  # Managed-CORS-With-Preflight
  }

  ordered_cache_behavior {
    path_pattern     = "/videos/*"  # video S3 버킷에 매핑된 경로
    target_origin_id = "S3-${var.video_s3_bucket_name}"  # video S3 버킷의 origin_id

    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]

    viewer_protocol_policy = "redirect-to-https"

    cache_policy_id                = "658327ea-f89d-4fab-a63d-7e88639e58f6"  # CachingOptimized
    origin_request_policy_id       = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf"  # CORS-S3Origin
    response_headers_policy_id     = "5cc3b908-e619-4b99-88e5-2cf7f45965bd"  # Managed-CORS-With-Preflight
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    "Type" = "${var.env_name}"
  }
}