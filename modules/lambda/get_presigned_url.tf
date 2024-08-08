# Lambda 함수 생성
resource "aws_lambda_function" "get_presigned_url" {
  filename         = var.get_presigned_url_lambda_function_code_path
  function_name    = var.get_presigned_url_lambda_function_name
  role             = var.lambda_execution_role_arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  source_code_hash = filebase64sha256(var.get_presigned_url_lambda_function_code_path)

  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
    }
  }
}

# API Gateway로부터 Lambda 호출 허용
resource "aws_lambda_permission" "allow_api_gateway_invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_presigned_url.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_gateway_execution_arn}/*/*"
}
