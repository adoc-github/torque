
output "public ip of testEC2" {
  value = "${aws_instance.testEC2.private_ip}"
}