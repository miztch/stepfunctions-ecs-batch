resource "aws_security_group" "ecs_batch" {
  name        = "${var.name}-ecs-batch-sg"
  description = "${var.name}-ecs-batch-sg"

  vpc_id = var.use_default_vpc ? data.aws_vpc.default.id : var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
