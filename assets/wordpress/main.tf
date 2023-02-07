provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "example" {
  vpc_id = aws_vpc.example.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_instance" "example" {
  ami = "ami-0cd7ad8676931d727"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.example.id
  key_name = "testadoc"

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo apt-get install -y php libapache2-mod-php",
      "sudo apt-get install -y mysql-server php-mysql",
      "sudo apt-get install -y wordpress",
      "sudo ln -s /usr/share/wordpress /var/www/html/wordpress",
      "sudo chown -R www-data:www-data /var/www/html/wordpress",
      "sudo service apache2 restart"
    ]
  }
}
