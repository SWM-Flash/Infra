# AWS 프로바이더 및 Terraform 버전 설정

provider "aws" {
	access_key = var.aws_access_key
	secret_key = var.aws_secret_key
	region = var.aws_region
}

terraform {
	required_version = "1.5.7"

	required_providers {
		aws = ">= 5.61.0"
	}
}

terraform {
  backend "local" {
    path = "./terraform_state/terraform.tfstate"
  }
}

data "aws_caller_identity" "current" {}

locals {
	account_id = data.aws_caller_identity.current.account_id
	s3_bucket_name = "problem-image-bucket-${local.account_id}-${var.env_name}"

	rendered_index_html = templatefile("${path.module}/src/problem_upload_website/index.html.tpl",
	                                   { api_gateway_url = module.api_gateway.api_gateway_url })
}
