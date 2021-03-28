output "security_group_main_id" {
  value = aws_security_group.main.id
}

output "vpc_main_id" {
  value = aws_vpc.main.id
}

output "route_main_id" {
  value = aws_route_table.main.id
}

output "subnet_main_id" {
  value = aws_subnet.main.id
}

output "network_acl_id" {
  value = aws_network_acl.main.id
}
