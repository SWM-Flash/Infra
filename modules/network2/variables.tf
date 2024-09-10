variable "env_suffix" {
  type = string
}

variable "az_count" {
  type    = number
  default = 2
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
}

variable "region" {
  type = string
}

variable "tpl_path" {
  type = string
  default = "service.config.json.tpl"
}

variable "scaling_max_capacity" {
  type = number
  default = 3
}

variable "scaling_min_capacity" {
  type = number
  default = 1
}

variable "cpu_or_memory_limit" {
  type = number
  default = 70
}
