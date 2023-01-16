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
    instance_type = "t2.small"
    subnet_id = var.subnet_id
    tags = {
        Name = var.name
    }
}
