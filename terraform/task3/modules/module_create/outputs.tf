
# if not public ip not assigned, it print "no public ip"
# output "vm_public_ip" {
# description = "Public IP address of the VM"
# value = aws_instance.vm.public_ip
# depends_on = [null_resource.check_public_ip] 
# }

output "vm_public_ip" {
  value = aws_instance.vm.public_ip != null && aws_instance.vm.public_ip != "" ? aws_instance.vm.public_ip : "No public IP assigned"
}

output "vpc_cidr" {
  description = "The cide_block of vpc"
  value       = aws_vpc.vpc.cidr_block
}

output "list_public_subnet_id" {
  description = "The list of Ids Subnets"
  value       = aws_subnet.public_subnet[*].id
}

# output "private_subnet_id" {
#   description = "The ID of the Private Subnet"
#   value       = aws_subnet.private_subnet.id
# }

output "instance_type" {
  description = "The ID of the Public Route Table"
  value       = aws_instance.vm.instance_type
}
