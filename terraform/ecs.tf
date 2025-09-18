resource "aws_ecs_cluster" "this" {
  name = "${var.project}-cluster"
}

resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.project}"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "static-site"
      image     = "127898337602.dkr.ecr.us-west-2.amazonaws.com/static-site:${var.image_tag}"
      essential = true
      portMappings = [
        { containerPort = 80, hostPort = 80 }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.app.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "static"
        }
      }
    }
  ])
}

