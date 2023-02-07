provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/24"
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
}

resource "aws_subnet" "example" {
  vpc_id = aws_vpc.example.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "example" {
  name = "example"
  vpc_id = aws_vpc.example.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami = "ami-0cd7ad8676931d727"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.example.id
  vpc_security_group_ids = [aws_security_group.example.id]
  key_name = "testadoc"

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo apt-get install -y php libapache2-mod-php
    sudo apt-get install -y mysql-server php-mysql
    sudo apt-get install -y wordpress
    sudo ln -s /usr/share/wordpress /var/www/html/wordpress
    sudo chown -R www-data:www-data /var/www/html/wordpress
    sudo service apache2 restart
  EOF
}
