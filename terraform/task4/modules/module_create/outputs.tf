output "lb_dns" {
    description = "dns id of the load balancer"
    value = aws_lb.load_balancer.dns_name
}

# Output the Load Balancer DNS Name
output "load_balancer_dns" {
  description = "The DNS name of the Load Balancer"
  value       = aws_lb.load_balancer.dns_name
}

# Output the Target Group ARN
output "target_group_arn" {
  description = "ARN of the Target Group"
  value       = aws_lb_target_group.target_group.arn
}
  

# Output the Security Group ID
output "security_group_id" {
  description = "Security Group ID associated with the Auto Scaling Group"
  value       = aws_security_group.sg.id
}

# Output Public Subnet IDs
output "public_subnet_ids" {
  description = "List of public subnet IDs for the Load Balancer"
  value       = aws_subnet.public_subnet[*].id
}

# Output Private Subnet IDs (for ASG if using private subnets)
output "private_subnet_ids" {
  description = "List of private subnet IDs for Auto Scaling"
  value       = aws_subnet.private_subnet[*].id
}