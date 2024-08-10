output "get_presigned_url_arn" {
	value = aws_lambda_function.get_presigned_url.arn
}

output "request_transcoding_arn" {
	value = aws_lambda_function.request_transcoding.arn
}

output "create_solution_arn" {
	value = aws_lambda_function.create_solution.arn
}
