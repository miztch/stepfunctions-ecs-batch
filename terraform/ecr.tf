resource "aws_ecr_repository" "batch" {
  name                 = "${var.name}-batch"
  image_tag_mutability = "MUTABLE"

  # image_scanning_configuration {
  #   scan_on_push = true
  # }
}
