# API Gateway 배포 설정

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.example_api.id
  stage_name  = var.stage_name

  depends_on = [
    aws_api_gateway_method.post_problem_method,
    aws_api_gateway_integration.post_lambda_integration,
    aws_api_gateway_method_response.post_response,
    aws_api_gateway_integration_response.post_integration_response,
    aws_api_gateway_method.options_problem_method,
    aws_api_gateway_integration.options_problem_mock_integration,
    aws_api_gateway_method_response.options_problem_response,
    aws_api_gateway_integration_response.options_problem_integration_response
  ]
}
