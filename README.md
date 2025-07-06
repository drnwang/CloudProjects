# CloudProjects ☁️

A collection of practical cloud engineering projects built with Terraform, Bash, AWS CLI, and Python.
These are designed to reinforce skills in IaaS, automation, and cloud-native architecture.

---

## 🚀 Projects Included (as of now)

This repository will be updated regularly with new cloud engineering projects.
Below are the projects currently available:

* **nginx-ec2-bootstrap**
  Provision an EC2 instance, install NGINX, and verify using curl
  *(Terraform + Bash)*
  📘 *Step-by-step guide available: [Beginner's Guide to nginx-ec2-bootstrap](./nginx-ec2-bootstrap/README.md)*

* **cloudwatch-logging**
  Enable EC2 logs to stream into AWS CloudWatch
  *(IAM roles + shell scripts)*
  📘 *Beginner guide coming soon*

* **secure-by-default**
  Configure minimal inbound rules, least privilege, and patching
  *(Security groups, SSM, patch manager)*
  📘 *Beginner guide coming soon*

---

## 🛠️ Tools & Services Used

* AWS EC2, S3, IAM, CloudWatch, Systems Manager
* Terraform
* AWS CLI & Boto3
* Bash & Python

---

## 🛍️ Project Goals

* Practice infrastructure as code (IaC) in real AWS environments
* Learn security-focused provisioning patterns
* Build a hands-on cloud portfolio

---

## 📂 Folder Structure (example)

```
CloudProjects/
├── nginx-ec2-bootstrap/
│   ├── main.tf
│   ├── setup-nginx.sh
│   └── README.md
├── cloudwatch-logging/
│   ├── cloudwatch-role.tf
│   ├── enable-logging.sh
│   └── README.md
└── ...
```

---

## 📜 License

This repo is licensed under the MIT License.
