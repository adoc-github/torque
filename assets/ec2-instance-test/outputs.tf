
output "testEC2_private_ip" {
  value = "${aws_instance.testEC2.*.private_ip}"
}