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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAa8s/HyEapMVRbF6i2y0eq433G+lkCNUoSicGiTlVZK6jj2D6nkeApyjMvO+b9d68Gr8sokh/sOiE91suZm33ZN0u1Fho9kbkI5tZmi6yJJlcbha7/Yjg6Hb8ZptV8f6TqML0JkIMp50Z1itE1UPThUzcVyJ5AM2J47k0LseYC640BEzjlJOd45I5LCA7ew7sBmYLzP+yb5Z3EkxvADCQwtlWfnO1goMwnqnG5Zkmt3fKdzCmQ6Ig4Vu54XzbqeHoSyuVp7xRdPq/BO3XnrrWIjBff9amyOajKVzq6XkvEfOp5n8O0Y5X+RiHrPxWDvkGPi27P5IQmiXCCPCUc7dN yassir@ubuntu"
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

output "bastion" {
  value = aws_instance.ey_bastion
}
