data "aws_iam_policy_document" "assume_role_stepfunctions" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "stepfunctions" {
  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole",
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ecs:RunTask",
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "stepfunctions" {
  name   = "${var.name}-stepfunctions-policy"
  policy = data.aws_iam_policy_document.stepfunctions.json
}

resource "aws_iam_role" "stepfunctions" {
  name               = "${var.name}-stepfunctions-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_stepfunctions.json
}

resource "aws_iam_role_policy_attachment" "stepfunctions" {
  role       = aws_iam_role.stepfunctions.name
  policy_arn = aws_iam_policy.stepfunctions.arn
}
