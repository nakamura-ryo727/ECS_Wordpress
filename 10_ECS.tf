resource "aws_ecs_cluster" "ecs-cluster-1" {
  name = "${var.pj_name["name"]}-ecs-cluster-1"
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
  default_capacity_provider_strategy {
    base              = 0
    capacity_provider = "FARGATE"
    weight            = 1
  }
  default_capacity_provider_strategy {
    base              = 0
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }
}
resource "aws_ecs_task_definition" "task-definition-1" {
  family                   = "${var.pj_name["name"]}-task-1"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "1024"
  container_definitions    = file("task-definitions.json")
  execution_role_arn       = aws_iam_role.role-1.arn
  volume {
    name = "service-storage"
    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.efs-file-system-1.id
    }
  }
}
resource "aws_ecs_service" "ecs-service-1" {
  name             = "wordpress"
  cluster          = aws_ecs_cluster.ecs-cluster-1.id
  task_definition  = aws_ecs_task_definition.task-definition-1.arn
  desired_count    = 2
  platform_version = "1.4.0"
  depends_on       = [aws_lb.aws-lb-1,aws_rds_cluster.rds-cluster-1]

  load_balancer {
    target_group_arn = aws_lb_target_group.lb-target-group-1.arn
    container_name   = "wordpress"
    container_port   = 80
  }

  network_configuration {
    subnets          = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
    security_groups  = [aws_security_group.sg-ecs.id]
    assign_public_ip = true
  }
}