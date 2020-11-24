#!/bin/bash
apt update
apt install python -y
apt install awscli -y
apt install apache2 php php-mysql php-curl -y
rm -rf /var/www/html/index.html
echo "i'm fine" > /var/www/html/health.html
echo "hello" > /var/www/html/hello.html
cd ~/.ssh/
#echo ${private_git} > /root/.ssh/id_rsa
aws s3 cp s3://terraform-fitec-example-bucket-state/gitkey id_rsa
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