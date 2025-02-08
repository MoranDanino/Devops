# Terraform_Exams Task 3

# Convert the VPC and EC2 Configuration into a Terraform Module:
# Module "mymodule" details: 

# variables to give - Require:
# source model - to be able to use the model
# instance_type - like "t2.micro"
# subnet_counter- subnet number
# bool_public_ip_assign - whether a public IP should be assigned or not 
# vpc_cidr - VPC cidr range

# optional:
# name
# ami
# region
# ingress_rules


# files:
# global - handle the variables
# validation - check if public ip assign
# vpc - handle create vpc, subnets, internet gateway, route tables 
# vm - create ec2 instance, security group
# outputs - handle the outputs we what to print

# outputs you can create in the module: 
# vm_public_ip - public ip number if assigned
# vpc_cidr - id of vpc cidr
# list_public_subnet_id - all the subnets and the number
# instance_type - to know which instance type the user choose