# API Gateway의 실행 ARN 출력
output "execution_arn" {
  value = aws_api_gateway_rest_api.example_api.execution_arn
}

output "api_gateway_url" {
  value = "https://${aws_api_gateway_rest_api.example_api.id}.execute-api.${var.aws_region}.amazonaws.com/${var.stage_name}"
}
