resource "aws_cloudwatch_log_group" "cloudwatch-log-group-1" {
  name              = "${var.pj_name["name"]}-ecs-log"
  retention_in_days = 30
  tags = {
    Name = "${var.pj_name["name"]}-ecs-log"
  }
}