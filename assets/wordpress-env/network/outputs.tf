output "subnet_ids" {
  value = [
    aws_subnet.rds_subnet_1.id,
    aws_subnet.rds_subnet_2.id,
    aws_subnet.rds_subnet_3.id
  ]
}

output "rds_subnet_1_id" {
  value = aws_subnet.rds_subnet_1.id
}

output "rds_subnet_2_id" {
  value = aws_subnet.rds_subnet_2.id
}

output "wordpress_subnet_id" {
  value = aws_subnet.wordpress_subnet.id
}

output "rds_security_group_id" {
  value = aws_security_group.rds_security_group.id
}

output "wordpress_security_group_id" {
  value = aws_security_group.wordpress_security_group.id
}
