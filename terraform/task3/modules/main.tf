module "mymodule" {
    source = "../modules/module_create"
    instance_type = "t2.micro"
    subnet_counter = 3
    bool_public_ip_assign = true
    vpc_cidr = ["10.0.0.0/16", "10.0.0.0/16"]     #range of values for vpc
}

output "print_vm_public_ip" {
    value = module.mymodule.vm_public_ip
}

output "print_vpc_cidr" {
    value = module.mymodule.vpc_cidr
}

output "print_list_public_subnet_id" {
    value = module.mymodule.list_public_subnet_id
}

output "print_instance_type" {
    value = module.mymodule.instance_type
}

