
# application load balancer
resource "aws_lb" "load_balancer" {
    name = "${var.name}-lb"
    internal = false
    load_balancer_type = var.load_balancer_type            
    security_groups = [aws_security_group.sg.id]
    subnets = aws_subnet.public_subnet[*].id
    enable_deletion_protection = false

    tags = {
        Name = "${var.name}-lb"
    }

    lifecycle {
        create_before_destroy = true
    }
}

# listener
resource "aws_lb_listener" "lb_listener" {
    load_balancer_arn = aws_lb.load_balancer.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.target_group.arn
    }
    depends_on = [ aws_lb_target_group.target_group ]
}

# target group
resource "aws_lb_target_group" "target_group" {
    name = "${var.name}-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.vpc.id
    health_check {
        enabled = true
        interval = 30
        timeout = 5
        path = "/"
        protocol = "HTTP"
        healthy_threshold = 3
        unhealthy_threshold = 2
        matcher = "200"
    }

    tags = {
        Name = "${var.name}-tg"
    }  

    lifecycle {
        create_before_destroy = false
    }
}

