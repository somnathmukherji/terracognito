resource "aws_internet_gateway" "my_igw" {
  tags = {
    Name = "my_igw"
  }

  tags_all = {
    Name = "my_igw"
  }

  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "private_route_table" {
  tags = {
    Name = "private_route_table"
  }

  tags_all = {
    Name = "private_route_table"
  }

  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_instance.nat_instance.primary_network_interface_id
  }

  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "public_route_table" {
  tags = {
    Name = "public_route_table"
  }

  tags_all = {
    Name = "public_route_table"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "rtb_0c5825e09ce94479b" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "rtb_0cbed7caf8be72e43" {
  vpc_id = aws_vpc.vpc_0b465b629e3cf3bed.id
}

resource "aws_security_group" "nat_sg" {
  tags = {
    Name = "nat_sg"
  }

  tags_all = {
    Name = "nat_sg"
  }

  description = "nat_sg"
  egress {
    cidr_blocks = ["10.0.0.0/24", "10.0.2.0/24", "10.0.0.0/16"]
    from_port   = 0
    protocol    = "tcp"
    to_port     = 0
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["10.0.0.0/16"]
    from_port   = 0
    protocol    = "tcp"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  ingress {
    cidr_blocks = ["45.120.162.198/32", "10.0.0.0/24", "10.0.2.0/24"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  name   = "nat_sg"
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_security_group" "sg_0173fd6a39496a9de" {
  description = "ALLOW HTTP HTTPS"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  name   = "WEB_LB"
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_security_group" "sg_020fb06afbdd47aeb" {
  description = "default VPC security group"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    from_port = 0
    protocol  = "-1"
    self      = true
    to_port   = 0
  }

  name   = "default"
  vpc_id = aws_vpc.vpc_0b465b629e3cf3bed.id
}

resource "aws_security_group" "sg_094859b4578733862" {
  description = "default VPC security group"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    from_port = 0
    protocol  = "-1"
    self      = true
    to_port   = 0
  }

  name   = aws_vpc.vpc_0b465b629e3cf3bed.instance_tenancy
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_security_group" "web_sg" {
  tags = {
    Name = "web_sg"
  }

  tags_all = {
    Name = "web_sg"
  }

  description = "web_sg"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  egress {
    cidr_blocks = ["45.120.162.198/32", "10.0.0.0/24", "10.0.2.0/24"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "ALLOW_SSH"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  name   = "web_sg"
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_subnet" "private_subnet_1" {
  tags = {
    Name = "private_subnet_1"
  }

  tags_all = {
    Name = "private_subnet_1"
  }

  availability_zone                   = "ap-south-1a"
  cidr_block                          = "10.0.0.0/24"
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.my_vpc.id
}

resource "aws_subnet" "private_subnet_2" {
  tags = {
    Name = "private_subnet_2"
  }

  tags_all = {
    Name = "private_subnet_2"
  }

  availability_zone                   = "ap-south-1a"
  cidr_block                          = "10.0.2.0/24"
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.my_vpc.id
}

resource "aws_subnet" "public_subnet_1" {
  tags = {
    Name = "public_subnet_1"
  }

  tags_all = {
    Name = "public_subnet_1"
  }

  availability_zone                   = "ap-south-1a"
  cidr_block                          = "10.0.1.0/24"
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.my_vpc.id
}

resource "aws_subnet" "subnet_0689d6fd2f96ff7f2" {
  availability_zone_id                = "aps1-az1"
  cidr_block                          = "172.31.32.0/20"
  map_public_ip_on_launch             = true
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.vpc_0b465b629e3cf3bed.id
}

resource "aws_subnet" "subnet_07c731f6bff089b45" {
  availability_zone                   = "ap-south-1b"
  cidr_block                          = "172.31.0.0/20"
  map_public_ip_on_launch             = true
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.vpc_0b465b629e3cf3bed.id
}

resource "aws_subnet" "subnet_0d2631167ccd32f79" {
  availability_zone                   = "ap-south-1c"
  cidr_block                          = "172.31.16.0/20"
  map_public_ip_on_launch             = true
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.vpc_0b465b629e3cf3bed.id
}

resource "aws_vpc" "my_vpc" {
  tags = {
    Name = "my_vpc"
  }

  tags_all = {
    Name = "my_vpc"
  }

  cidr_block         = "10.0.0.0/16"
  enable_dns_support = true
  instance_tenancy   = "default"
}

resource "aws_vpc" "vpc_0b465b629e3cf3bed" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
}

