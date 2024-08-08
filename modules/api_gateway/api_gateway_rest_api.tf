# API Gateway REST API 생성

resource "aws_api_gateway_rest_api" "example_api" {
  name        = var.api_gateway_name
  description = "Lambda 함수를 호출하기 위한 ${var.stage_name} 환경 API Gateway"
}
