# Beginner's Guide: nginx-ec2-bootstrap

This project provisions an Amazon EC2 instance and installs NGINX using a Terraform script and a Bash startup script.

It’s designed as a beginner-friendly, reproducible walkthrough to learn how cloud provisioning, basic scripting, and service verification work together.

---

## 🎯 What You'll Learn

* How to use Terraform to provision EC2
* How to bootstrap a Linux instance with NGINX
* How to verify installation with curl
* How to secure basic EC2 resources

---

## 📦 Project Files

```
nginx-ec2-bootstrap/
├── main.tf              # Terraform script to create the EC2 instance
├── variables.tf         # AMI ID, key pair name, private key path
├── terraform.tfvars.example  # Copy to terraform.tfvars and fill in
├── setup-nginx.sh       # Bash script to install and start NGINX
├── outputs.tf           # (optional) Outputs for instance IP
└── README.md            # This guide
```

---

## 🛠 Prerequisites

* Terraform installed
* AWS CLI installed and configured (`aws configure`)
* AWS access with permission to create EC2 instances, security groups, key pairs

---

## 🚀 Steps

### 1. Set your values

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your Amazon Linux 2 AMI ID, EC2 key pair name, and private key path.

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Review and Apply Plan

```bash
terraform plan
terraform apply
```

Choose `yes` when prompted.

### 4. SSH Into the Instance (optional)

```bash
ssh -i your-key.pem ec2-user@<public-ip>
```

Make sure port 22 is allowed in your security group.

### 5. Verify NGINX is Running

```bash
curl http://<public-ip>
```

You should see the NGINX welcome page.

---

## ✅ Expected Output

* NGINX is automatically installed and running
* You can access the server in a browser via its public IP

---

## 🧩 Possible Improvements

* Replace Bash with cloud-init
* Add SSL with Let's Encrypt
* Use remote state backend (e.g., S3)
* Add tagging and variables for reusability

---

## 📸 Screenshots

* `screenshots/nginx-verify.png`: Default NGINX page
* `screenshots/ec2-instance.png`: EC2 instance in AWS Console

---

## 🧽 Cleanup

To avoid ongoing charges, run:

```bash
terraform destroy
```
