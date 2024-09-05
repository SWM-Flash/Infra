variable "env_suffix" {
  type = string
}

variable "az_count" {
  type    = number
  default = 4
}

variable "container_port" {
  type = number
  default = 80
}

variable "host_port" {
  type = number
  default = 80
}

variable "account_id" {
  type = string
}

variable "app_name" {
  type = string
	default = "flash"
}

variable "elb_account_id" {
  type = string
  default = "600734575887"
}

variable "domain" {
  type = string
	default = "wonyangs.com"
}
