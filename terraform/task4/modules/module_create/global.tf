provider "aws" {
    region = var.region
}

variable "region" {
    default = "us-east-1"
}

variable "ami" {
    default = "ami-0e1bed4f06a3b463d"
}

variable "name" {
    default = "user"
}

variable "az" {
    type = list(string)
    default = ["us-east-1a","us-east-1b"]
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "ingress_rules" {
    type = list(number)
    default = [22,80]
}

variable "instance_type" {
    type = string
    default = "t2.micro"
    validation {
        condition = contains(["t2.micro", "t2.small", "t2.medium", "t2.large","t2.xlarge"], var.instance_type)
        error_message = "This is not a possible instance type"
    } 
}

variable "min_size" {
    type = string
    default = 1
}

variable "max_size" {
    type = string
    default = 3
  
}

variable "number_of_public_subnet" {
    type = number
    default = 2

}

# variable "public_sub_ip" {
#         type = list(string)
#         default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
# }

variable "load_balancer_type" {
    default = "application"
    validation {
        condition = contains(["application", "network", "gateway"], var.load_balancer_type)
        error_message = "This is not a possible type of load balancer"
    } 
}



