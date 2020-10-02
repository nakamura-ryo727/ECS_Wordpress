resource "aws_vpc" "vpc-01" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "${var.pj_name["name"]}-vpc"
  }
}