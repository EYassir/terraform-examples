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

resource "aws_iam_policy" "jenkins_policy" {
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}

#Create IAM ROLE
resource "aws_iam_role" "jenkins_role" {

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

    tags = {
      tag-key = "jenkins-sysops"
    }

}
resource "aws_iam_policy_attachment" "attach_jenkins_policy" {
  name       = "jenkins-adminAccess-attachment"
  roles      = [aws_iam_role.jenkins_role.name]
  policy_arn = aws_iam_policy.jenkins_policy.arn
}

resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "test_profile"
  role = aws_iam_role.jenkins_role.name
}


resource "aws_instance" "ey_jenkins" {
  count                  = var.number_of_jenkins  
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = var.custom_subnet_id
  key_name               = var.jenkins_key_name
  vpc_security_group_ids = [aws_security_group.ey_jenkins_terraform.id]
  user_data              = data.template_file.user_data.rendered
  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name
  tags = {
    Name = "ey-terraform-jenkins"
  }
}

resource "aws_key_pair" "jenkins_keypair" {
  key_name   = var.jenkins_key_name
  public_key = var.jenkins_key_value
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
resource "aws_security_group" "ey_jenkins_terraform" {
  name   = "ey-terraform-jenkins-sg"
  vpc_id = var.custom_vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name = "ey-jenkins-terraform"
  }

}


data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")
  
}