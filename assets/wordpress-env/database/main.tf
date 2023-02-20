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
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
}

# サブネット
resource "aws_subnet" "example_subnet" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.1.0/24"
}

# セキュリティグループ
resource "aws_security_group" "example_security_group" {
  name_prefix = "example"
  vpc_id      = aws_vpc.example_vpc.id

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

# RDSインスタンス
resource "aws_db_instance" "example_db_instance" {
  db_name                 = "${var.db_name}"
  identifier            = "example-db-instance"
  engine                = "mariadb"
  engine_version        = "10.4.13"
  instance_class        = "db.t2.micro"
  allocated_storage     = 20
  storage_type          = "gp2"
  publicly_accessible   = false
  db_subnet_group_name  = aws_db_subnet_group.example_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.example_security_group.id]

  # パスワードの設定
  username             = "${var.username}"
  password             = "${random_password.password.result}"
}

# RDSインスタンスのサブネットグループ
resource "aws_db_subnet_group" "example_db_subnet_group" {
  name       = "example-db-subnet-group"
  subnet_ids = [aws_subnet.example_subnet.id]
}
