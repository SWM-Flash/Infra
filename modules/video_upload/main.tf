module "s3" {
	source = "./s3"

	env_name = var.env_name
	account_id = var.account_id
}

module "lambda" {
	source = "./lambda"

	env_name = var.env_name
	lambda_execution_role_arn = var.lambda_execution_role_arn
	input_bucket_name = module.s3.input_bucket_name
	api_gateway_execution_arn = var.api_gateway_execution_arn
}