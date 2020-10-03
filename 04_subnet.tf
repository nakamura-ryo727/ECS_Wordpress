resource "aws_subnet" "public-subnet-1" {
    cidr_block = cidrsubnet(aws_vpc.vpc-01.cidr_block, 2, 0)
    vpc_id = aws_vpc.vpc-01.id
    availability_zone = var.common-AZ["az-1"]
    tags = {
        Name = "${var.pj_name["name"]}-public-az-1"
    }
}

resource "aws_subnet" "public-subnet-2" {
    cidr_block = cidrsubnet(aws_vpc.vpc-01.cidr_block, 2, 1)
    vpc_id = aws_vpc.vpc-01.id
    availability_zone = var.common-AZ["az-2"]
    tags = {
        Name = "${var.pj_name["name"]}-public-az-2"
    }
}

resource "aws_subnet" "private-subnet-1" {
    cidr_block = cidrsubnet(aws_vpc.vpc-01.cidr_block, 2, 2)
    vpc_id = aws_vpc.vpc-01.id
    availability_zone = var.common-AZ["az-1"]
    tags = {
        Name = "${var.pj_name["name"]}-private-az-1"
    }
}

resource "aws_subnet" "private-subnet-2" {
    cidr_block = cidrsubnet(aws_vpc.vpc-01.cidr_block, 2, 3)
    vpc_id = aws_vpc.vpc-01.id
    availability_zone = var.common-AZ["az-2"]
    tags = {
        Name = "${var.pj_name["name"]}-private-az-2"
    }
}