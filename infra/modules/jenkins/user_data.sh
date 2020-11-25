#!/bin/bash
apt update
apt install awscli unzip -y
apt install openjdk-8-jre-headless maven -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt update
apt install jenkins -y
systemctl start jenkins
wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
unzip terraform_0.13.5_linux_amd64.zip
mv terraform /usr/bin/
apt install ansible python3 python3-pip -y
pip3 install awscli --upgrade
sudo su jenkins
pip3 install boto3
