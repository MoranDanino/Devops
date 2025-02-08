# auto scaling
resource "aws_launch_template" "launch_template" {
    name_prefix = "${var.name}-launch_template"
    image_id = var.ami
    instance_type = var.instance_type
    
    network_interfaces {
      associate_public_ip_address = true
      security_groups = [ aws_security_group.sg.id ]
    }
    tag_specifications {
      resource_type = "instance"
      tags = {
        Name = "${var.name}-vm"
      }
    }
}

resource "aws_autoscaling_group" "asg" {
    count = 1
    desired_capacity = 1
    max_size = var.max_size
    min_size = var.min_size
    target_group_arns = [ aws_lb_target_group.target_group.arn ]
    vpc_zone_identifier = [ aws_subnet.private_subnet[count.index].id ]
    
    launch_template {
      id = aws_launch_template.launch_template.id
      version = "$Latest"
    }

      lifecycle {
        create_before_destroy = true
  }
}