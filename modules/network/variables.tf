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