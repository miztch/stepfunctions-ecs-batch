resource "aws_ecs_task_definition" "batch" {
  family                   = "${var.name}-batch"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = templatefile("ecs/container_definition.json",
    {
      ECR_REPOSITORY_IMAGE_URI   = "${aws_ecr_repository.batch.repository_url}:latest"
      CLOUDWATCH_LOGS_GROUP_NAME = aws_cloudwatch_log_group.ecs_batch.name
      CLOUDWATCH_LOGS_REGION     = data.aws_region.current.name

    }
  )
}

resource "aws_ecs_cluster" "batch" {
  name = "${var.name}-batch"
}

resource "aws_ecs_cluster_capacity_providers" "batch" {
  cluster_name = aws_ecs_cluster.batch.name

  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT"
  ]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE_SPOT"
  }
}
