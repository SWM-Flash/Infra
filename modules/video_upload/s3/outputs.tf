output "input_bucket_name" {
	value = aws_s3_bucket.solution_video_input_bucket.bucket
}

output "input_bucket_arn" {
	value = aws_s3_bucket.solution_video_input_bucket.arn
}

output "output_bucket_name" {
	value = aws_s3_bucket.solution_video_output_bucket.bucket
}

output "output_bucket_arn" {
	value = aws_s3_bucket.solution_video_output_bucket.arn
}

output "output_bucket_domain_name" {
	value = aws_s3_bucket.solution_video_output_bucket.bucket_regional_domain_name
}
