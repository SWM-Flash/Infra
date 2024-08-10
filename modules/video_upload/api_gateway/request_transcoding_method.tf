# GET 메서드 설정
resource "aws_api_gateway_method" "request_transcoding_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.problem_path.id
  http_method   = "POST"
  authorization = "NONE"
}

# OPTIONS 메서드 설정
resource "aws_api_gateway_method" "request_transcoding_options_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.problem_path.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
