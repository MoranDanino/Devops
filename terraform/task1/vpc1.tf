# Create VPC 
#variables:
provider "aws" {
    region = var.region
}

variable "region" {
    default = "us-east-1"
}

variable "az" {
    default = "us-east-1a"
}

variable "name" {
    default = "moran"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
  
}

#vpc
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "${var.name}-vpc"
    }
}


# Create two subnets inside the VPC - one private and one public
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = var.az 
    map_public_ip_on_launch = true
    
    tags = {
        Name = "${var.name}-public_subnet"
    }
}


resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = var.az 

    tags = {
        Name = "${var.name}-private_subnet"
    }
}

#internet getway
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id

    tags = {
      Name = "${var.name}-IG"
    }
}


# route table for the public subnet + associate it:
resource "aws_route_table" "route_table_public" {
    vpc_id = aws_vpc.vpc.id

    #connenting the route to internet_geteway- for the public subnet
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
      Name = "${var.name}-routetable_public"
    }
}

#assosiate route table with the public subnet 
resource "aws_route_table_association" "routetable_ass_publicsubnet" {
    route_table_id = aws_route_table.route_table_public.id
    subnet_id = aws_subnet.public_subnet.id

    depends_on = [aws_subnet.public_subnet]
}


# route table for the privet subnet + associate it:
resource "aws_route_table" "route_table_private" {
    vpc_id = aws_vpc.vpc.id

    # no need the route section - no internet access for the private subnet
    tags = {
      Name = "${var.name}-routetable_private"
    }
}

#assosiate route table with the public subnet 
resource "aws_route_table_association" "routetable_ass_privatesubnet" {
    route_table_id = aws_route_table.route_table_private.id
    subnet_id = aws_subnet.private_subnet.id

    depends_on = [aws_subnet.private_subnet]
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnet_id" {
  description = "The ID of the Public Subnet"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  description = "The ID of the Private Subnet"
  value       = aws_subnet.private_subnet.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.internet_gateway.id
}

output "public_route_table_id" {
  description = "The ID of the Public Route Table"
  value       = aws_route_table.route_table_public.id
}

output "private_route_table_id" {
  description = "The ID of the Private Route Table"
  value       = aws_route_table.route_table_private.id
}
