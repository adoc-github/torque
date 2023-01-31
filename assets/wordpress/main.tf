provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_instance" "example" {
  ami           = "ami-0cd7ad8676931d727"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.example.id
}
