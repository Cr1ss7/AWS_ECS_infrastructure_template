resource "aws_vpc" "vpc" {
    cidr_block = var.VPC-CIDR-Block
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = var.VPC-Name
        Environment = var.tags.Environment
        Project = var.tags.Project
        Owner = var.tags.Owner
        IaC = var.tags.IaC
    }
}

resource "aws_subnet" "private-1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.VPC-private-Subnet-1
    availability_zone = "us-east-1a"
    tags = var.tags
}

resource "aws_subnet" "private-2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.VPC-private-Subnet-2
    availability_zone = "us-east-1b"
    tags = var.tags
}

resource "aws_subnet" "public-1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.VPC-public-Subnet-1
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = var.tags
}

resource "aws_subnet" "public-2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.VPC-public-Subnet-2
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = var.tags
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = var.VPC-CIDR-Block
        gateway_id = "local"
    }
}

resource "aws_route_table_association" "public-1" {
    subnet_id = aws_subnet.public-1.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-1" {
    subnet_id = aws_subnet.private-1.id
    route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public-2" {
    subnet_id = aws_subnet.public-2.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-2" {
    subnet_id = aws_subnet.private-2.id
    route_table_id = aws_route_table.private.id
}
