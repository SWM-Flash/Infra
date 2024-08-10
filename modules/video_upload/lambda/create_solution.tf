resource "aws_lambda_function" "create_solution" {
  filename         = "${path.module}/../src/create_solution.zip"
  function_name    = "CreateSolution-${var.env_name}"
  role             = var.lambda_execution_role_arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  source_code_hash = filebase64sha256("${path.module}/../src/create_solution/lambda_function.py")
  timeout          = 20

  environment {
    variables = {
			OUTPUT_BUCKET_NAME = var.output_bucket_name
			API_SERVER_URL = var.api_server_url
			CLOUDFRONT_DOMAIN = var.cloudfront_domain
    }
  }

  depends_on = [ null_resource.create_solution_script ]
}

resource "aws_lambda_permission" "allow_cloudwatch_invoke" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.create_solution.function_name
  principal     = "events.amazonaws.com"
  source_arn = var.mediaconvert_job_complete_rule_arn
}
