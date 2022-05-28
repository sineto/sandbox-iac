locals {
  vpc_tag_name = "${var.aws_environment}-${var.vpc_001_tag-name}"
  igw_tag_name = "${var.aws_environment}-${var.igw_001_tag-name}"
}

resource "aws_vpc" "vpc_001" {
  cidr_block = var.vpc_001_cidr-block

  # want DNS hostnames enabled for this VPC
  enable_dns_hostnames = true

  tags = {
    Name = local.vpc_tag_name
  }
}

resource "aws_internet_gateway" "igw_001" {
  vpc_id = aws_vpc.vpc_001.id

  tags = {
    Name = local.igw_tag_name
  }
}

## PUBLIC SUBNET
resource "aws_subnet" "subnet_001" {
  count             = var.subnet_count.public
  vpc_id            = aws_vpc.vpc_001.id
  cidr_block        = var.public_subnet_cidr-blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.aws_environment}-public-subnet-${count.index}"
  }
}

resource "aws_route_table" "rtb_001" {
  vpc_id = aws_vpc.vpc_001.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_001.id
  }
}

resource "aws_route_table_association" "artb_001" {
  count          = var.subnet_count.public
  subnet_id      = aws_subnet.subnet_001[count.index].id
  route_table_id = aws_route_table.rtb_001.id
}

## PRIVATE SUBNET
resource "aws_subnet" "subnet_100" {
  count             = var.subnet_count.private
  vpc_id            = aws_vpc.vpc_001.id
  cidr_block        = var.private_subnet_cidr-blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.aws_environment}-private-subnet-${count.index}"
  }
}

resource "aws_route_table" "rtb_100" {
  vpc_id = aws_vpc.vpc_001.id
}

resource "aws_route_table_association" "artb_100" {
  count          = var.subnet_count.private
  subnet_id      = aws_subnet.subnet_100[count.index].id
  route_table_id = aws_route_table.rtb_100.id
}
