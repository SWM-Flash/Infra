# POST 메서드 설정
resource "aws_api_gateway_method" "post_problem_method" {
  rest_api_id   = aws_api_gateway_rest_api.example_api.id
  resource_id   = aws_api_gateway_resource.problem_path.id
  http_method   = "POST"
  authorization = "NONE"
}

# OPTIONS 메서드 설정
resource "aws_api_gateway_method" "options_problem_method" {
  rest_api_id   = aws_api_gateway_rest_api.example_api.id
  resource_id   = aws_api_gateway_resource.problem_path.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}
