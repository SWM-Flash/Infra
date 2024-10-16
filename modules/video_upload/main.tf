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

	output_bucket_name = module.s3.output_bucket_name
	mediaconvert_role_arn = module.iam.mediaconvert_role_arn
	mediaconvert_queue_arn = module.mediaconvert.mediaconvert_queue_arn
	lambda_mediaconvert_role_arn = module.iam.lambda_mediaconvert_role_arn

	api_server_url = var.api_server_url
	cloudfront_domain = var.cloudfront_domain
	mediaconvert_job_complete_rule_arn = module.eventbridge.mediaconvert_job_complete_rule_arn
}

module "api_gateway" {
	source = "./api_gateway"

	rest_api_id = var.rest_api_id
	root_resource_id = var.root_resource_id
	stage_name = var.env_name
	aws_region = var.aws_region

	get_presigned_url_lambda_function_arn = module.lambda.get_presigned_url_arn
	request_transcoding_lambda_function_arn = module.lambda.request_transcoding_arn
}

module "iam" {
	source = "./iam"

	env_name = var.env_name

	s3_input_bucket_arn = module.s3.input_bucket_arn
	s3_output_bucket_arn = module.s3.output_bucket_arn
}

module "mediaconvert" {
	source = "./mediaconvert"

	env_name = var.env_name

	s3_input_bucket_name = module.s3.input_bucket_name
	s3_output_bucket_name = module.s3.output_bucket_name
	mediaconvert_iam_role_arn = module.iam.mediaconvert_role_arn
}

module "eventbridge" {
	source = "./eventbridge"

	create_solution_lambda_function_arn = module.lambda.create_solution_arn
	env_name = var.env_name
	mediaconvert_queue_arn = module.mediaconvert.mediaconvert_queue_arn
}
