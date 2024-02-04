data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# vpc
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default_a" {
  availability_zone = "us-east-1a"
  default_for_az    = true
}

data "aws_subnet" "default_c" {
  availability_zone = "us-east-1c"
  default_for_az    = true
}
