module "s3" {
	source = "./s3"

	env_name = var.env_name
	account_id = var.account_id
}
