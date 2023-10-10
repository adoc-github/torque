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
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    key_name             = var.key_name
    associate_public_ip_address = true
    user_data = templatefile("install_chrome.ps1")
    
    tags = {
        Name = var.name
    }
}
