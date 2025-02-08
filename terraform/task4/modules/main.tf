module "lb_module" {
    source = "../modules/module_create"
    name = "user"
    instance_type = "t2.micro"
    min_size = 1
    max_size = 3
}

output "load_balancer_DNS" {
    description = "DNS ID of the load balancer"
    value = module.lb_module.lb_dns
}
