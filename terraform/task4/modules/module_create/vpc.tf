# create VPC 
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.name}-vpc"
    }
}


# create two subnets inside the VPC - one private and one public
resource "aws_subnet" "public_subnet" {
    count = var.number_of_public_subnet
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index) 
    map_public_ip_on_launch = true
    availability_zone = var.az[count.index]

    tags = {
        Name = "${var.name}-public_subnet-${count.index}"
    }
}

resource "aws_subnet" "private_subnet" {
    count = 1
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.15.0/24"
    availability_zone = var.az[count.index]

    tags = {
        Name = "${var.name}-private_subnet"
    }
}

# internet gateway
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id

    tags = {
      Name = "${var.name}-IG"
    }
}

# route table for the public subnets + associate it:
resource "aws_route_table" "route_table_public" {
    vpc_id = aws_vpc.vpc.id

    # connenting the route to internet_gateway- for the public subnet
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
      Name = "${var.name}-routetable_public"
    }
}

# assosiate route table with the public subnet 
resource "aws_route_table_association" "routetable_ass_publicsubnet" {
    count = var.number_of_public_subnet
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

# assosiate route table with the public subnet 
resource "aws_route_table_association" "routetable_ass_privatesubnet" {
    count = 1
    route_table_id = aws_route_table.route_table_private.id
    subnet_id = aws_subnet.private_subnet[count.index].id

    depends_on = [aws_subnet.private_subnet]
}
