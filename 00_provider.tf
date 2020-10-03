provider "aws" {
  region  = var.common-AZ["region"]
  profile = ""
}
data "aws_region" "current" {}