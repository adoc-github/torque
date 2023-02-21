# Providerを設定
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

# インスタンス作成
resource "aws_instance" "example" {
  ami           = "ami-06a46da680048c8ae"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  key_name      = "testadoc"
  user_data     = <<-EOF
                  #!/bin/bash
                  yum install -y httpd php php-mysqlnd
                  systemctl enable httpd
                  systemctl start httpd
                  cd /var/www/html
                  wget https://wordpress.org/latest.tar.gz
                  tar -xzvf latest.tar.gz --strip-components=1
                  cp wp-config-sample.php wp-config.php
                  sed -i 's/database_name_here/${var.db_name}/g' wp-config.php
                  sed -i 's/username_here/${var.db_username}/g' wp-config.php
                  sed -i 's/password_here/${var.db_password}/g' wp-config.php
                  sed -i 's/localhost/${var.db_endpoint}/g' wp-config.php
                  EOF

  # インスタンスに割り当てるセキュリティグループIDを指定
  vpc_security_group_ids = ["sg-0123456789abcdef0"]
}
