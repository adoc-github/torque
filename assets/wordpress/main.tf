provider "aws" {
  region = var.region
  version = "~> 3.0"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_security_group" "example" {
  name        = "example"
  description = "Example security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.example.id]
  subnet_id            = aws_subnet.example.id
  provisioner "file" {
    source = "install_wordpress_nginx.sh"
    destination = "/tmp/install_wordpress_nginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_wordpress_nginx.sh",
      "sed -i 's/<RDS_ENDPOINT>/${local.rds_endpoint}/g' /tmp/install_wordpress_nginx.sh",
      "/tmp/install_wordpress_nginx.sh"
    ]
  }
}

resource "aws_db_instance" "example" {
  engine = "mariadb"
  instance_class = "db.t2.micro"
  allocated_storage = 10
  storage_type = "gp2"
  name = "mydb"
  username = "myuser"
  password = "mypassword"
  vpc_security_group_ids = [aws_security_group.example.id]
  subnet_ids = [aws_subnet.example.id]
}

locals {
  rds_endpoint = aws_rds_instance.example.endpoint
}
