#!/bin/bash

# Update packages
sudo yum update -y

# Install NGINX
sudo amazon-linux-extras enable nginx1 -y
sudo yum install -y nginx

# Start and enable NGINX
sudo systemctl start nginx
sudo systemctl enable nginx

# Verify status
sudo systemctl status nginx

echo "NGINX installation and setup complete."
