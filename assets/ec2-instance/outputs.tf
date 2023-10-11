
output "testEC2_private_ip" {
  value = "${aws_instance.testEC2.*.private_ip}"
}

output "testEC2_public_ip" {
  value = "${aws_instance.testEC2.*.public_ip}"
}