# API Gateway 통합 설정

# POST 메서드의 Lambda 통합
resource "aws_api_gateway_integration" "request_transcoding_lambda_post" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.problem_path.id
  http_method             = aws_api_gateway_method.request_transcoding_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.request_transcoding_lambda_function_arn}/invocations"
}

# POST 메서드의 response
resource "aws_api_gateway_method_response" "request_transcoding_post" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.problem_path.id
  http_method             = aws_api_gateway_method.request_transcoding_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

# POST 메서드의 integration response
resource "aws_api_gateway_integration_response" "request_transcoding_post" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.problem_path.id
  http_method             = aws_api_gateway_method.request_transcoding_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  response_templates = {
    "application/json" = ""
  }

  depends_on = [aws_api_gateway_integration.request_transcoding_lambda_post, aws_api_gateway_method_response.request_transcoding_post]
}

# OPTIONS 메서드의 MOCK 통합
resource "aws_api_gateway_integration" "request_transcoding_mock_options" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.problem_path.id
  http_method             = aws_api_gateway_method.request_transcoding_options_method.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

# OPTIONS 메서드의 response
resource "aws_api_gateway_method_response" "request_transcoding_options" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.problem_path.id
  http_method             = aws_api_gateway_method.request_transcoding_options_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

# OPTIONS 메서드의 integration response
resource "aws_api_gateway_integration_response" "request_transcoding_options" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.problem_path.id
  http_method             = aws_api_gateway_method.request_transcoding_options_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  response_templates = {
    "application/json" = ""
  }

	depends_on = [aws_api_gateway_integration.request_transcoding_mock_options, aws_api_gateway_method_response.request_transcoding_options]
}