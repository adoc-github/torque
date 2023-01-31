provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0cd7ad8676931d727"
  instance_type = "t2.micro"
}
