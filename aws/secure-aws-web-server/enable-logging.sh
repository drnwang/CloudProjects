#!/bin/bash
# Enable CloudWatch logging for EC2

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')

sudo yum install -y awslogs
sudo systemctl start awslogsd
sudo systemctl enable awslogsd

sudo sed -i "s/us-east-1/$REGION/" /etc/awslogs/awscli.conf
sudo systemctl restart awslogsd
