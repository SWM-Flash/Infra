# Lambda 함수 생성
resource "aws_lambda_function" "request_transcoding" {
  filename         = "${path.module}/../src/request_transcoding.zip"
  function_name    = "RequestTranscoding-${var.env_name}"
  role             = var.lambda_mediaconvert_role_arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  source_code_hash = filebase64sha256("${path.module}/../src/request_transcoding/lambda_function.py")
  timeout          = 20

  environment {
    variables = {
      INPUT_BUCKET_NAME = var.input_bucket_name
			OUTPUT_BUCKET_NAME = var.output_bucket_name
			MEDIACONVERT_ROLE_ARN = var.mediaconvert_role_arn
    }
  }

  depends_on = [ null_resource.request_transcoding_script ]
}

# API Gateway로부터 Lambda 호출 허용
resource "aws_lambda_permission" "request_transcoding_allow_api_gateway_invoke" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.request_transcoding.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_gateway_execution_arn}/*/*"
}
