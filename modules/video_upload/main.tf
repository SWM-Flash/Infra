module "s3" {
	source = "./s3"

	env_name = var.env_name
	account_id = var.account_id
	origin_access_identity_arn = var.origin_access_identity_arn
}

module "lambda" {
	source = "./lambda"

	env_name = var.env_name
	lambda_execution_role_arn = var.lambda_execution_role_arn
	input_bucket_name = module.s3.input_bucket_name
	api_gateway_execution_arn = var.api_gateway_execution_arn
}

module "api_gateway" {
	source = "./api_gateway"

	rest_api_id = var.rest_api_id
	root_resource_id = var.root_resource_id
	stage_name = var.env_name
	aws_region = var.aws_region
	get_presigned_url_lambda_function_arn = module.lambda.get_presigned_url_arn
}

module "iam" {
	source = "./iam"

	env_name = var.env_name

	s3_input_bucket_arn = module.s3.input_bucket_arn
	s3_output_bucket_arn = module.s3.output_bucket_arn
}
