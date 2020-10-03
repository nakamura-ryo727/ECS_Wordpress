resource "aws_route_table" "vpc-public-rtb" {
    vpc_id = aws_vpc.vpc-01.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-01.id
    }
    tags = {
        Name = "${var.pj_name["name"]}-public-rtb"
    }
}

resource "aws_route_table" "vpc-private-rtb" {
    vpc_id = aws_vpc.vpc-01.id
    tags = {
        Name = "${var.pj_name["name"]}-private-rtb"
    }
}
