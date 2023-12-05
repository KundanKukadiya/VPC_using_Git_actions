# VPC

resource "aws_vpc" "my-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"
  }
}

#subnet

resource "aws_subnet" "my-subnet" {
  count                   = length(var.subnets)
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = var.subnets[count.index]
  availability_zone       = data.aws_availability_zones.zone.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnets_names[count.index]
  }
}

#internet Gateway

resource "aws_internet_gateway" "my-IG" {

  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "My_IG"
  }
}

#route table

resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-IG.id
  }

  tags = {
    Name = "my-route"
  }
}

resource "aws_route_table_association" "my-assoc" {
  count          = length(var.subnets)
  subnet_id      = aws_subnet.my-subnet[count.index].id
  route_table_id = aws_route_table.my-route-table.id
}
