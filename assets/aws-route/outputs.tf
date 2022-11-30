output "route_table_ids" {
  description = "List of IDs of route tables"
  value       = aws_route_table.this[*].id
}
