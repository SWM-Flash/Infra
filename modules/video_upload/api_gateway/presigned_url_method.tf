# GET 메서드 설정
resource "aws_api_gateway_method" "get_presigned_url_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.get_presigned_url_path.id
  http_method   = "GET"
  authorization = "NONE"
}

# OPTIONS 메서드 설정
resource "aws_api_gateway_method" "options_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.get_presigned_url_path.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
