output "vm_public_ip" {
  description = "Public IP address of the VM"
  value = aws_instance.vm.public_ip
  depends_on = [null_resource.check_public_ip] 
}

output "security_group_id" {
  description = "Security group id"
  value = aws_security_group.sg.id
}


output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private_subnet.id
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.internet_gateway.id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.route_table_public.id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.route_table_private.id
}