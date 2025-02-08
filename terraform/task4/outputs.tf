output "lb_dns" {
    description = "dns id of the load balancer"
    value = aws_lb.load_balancer.dns_name
}