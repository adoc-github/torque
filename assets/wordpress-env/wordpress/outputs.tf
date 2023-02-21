output "hostname" {
  value = "${aws_db_instance.example_db_instance.endpoint}"
}
output "connection_string" {
  sensitive = true
  value = "Server=${aws_db_instance.example_db_instance.address};Port=${aws_db_instance.example_db_instance.port};Database=${var.db_name};Uid=${var.username};Pwd=${var.password};"
}