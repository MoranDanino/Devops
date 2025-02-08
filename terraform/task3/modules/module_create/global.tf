provider "aws" {
    region = var.region
}

variable "region" {
    default = "us-east-1"
}

variable "ami" {
    default = "ami-0e1bed4f06a3b463d"
}

variable "instance_type" {
    description = "The instance type of ec2 instance"
    type = string
    validation {
        condition     = contains(["t2.micro", "t2.small", "t2.medium", "t2.large","t2.xlarge"], var.instance_type)
        error_message = "This is not a possible instance type"
    }
}

variable "name" {}

variable "az" {
    type = list(string)
    default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "ingress_rules" {
    type = list(number)
    default = [22,80]
}

variable "subnet_counter" {
    type = number
}

variable "bool_public_ip_assign" {
    type = bool
}

variable "public_sub_ip" {
        type = list(string)
        default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

variable "private_sub_ip" {
        type = list(string)
        default = ["10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
}

# variable "ingress_rules" {
#     description = "list of inbound rules"
#     type = list(object ((
#         from_port = number
#         to_port = number
#         protocol = string
#         cidr_blocks = list(string)
#     )))
  
# }

