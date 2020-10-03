resource "aws_security_group" "sg-alb" {
  vpc_id      = aws_vpc.vpc-01.id
  name        = "${var.pj_name["name"]}-sg-alb"
  description = "${var.pj_name["name"]}-sg-alb"
  tags = {
    Name = "${var.pj_name["name"]}-sg-alb"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg-ecs" {
  vpc_id      = aws_vpc.vpc-01.id
  name        = "${var.pj_name["name"]}-sg-ecs"
  description = "${var.pj_name["name"]}-sg-ecs"
  tags = {
    Name = "${var.pj_name["name"]}-sg-ecs"
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sg-alb.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg-rds" {
  vpc_id      = aws_vpc.vpc-01.id
  name        = "${var.pj_name["name"]}-sg-rds"
  description = "${var.pj_name["name"]}-sg-rds"
  tags = {
    Name = "${var.pj_name["name"]}-sg-rds"
  }
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.sg-ecs.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg-efs" {
  vpc_id      = aws_vpc.vpc-01.id
  name        = "${var.pj_name["name"]}-sg-efs"
  description = "${var.pj_name["name"]}-sg-efs"
  tags = {
    Name = "${var.pj_name["name"]}-sg-efs"
  }
  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.sg-ecs.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
