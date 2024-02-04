variable "name" {
  default = "sfn-ecs-sample"
}

variable "image_name" {
  default = "sfn-ecs-sample-batch"
}

variable "use_default_vpc" {
  type    = bool
  default = true
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "subnet_a_id" {
  type    = string
  default = ""
}

variable "subnet_c_id" {
  type    = string
  default = ""
}
