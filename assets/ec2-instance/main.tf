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

resource "aws_instance" "testEC2" {
    ami = var.ami
    # instance_type = var.instance_type
    instance_type = "t2.micro"
    subnet_id = "subnet-0124294163b6e76e0"
    tags = {
        Name = "testEC2"
    }
}
