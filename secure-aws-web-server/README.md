# Project: Launch and Secure a Web Server on AWS

## 📌 Overview
Deploy a Linux-based web server on AWS using EC2. Harden it with Security Groups and enable basic monitoring using AWS CloudWatch.

## 🛠️ Stack
- AWS EC2 (Amazon Linux 2)
- AWS CLI or Terraform (optional)
- NGINX
- CloudWatch Logs
- Bash scripting

## 🎯 Objectives
- Launch EC2 instance securely
- Configure firewall rules (Security Groups)
- Install and verify NGINX
- Enable CloudWatch logging

## 📁 File Structure
```
secure-aws-web-server/
├── setup-nginx.sh
├── enable-logging.sh
├── screenshots/
│   ├── nginx-verify.png
│   └── cloudwatch-logs.png
└── README.md
```

## 🚀 Setup Instructions

### 1. Launch EC2 Instance
- Use Amazon Linux 2
- Choose `t2.micro` (Free Tier)
- Enable ports 22 (SSH) and 80 (HTTP) in Security Groups

### 2. Connect via SSH
```bash
ssh -i my-key.pem ec2-user@<public-ip>
```

### 3. Run Setup Script
```bash
chmod +x setup-nginx.sh
./setup-nginx.sh
```

### 4. Verify in Browser
Visit `http://<public-ip>` and confirm NGINX welcome page

### 5. Enable Logging (Optional)
```bash
chmod +x enable-logging.sh
./enable-logging.sh
```

## ✅ Expected Output
- ✔️ NGINX running and accessible
- ✔️ Security group allows limited inbound traffic
- ✔️ Logs visible in CloudWatch

## 📸 Screenshots
- `screenshots/nginx-verify.png`: NGINX default page
- `screenshots/cloudwatch-logs.png`: System logs in CloudWatch

## 🧩 Improvements
- Use Terraform to automate EC2 provisioning
- Add SSL with Let's Encrypt
- Integrate with AWS Systems Manager for patching

---


### `setup-nginx.sh`
```bash
#!/bin/bash
# Install and start NGINX on Amazon Linux 2

sudo yum update -y
sudo amazon-linux-extras enable nginx1 -y
sudo yum install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
```

### `enable-logging.sh`
```bash
#!/bin/bash
# Enable CloudWatch logging for EC2

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')

sudo yum install -y awslogs
sudo systemctl start awslogsd
sudo systemctl enable awslogsd

sudo sed -i "s/us-east-1/$REGION/" /etc/awslogs/awscli.conf
sudo systemctl restart awslogsd
```

---

You're now ready to commit this into `secure-aws-web-server/` inside your CloudProjects GitHub repo.
