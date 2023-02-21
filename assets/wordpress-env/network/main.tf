terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">3.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "webapp_vpc" {
  cidr_block = "10.0.0.0/16"
}

# インターネットゲートウェイ
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.webapp_vpc.id
}

# サブネット
resource "aws_subnet" "rds_subnet_1" {
  vpc_id     = aws_vpc.webapp_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.region}a"
}

resource "aws_subnet" "rds_subnet_2" {
  vpc_id     = aws_vpc.webapp_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "${var.region}c"
}

resource "aws_subnet" "wordpress_subnet" {
  vpc_id     = aws_vpc.webapp_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "${var.region}d"
}

# セキュリティグループ
resource "aws_security_group" "rds_security_group" {
  name_prefix = "rds"
  vpc_id      = aws_vpc.webapp_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "wordpress_security_group" {
  name_prefix = "wordpress"
  vpc_id      = aws_vpc.webapp_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ルーティング
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.webapp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }
}

resource "aws_route_table_association" "wordpress_association" {
  subnet_id       = aws_subnet.wordpress_subnet.id
  route_table_id  = aws_route_table.example.id
}
