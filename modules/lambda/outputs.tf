# Lambda 함수의 ARN을 출력하여 다른 모듈에서 사용할 수 있도록 설정
output "lambda_function_arn" {
  value = aws_lambda_function.get_presigned_url.arn
}

output "create_problem_lambda_arn" {
  value = aws_lambda_function.create_problem.arn
}
