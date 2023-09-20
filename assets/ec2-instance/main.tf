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
    associate_public_ip_address = true
    user_data = <<-EOF
      <powershell>
      Set-Location -Path ([System.Environment]::GetFolderPath("Desktop"))
      echo [InternetShortcut] > torque.url
      echo URL="https://portal.qtorque.io/login" >> torque.url
      </powershell>
      EOF
    
    tags = {
        Name = var.name
    }
}
