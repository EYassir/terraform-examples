provider "aws" {
  region = var.region_name
}

#Create load balancer
resource "aws_lb" "tf_lb_wp" {
  name               = "ey-lb-wordpress"
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_01.id, aws_subnet.public_02.id, aws_subnet.public_03.id] #data.aws_subnet_ids.custom_vpc_subnets_ids.ids
  security_groups    = [aws_security_group.tf_alb_worpress_http.id]

  tags = {
    Name = "ey-lb-wordpress"
  }
}

resource "aws_lb_listener_rule" "tf_asg_rule" {
  listener_arn = aws_lb_listener.tf_http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = var.target_group.arn #data.terraform_remote_state.asg.outputs.asg_taget_group.arn
  }
}

resource "aws_lb_listener" "tf_http" {
  load_balancer_arn = aws_lb.tf_lb_wp.arn
  port              = var.app_port
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

#Create Security Group for ALB instance
resource "aws_security_group" "tf_alb_worpress_http" {
  name   = "alb-wp-instance-sg"
  vpc_id = data.aws_vpc.custom_vpc.id
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
    Name = "tf_alb_wordpress_http"
  }

}
