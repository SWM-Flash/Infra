# API Gateway 통합 설정

# GET 메서드의 Lambda 통합
resource "aws_api_gateway_integration" "get_lambda_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.get_presigned_url_path.id
  http_method             = aws_api_gateway_method.get_presigned_url_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.get_presigned_url_lambda_function_arn}/invocations"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

# GET 메서드의 response
resource "aws_api_gateway_method_response" "get_response" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.get_presigned_url_path.id
  http_method             = aws_api_gateway_method.get_presigned_url_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

# GET 메서드의 integration response
resource "aws_api_gateway_integration_response" "get_integration_response" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.get_presigned_url_path.id
  http_method             = aws_api_gateway_method.get_presigned_url_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  response_templates = {
    "application/json" = "$input.json('$.body')"
  }

  depends_on = [aws_api_gateway_integration.get_lambda_integration, aws_api_gateway_method_response.get_response]
}

# OPTIONS 메서드의 MOCK 통합
resource "aws_api_gateway_integration" "options_mock_integration" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.get_presigned_url_path.id
  http_method = aws_api_gateway_method.options_method.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

# OPTIONS 메서드의 response
resource "aws_api_gateway_method_response" "options_response" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.get_presigned_url_path.id
  http_method = aws_api_gateway_method.options_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

# OPTIONS 메서드의 integration response
resource "aws_api_gateway_integration_response" "options_integration_response" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.get_presigned_url_path.id
  http_method = aws_api_gateway_method.options_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  response_templates = {
    "application/json" = ""
  }

	depends_on = [aws_api_gateway_method_response.options_response]
}