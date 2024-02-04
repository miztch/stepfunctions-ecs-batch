resource "aws_sfn_state_machine" "run_ecs_task" {
  name     = "${var.name}-statemachine"
  role_arn = aws_iam_role.stepfunctions.arn

  definition = templatefile("statemachine/asl.json",
    {
      ECS_CLUSTER_ARN         = aws_ecs_cluster.batch.arn
      ECS_TASK_DEFINITION_ARN = aws_ecs_task_definition.batch.arn
      ECS_CONTAINER_NAME      = "sample-batch"
      SUBNET_A_ID             = var.use_default_vpc ? data.aws_subnet.default_a.id : var.subnet_a_id
      SUBNET_C_ID             = var.use_default_vpc ? data.aws_subnet.default_c.id : var.subnet_c_id
      SECURITY_GROUP_ID       = aws_security_group.ecs_batch.id
    }
  )
}
