resource "aws_rds_cluster" "rds-cluster-1" {
  cluster_identifier              = "${var.pj_name["name"]}-db"
  engine                          = "aurora-mysql"
  engine_mode                     = "serverless"
  availability_zones              = [var.common-AZ["az-1"], var.common-AZ["az-2"]]
  database_name                   = var.rds-dbname-1["dbname"]
  master_username                 = var.rds-user-1["user"]
  master_password                 = random_password.password.result
  backup_retention_period         = 5
  preferred_backup_window         = "07:00-09:00"
  db_subnet_group_name            = aws_db_subnet_group.db-subnet-group-1.id
  vpc_security_group_ids          = [aws_security_group.sg-rds.id]
  skip_final_snapshot             = "true"
  tags = {
    Name = "${var.pj_name["name"]}-db"
  }
}

resource "aws_db_subnet_group" "db-subnet-group-1" {
  name       = "${var.pj_name["name"]}-subnet-group"
  subnet_ids = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
  tags = {
    Name = "${var.pj_name["name"]}-subnet-group"
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}