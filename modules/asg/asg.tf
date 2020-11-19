provider "aws" {
  region = var.region_name
}

#Create lanch configuration
resource "aws_launch_configuration" "tf_ansible_fitec" {
  name            = "tf_ansible_fitec__${random_string.random.result}"
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.tf_allow_worpress_http.id]
  key_name        = var.key_name
  user_data       = <<-EOF
                        #!/bin/bash
                        apt update
                        apt install python -y
                        apt install apache2 php php-mysql php-curl -y
                        rm -rf /var/www/html/index.html
                        cd ~/.ssh/
                        echo """-----BEGIN RSA PRIVATE KEY-----
                        MIIEowIBAAKCAQEAtvej2X2UBdymbo4I6hSMenNLnJ/HRfOnmxUDkYrLsvpH5TPS
                        antURToQCFM/x4sPS+xEVntDhJVG99R2OJe+nCvNcVdsmIgJRrSXf9H6tcsxniSr
                        HQGJHJu4Mm3POJNhp56KyqsAISKFLmf9+UOP0rEzlqr+NRHyccLinL6/b2bKH9wI
                        sZvXskTi+IWbyYaU+1p5PXYBuXw5YyoZwYddmcBWTI6twsxaZfwZPtga3EdaH37t
                        pCwj9KabBh8HC8e28stPemf7fUB8Wo0mnphusyILQslzGE5rkhjVxfug1EhfPwbZ
                        moM9kyoo/pDtLEuU2iP5dFm6MnBNNxMQQfF5BQIDAQABAoIBAB1s/mEAHUpEDlBB
                        b5WV8HHRERwDZl0Nrqr2WjiSBeim7+Eg0Hpnk0n+6I0uNle1OaSQPv1ZnaY5C8zX
                        0puPbAxZzxSnZsOxPSyt5p+b+aI7J6OzagGkOZTsRld16ZnDujTm/pNRpRevIZQx
                        DVuFTiAod4+HuJJ4bHF3UlK7KraTn9XfYTb3A9H72V6TzebjJr4T0r857MeoVXQQ
                        q2SucMnwjvJGtwr0he14uEVfHzwPCtd7XCi+17O5rvlFqsIIKYDtdk8+BcnGx8It
                        OG57JtV7clJxW71EmDlz0M3BH6nAD/njx6DPH+XTEw1MqXDCGH3VP7VFkhKLbWlN
                        BSXY8pECgYEA3IRHUNgjWRPneFw9oAZcU0K82D81l9djDiTvu4wrdQfiEcBqSaLw
                        j0DLsb49Xt0kMeGV6HVpCVYh0pXGlp4GoQwyCtYXyr7FEpmbNMtUxIL2mBe1pODg
                        hJw6Wl5TUieP0FSgP7x8DxQOWDBNPdfExMMhP5djWS17hxG6p98nLRMCgYEA1GiY
                        JAWSqJCTvbcRLVev/263c6U+FO6zhOgASIKmGSMtbS+ciceOcBBVeYWr0ZWrlnMx
                        sy6wcImxsxckjvE6u7c2ezmhYsh5oIZvToRiuNfNNy21UbLnTt17hlhbhX8pmm3z
                        7D1E22g0kYyxTgt6caiBLsZkRpc7soDOGTuu/IcCgYB08UVsryKXw8F2B9y6d4UQ
                        toy1VVgTjSq/voDQAfat2p9d8J+tK1bNcXxUZ2HeZAIk3dAE9fbc96t6JOmqyGUV
                        lQUY0A7P+zlBsuonJklu6VDiuXgf1w3Z5YvgjrM7FzXiMm7FPizARk+RHxRnXnzA
                        KAcC1ULfcQpYR+On0OTStwKBgQCyVd7m34by3/ArKLjTSPwLifmcrvAgwwkWXXNf
                        bdHm6RIKyh6zz0hX7l7VWNWZcgBOoQjpWBnrYrA/nP6kxQR69qhXbVuChK8Zh8WM
                        NrpsV0OFQGsr3Pk3zd0YPrcYrltPvWE+x3I4hJUeXvG+hQSYyNEtZIRsgC0vAdYI
                        eYPBoQKBgGDu+H4fjOCVOM3SVcIH3+Em1St7zJ9pg4d9ZWUB1fm9+yVjTxldLeCD
                        2PCwXRD7z61p9hupcBIPlcDHRgpqzUOfu8MjRsdtjSl0P4RA6wJ7216GdlPzcYvG
                        WJJyJlRT3fgtCNRLkLw9pXSd1pkUeqtaDSW4NRx/iYvtgjQyBBhv
                        -----END RSA PRIVATE KEY-----""" > /root/.ssh/id_rsa
                        echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC296PZfZQF3KZujgjqFIx6c0ucn8dF86ebFQORisuy+kflM9Jqe1RFOhAIUz/Hiw9L7ERWe0OElUb31HY4l76cK81xV2yYiAlGtJd/0fq1yzGeJKsdAYkcm7gybc84k2GnnorKqwAhIoUuZ/35Q4/SsTOWqv41EfJxwuKcvr9vZsof3Aixm9eyROL4hZvJhpT7Wnk9dgG5fDljKhnBh12ZwFZMjq3CzFpl/Bk+2BrcR1offu2kLCP0ppsGHwcLx7byy096Z/t9QHxajSaemG6zIgtCyXMYTmuSGNXF+6DUSF8/Btmagz2TKij+kO0sS5TaI/l0WboycE03ExBB8XkF yassir@ubuntu" > /root/.ssh/id_rsa.pub                                                
                        cd /root/.ssh
                        chmod 400 id_rsa
                        echo """
                        Host *
                          StrictHostKeyChecking no
                          UserKnownHostsFile=/dev/null"""> config
                        cd /var/www/html
                        git clone git@gitlab.com:EYassir/wordpress-asg.git  
                        mv wordpress-asg/* .
                        mv wordpress-asg/.git* .
                        rm -rf wordpress-asg
                        chown -R www-data:www-data /var/www/html
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


