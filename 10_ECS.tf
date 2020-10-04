resource "aws_ecs_cluster" "ecs-cluster-1" {
  name = "${var.pj_name["name"]}-ecs-cluster"
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
  family                   = "${var.pj_name["name"]}-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.role-1.arn
  volume {
    name = "service-storage"
    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.efs-file-system-1.id
    }
  }
    container_definitions = <<DEFINITION
[
  {
    "name": "wordpress",
    "image": "wordpress",
    "portMappings": [
      {
        "hostPort": 80,
        "protocol": "tcp",
        "containerPort": 80
      }
    ],
    "secrets": [
      {
          "name": "WORDPRESS_DB_HOST",
          "valueFrom": "${var.pj_name["name"]}-rds-db-endpoint"
      },
      {
          "name": "WORDPRESS_DB_NAME",
          "valueFrom": "${var.pj_name["name"]}-rds-db-name"
      },
      {
          "name": "WORDPRESS_DB_USER",
          "valueFrom": "${var.pj_name["name"]}-rds-db-user"
      },
      {
          "name": "WORDPRESS_DB_PASSWORD",
          "valueFrom": "${var.pj_name["name"]}-rds-db-pass"
      }
    ],
    "essential": true,
    "mountPoints": [
      {
        "sourceVolume": "service-storage",
        "containerPath": "/var/www/html"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${var.pj_name["name"]}-ecs-log",
        "awslogs-region": "${data.aws_region.current.name}",
        "awslogs-stream-prefix": "wordpress"
      }
    }
  }
]
  DEFINITION
}

resource "aws_ecs_service" "ecs-service-1" {
  name             = "${var.pj_name["name"]}-WordPress"
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