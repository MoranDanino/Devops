# Terraform_Exams Task 4

# Deploy an Application Load Balancer with Auto Scaling:
# Module "lb_module" details: 

# variables to give - Require:
# source model - to be able to use the model

# optional:
# name
# ami
# region
# instance_type 
# ingress_rules
# min size auto scaling
# max size auto scaling
# load_balancer_type


# files:
# global - handle the variables
# validation - check if public ip assign
# vpc - handle create vpc, subnets, internet gateway, route tables 
# sg - create the security group
# alb - create load balancer, load balancer listener, target group  
# as - create auto scaling group and launch tamplate
# outputs - handle the outputs we what to print


# outputs you can create in the module: 
# id of the DNS load balancer