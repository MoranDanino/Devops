module "lb_module" {
    source = "../modules/module_create"
    name = "user"
    instance_type = "t2.micro"
    min_size = 1
    max_size = 3
}

output "load_balancer_DNS" {
    description = "dns id of the load balancer"
    value = module.lb_module.lb_dns
}


# Output the Load Balancer DNS Name
output "load_balancer_dns" {
  description = "The DNS name of the Load Balancer"
  value       = module.lb_module.load_balancer_dns
}

# Output the Target Group ARN
output "target_group_arn" {
  description = "ARN of the Target Group"
  value       = module.lb_module.target_group_arn
}

# Output the Security Group ID
output "security_group_id" {
  description = "Security Group ID associated with the Auto Scaling Group"
  value       = module.lb_module.security_group_id
}

# Output Public Subnet IDs
output "public_subnet_ids" {
  description = "List of public subnet IDs for the Load Balancer"
  value       = module.lb_module.public_subnet_ids[*]
}

# Output Private Subnet IDs (for ASG if using private subnets)
output "private_subnet_ids" {
  description = "List of private subnet IDs for Auto Scaling"
  value       = module.lb_module.private_subnet_ids[*]
}