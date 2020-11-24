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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/CvgQztRy9exBDG1furKTDapPWsQyftLv+ZnITRhNNAfbqbNdW5o98hA0FWKXT6Lck9I/OUpDYW77dHKfQ0M1g0g+iL+7a1OY67YBGDmwgyYcq5igq/JcpaXs6ysAijiwHLBvHqpq/UswNmAqvfxRp9jL79ui81d9fUd6YLuzdBA34VPad6Tog9rLEb0apwEE1668aAdhN8JbuIz6lVkf8OB2hmDEX0pliZOrFicfkkDfQIXiLVpds26fYU2QD6KWrSpqVD0TLKwlDSx9ZdYAq+jAEcq2RHlDnt9hlUf1zA3wPLQG2LiFYqi+ttuEsU/m30r8aiGsFHxCQlYRHe45 yassir@ubuntu" #var.key_value
}

data "aws_ami" "ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-*"]
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


