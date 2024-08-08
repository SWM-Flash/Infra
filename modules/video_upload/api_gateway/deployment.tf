resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = var.rest_api_id
  stage_name  = var.stage_name

  depends_on = [
    aws_api_gateway_integration_response.get_integration_response,
    aws_api_gateway_integration_response.options_integration_response
  ]
}
