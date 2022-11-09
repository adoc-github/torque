output "subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.this[*].id
}

output "subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.this[*].arn
}

output "subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = compact(aws_subnet.this[*].cidr_block)
}

output "subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  value       = compact(aws_subnet.this[*].ipv6_cidr_block)
}