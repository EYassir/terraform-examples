provider "aws" {
  region = var.region_name
}

#Create lanch configuration
resource "aws_launch_configuration" "tf_ansible_fitec" {
  name            = "tf_ansible_fitec_${random_string.random.result}"
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.tf_allow_worpress_http.id]
  key_name        = var.key_name
  user_data       = <<-EOF
                        #!/bin/bash
                        apt update
                        apt install python -y
                        apt install apache2 -y
                        EOF
}

resource "aws_key_pair" "my_awsome_keypair" {
  key_name   = var.key_name
  public_key = var.key_value
}

#Create Security Group for ec2 instance
resource "aws_security_group" "tf_allow_worpress_http" {
  name   = "allow-ansible-demo-instance-sg"
  vpc_id = data.aws_vpc.custom_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "tf_allow_wordpress_ansible_http"
  }

}

#Create autoscaling group
resource "aws_autoscaling_group" "tf_asg_wordpress" {
  name                      = "tf-asg-ansible-fitec"
  launch_configuration      = aws_launch_configuration.tf_ansible_fitec.name
  min_size                  = 3
  max_size                  = 10
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 3
  target_group_arns         = [aws_lb_target_group.tf_wp_tg.arn]
  vpc_zone_identifier       = data.aws_subnet_ids.custom_vpc_subnets_ids.ids

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "ey_instance_from_asg"
    propagate_at_launch = true
  }
  tag {
    key                 = "Project"
    value               = "Ecommerce"
    propagate_at_launch = true
  }

}

#Create target group
resource "aws_lb_target_group" "tf_wp_tg" {
  name     = "tf-tg-ansible"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.custom_vpc.id
}


