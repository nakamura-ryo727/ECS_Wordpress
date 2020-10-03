resource "aws_ssm_parameter" "rds-db-endpoint-1" {
  name  = "${var.pj_name["name"]}-rds-db-endpoint"
  type  = "String"
  value = aws_rds_cluster.rds-cluster-1.endpoint
}

resource "aws_ssm_parameter" "rds-db-name-1" {
  name  = "${var.pj_name["name"]}-rds-db-name"
  type  = "String"
  value = var.rds-dbname-1["dbname"]
}

resource "aws_ssm_parameter" "rds-db-user-1" {
  name  = "${var.pj_name["name"]}-rds-db-user"
  type  = "String"
  value = var.rds-user-1["user"]
}

resource "aws_ssm_parameter" "rds-db-pass-1" {
  name        = "${var.pj_name["name"]}-rds-db-pass"
  description = "The parameter description"
  type        = "SecureString"
  value       = aws_rds_cluster.rds-cluster-1.master_password
}