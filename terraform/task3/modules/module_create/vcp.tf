
# create vpc
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "${var.name}-vpc"
    }
}

# Create two subnets inside the VPC - one private and one public
resource "aws_subnet" "public_subnet" {
    count = var.subnet_counter                                    #count number of subnets
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_sub_ip[count.index]  
    availability_zone = var.az[count.index % length(var.az)]
    map_public_ip_on_launch = var.bool_public_ip_assign           #according to the user desicion
    depends_on = [ aws_subnet.private_subnet ]
    tags = {
        Name = "${var.name}-public_subnet-${count.index}"
    }
}

data "aws_vpc" "existing" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.vpc.id]
  }
}

resource "aws_subnet" "private_subnet" {
    count = var.subnet_counter 
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_sub_ip[count.index]    
    availability_zone = var.az[count.index % length(var.az)]

    tags = {
        Name = "${var.name}-private_subnet-${count.index}"
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
    count = length(aws_subnet.public_subnet) 
    route_table_id = aws_route_table.route_table_public.id
    subnet_id = aws_subnet.public_subnet[count.index].id

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
    count = length(aws_subnet.private_subnet) 
    route_table_id = aws_route_table.route_table_private.id
    subnet_id = aws_subnet.private_subnet[count.index].id

    depends_on = [aws_subnet.private_subnet]
}
