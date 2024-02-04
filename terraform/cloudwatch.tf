resource "aws_cloudwatch_log_group" "ecs_batch" {
  name = "/aws/ecs/${var.name}"
}
