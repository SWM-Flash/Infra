# Lambda 함수 생성
resource "aws_lambda_function" "get_presigned_url" {
  filename         = "${path.module}/../src/solution_bucket_get_presigned_url.zip"
  function_name    = "SolutionGetPresignedUrlFunction-${var.env_name}"
  role             = var.lambda_execution_role_arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  source_code_hash = filebase64sha256("${path.module}/../src/presigned_url/lambda_function.py")

  environment {
    variables = {
      BUCKET_NAME = var.input_bucket_name
    }
  }

  depends_on = [ null_resource.run_solution_bucket_presigned_url_script ]
}

# API Gateway로부터 Lambda 호출 허용
resource "aws_lambda_permission" "allow_api_gateway_invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_presigned_url.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_gateway_execution_arn}/*/*"
}
