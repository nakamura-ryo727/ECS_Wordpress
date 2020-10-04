variable "pj_name" {
  type = map
  default = {
    name   = "test-nakamura"
  }
}

variable "common-AZ" {
  type = map
  default = {
    region = "ap-northeast-1"
    az-1   = "ap-northeast-1a"
    az-2   = "ap-northeast-1c"
  }
}

variable "vpc" {
  type = map
  default = {
    cidr-block = "10.0.0.0/24"
  }
}

variable "rds-dbname-1" {
  type = map
  default = {
    dbname   = "wpdb"
  }
}

variable "rds-user-1" {
  type = map
  default = {
    user   = "wpuser"
  }
}

data "aws_caller_identity" "self" { }
data "aws_region" "current" {}