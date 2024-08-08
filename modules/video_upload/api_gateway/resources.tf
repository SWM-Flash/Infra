# /solution 경로 리소스
resource "aws_api_gateway_resource" "problem_path" {
  rest_api_id = var.rest_api_id
  parent_id   = var.root_resource_id
  path_part   = "solution"
}

# /solution/get-presigned-url 경로 리소스
resource "aws_api_gateway_resource" "get_presigned_url_path" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.problem_path.id
  path_part   = "get-presigned-url"
}