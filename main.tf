module "iam" {
  source = "./modules/iam"

  lambda_iam_role_name = var.lambda_iam_role_name
}

module "lambda" {
  source = "./modules/image_upload/lambda"

  lambda_execution_role_arn = module.iam.lambda_execution_role_arn
  api_gateway_execution_arn = module.api_gateway.execution_arn
  bucket_name               = local.s3_bucket_name
  api_url                   = var.api_url

  create_problem_lambda_function_name = var.create_problem_lambda_function_name
  create_problem_lambda_function_code_path = var.create_problem_lambda_function_code_path
  get_presigned_url_lambda_function_name = var.get_presigned_url_lambda_function_name
  get_presigned_url_lambda_function_code_path = var.get_presigned_url_lambda_function_code_path
  image_domain_name = module.cloudfront.cloudfront_domain_name
}

module "api_gateway" {
  source = "./modules/api_gateway"

  lambda_function_arn       = module.lambda.lambda_function_arn
  create_problem_lambda_arn = module.lambda.create_problem_lambda_arn
  aws_region                = var.aws_region
  stage_name                = var.env_name
  api_gateway_name          = var.api_gateway_name
}

module "s3" {
  source     = "./modules/image_upload/s3"

  s3_bucket_name = local.s3_bucket_name
  origin_access_identity_arn = module.cloudfront.oai_arn
}

module "cloudfront" {
  source = "./modules/cloudfront"

  s3_bucket_domain_name = module.s3.bucket_regional_domain_name
  s3_bucket_name = local.s3_bucket_name
  s3_bucket_arn = module.s3.bucket_arn
}

resource "local_file" "index_html" {
  content = local.rendered_index_html
  filename = "${path.module}/src/problem_upload_website/index.html"
}

resource "aws_s3_object" "index" {
  bucket = local.s3_bucket_name
  key    = "index.html"
  source = local_file.index_html.filename
  content_type = "text/html"

  depends_on = [ module.s3.bucket_name, local_file.index_html ]
}


# video upload
module "video_upload" {
  source = "./modules/video_upload"

  aws_region                = var.aws_region
  env_name                  = var.env_name
  account_id                = local.account_id
  lambda_execution_role_arn = module.iam.lambda_execution_role_arn

  api_gateway_execution_arn = module.api_gateway.execution_arn
  rest_api_id = module.api_gateway.rest_api_id
  root_resource_id = module.api_gateway.root_resource_id
}
