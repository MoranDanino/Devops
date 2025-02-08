resource "aws_security_group" "sg" {
  name = "${var.name}-sg"
  vpc_id = aws_vpc.vpc.id
  dynamic ingress {                 #for ssh & http
    for_each = var.ingress_rules                    
      content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      } 
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "vm" {
    ami = var.ami # ubuntu 22.04 in us-east-1  
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = aws_subnet.public_subnet1.id           
    associate_public_ip_address = true
    tags = {
        Name = "${var.name}-vm"
    }
}
