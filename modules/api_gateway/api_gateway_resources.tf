# API Gateway 경로 리소스 설정

# /problem 경로 리소스
resource "aws_api_gateway_resource" "problem_path" {
  rest_api_id = aws_api_gateway_rest_api.example_api.id
  parent_id   = aws_api_gateway_rest_api.example_api.root_resource_id
  path_part   = "problem"
}

# /problem/get-presigned-url 경로 리소스
resource "aws_api_gateway_resource" "get_presigned_url_path" {
  rest_api_id = aws_api_gateway_rest_api.example_api.id
  parent_id   = aws_api_gateway_resource.problem_path.id
  path_part   = "get-presigned-url"
}
