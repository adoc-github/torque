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
    subnet_id = var.subnet_id
    key_name             = var.key_name
    user_data = <<-EOF
      <powershell>
      echo [InternetShortcut]> C:\torque.url
      echo URL="https://portal.qtorque.io/login" >> C:\torque.url
      </powershell>
      EOF
    
    tags = {
        Name = var.name
    }
}
