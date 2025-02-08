resource "aws_lb" "load_balancer" {
    name = "${var.name}-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.sg.id]
    subnets = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
    enable_deletion_protection = false
}

resource "aws_lb_listener" "lb_listener" {
    load_balancer_arn = aws_lb.load_balancer.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.target_group.arn
    }
}

resource "aws_lb_target_group" "target_group" {
    name = "${var.name}-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.vpc.id
    health_check {
        enabled = true
        interval = 30
        path = "/"
        port = "traffic-port"
        protocol = "HTTP"
        healthy_threshold = 3
        unhealthy_threshold = 2
        timeout = 5
    }
    tags = {
        Name = "tg"
    }  
}

