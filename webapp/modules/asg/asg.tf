data "aws_secretsmanager_secret_version" "git_key" {
  secret_id = data.aws_secretsmanager_secret.git_secret.id
}
data "aws_secretsmanager_secret" "git_secret" {
  arn = "arn:aws:secretsmanager:eu-west-1:411953124370:secret:git_key_asg-fEeUUf"
}

#jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["dp_password"]

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")
  vars = {
    private_git = jsondecode(data.aws_secretsmanager_secret_version.git_key.secret_string)["asg_git_key"]
  }
}

resource "aws_iam_policy" "cwagent_policy" {
  name = "cwagent_policy_myapp"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": ["logs:*",
                         "s3:*"],
            "Resource": "*"
        }
    ]
}
EOF
}

#Create IAM ROLE
resource "aws_iam_role" "cwagent_role" {
  name = "cwagent_tf_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
                 
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  permissions_boundary = aws_iam_policy.cwagent_policy.arn #"arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/cwagent_policy_myapp"

  tags = {
    tag-key = "tf-cwagent"
  }
}
resource "aws_iam_policy_attachment" "test_attach" {
  name       = "test-attachment"
  roles      = [aws_iam_role.cwagent_role.name]
  policy_arn = aws_iam_policy.cwagent_policy.arn
}

resource "aws_iam_instance_profile" "cwagtn_profile" {
  name = "test_profile"
  role = aws_iam_role.cwagent_role.name
}


#Create lanch configuration
resource "aws_launch_configuration" "tf_ansible_fitec" {
  name                 = "tf_ansible_fitec__${random_string.random.result}"
  image_id             = data.aws_ami.ubuntu.id
  instance_type        = "t2.micro"
  security_groups      = [aws_security_group.tf_allow_worpress_http.id]
  key_name             = var.key_name
  iam_instance_profile = aws_iam_instance_profile.cwagtn_profile.name
  user_data            = data.template_file.user_data.rendered
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
  vpc_zone_identifier       = var.private_vpc_app_subnets

  # initial_lifecycle_hook {
  #   name                 = "foobar"
  #   default_result       = "CONTINUE"
  #   heartbeat_timeout    = 2000
  #   lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

  #   role_arn = "arn:aws:iam::411953124370:role/awslogs-fitec-role" #aws_iam_role.cwagent_role.arn
  # }

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
  health_check {
    enabled             = true
    interval            = 300
    path                = "/health.html"
    port                = 80
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = 200
  }
}


