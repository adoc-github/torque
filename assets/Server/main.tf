provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "web" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name = "testadoc"

  root_block_device {
    volume_size = 32
    volume_type = "gp2"
  }

  network_interface {
    network_interface_id = aws_network_interface.ens192.id
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
  EOF
}

resource "aws_network_interface" "ens192" {
  subnet_id = aws_subnet.public.id

  private_ips = ["10.0.1.100"]
  private_ip_address = "10.0.1.100"
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}