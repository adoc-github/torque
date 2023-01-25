variable "rds_endpoint" {
  default = "${aws_rds_instance.example.endpoint}"
}
