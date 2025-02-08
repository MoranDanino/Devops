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
    type = string
}

variable "name" {
    default = "moran"
}

variable "az" {
    default = "us-east-1a"
}

variable "vpc_cidr" {
    type = list(string)
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

# variable "ingress_rules" {
#     description = "list of inbound rules"
#     type = list(object ((
#         from_port = number
#         to_port = number
#         protocol = string
#         cidr_blocks = list(string)
#     )))
  
# }

