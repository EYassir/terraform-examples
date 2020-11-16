provider "aws" {
  region = var.region_name
}

variable "region_name" {
  description = "region name"
}

resource "random_string" "random" {
  length  = 6
  special = false
  lower   = true
}

variable "key_name" {
  default = "bastion-key"
}

variable "custom_subnet_id" {
  description = "The custom public subnet"
}

resource "aws_instance" "ey_bastion" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = var.custom_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ey_bastion_terraform.id]
  tags = {
    Name = "ey-terraform-bastion"
  }
}

resource "aws_key_pair" "my_awsome_keypair" {
  key_name   = var.key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9M6M0AxjVyf+Fmzyogz1GA8MllG0p3CC8bq+/hLPYPdJvLU/9YVvRzgaR9FLSA6Zv/+xAyeKxMkCrxYLKfAn5Xz0NxMgleePZElcIP+HHZzh6wDzY7Op5X3yd7pPuNXjNgKizhfJa4OXpoIpnVAEaau7vTY6R2zgT8BUpUX/Fn/o1cHSzE4BYg2SsXUAH73q5GFCLHiqQ6pX2O4UU49QjuL0346GSObwu1ZBgeCezRteGoOibIYKfuIvVlrxDm4SKxTkBbkEGtMZntIB+vWZjEA/YKmEYsq6e2tVMh+i1T4L7SwlAnyrbN9Z0DbbEENQHusnWlNWJQehalGQlYA/v yassir@ubuntu"
}

data "aws_ami" "ubuntu" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["Cloud9Ubuntu-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


#Create Security Group for ec2 instance
resource "aws_security_group" "ey_bastion_terraform" {
  name   = "ey-terraform-bastion-sg"
  vpc_id = var.custom_vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "ey-bastion-terraform"
  }

}

variable "custom_vpc_id" {
  description = "The vpc id"
}
