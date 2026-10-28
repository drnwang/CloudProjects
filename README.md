# Cloud & Infrastructure Projects ☁️

[![Terraform checks](https://github.com/drnwang/CloudProjects/actions/workflows/terraform-checks.yml/badge.svg)](https://github.com/drnwang/CloudProjects/actions/workflows/terraform-checks.yml)

Hands-on projects by **Nathaniel Wang**: Windows systems administrator and IT/security professional (CompTIA Security+) building practical skills in cloud infrastructure, automation, and secure-by-default design.

Each project lives in its own folder with a README that explains what it does, how it was built, and how to run it.

---

## 📂 Projects

### AWS

| Project | What it does | Tools |
|---|---|---|
| [**Secure AWS Web Server**](./aws/secure-aws-web-server/) | Launches an EC2 web server, locks it down with Security Groups, installs NGINX, and sends logs to CloudWatch. Includes a step-by-step guide with screenshots. | EC2, Security Groups, NGINX, CloudWatch, Bash |
| [**NGINX EC2 Bootstrap**](./aws/nginx-ec2-bootstrap/) | Provisions an EC2 instance with Terraform and installs NGINX automatically at boot, then verifies it with `curl`. | Terraform, EC2, Bash |
| [**Secure Static Website**](./aws/s3-cloudfront-static-site/) | Hosts a site in a private S3 bucket served only through CloudFront over HTTPS, using Origin Access Control and a least-privilege bucket policy. | S3, CloudFront, IAM policies |
| [**Security Monitoring**](./aws/security-monitoring/) | Enables CloudTrail, GuardDuty, and Security Hub (CIS + AWS best-practice standards) with email alerts for root use, no-MFA sign-ins, and high-severity threats. | Terraform, CloudTrail, GuardDuty, Security Hub, CloudWatch, SNS, EventBridge |

### Automation & scripting

Windows, Active Directory, and Linux admin scripts live in a separate repo:
➡️ [**sysadmin-automation-scripts**](https://github.com/drnwang/sysadmin-automation-scripts)

---

## 📁 Repository layout

```
CloudProjects/
├── aws/
│   ├── secure-aws-web-server/     # EC2 + NGINX + CloudWatch, with screenshots
│   ├── nginx-ec2-bootstrap/       # Terraform + bootstrap script
│   ├── s3-cloudfront-static-site/ # Private S3 + CloudFront (OAC)
│   └── security-monitoring/       # CloudTrail + GuardDuty + Security Hub (Terraform)
├── .github/workflows/             # Terraform validate + Checkov security scan
├── LICENSE
└── README.md
```

---

## 🛠️ Skills practiced

- **Infrastructure as code:** Terraform
- **AWS:** EC2, S3, CloudFront, IAM, Security Groups, CloudWatch
- **Security:** least privilege, private origins, HTTPS-only delivery, restricted inbound rules
- **Automation:** Bash bootstrap scripts, AWS CLI
- **DevSecOps:** every push runs `terraform validate` and a Checkov security scan in GitHub Actions
- **Security monitoring:** CloudTrail, GuardDuty, Security Hub, CIS benchmark alerts

---

## 👤 About me

10+ years supporting Windows server environments, endpoints, and users for federal agencies and enterprises, including vulnerability remediation and DISA STIG hardening.

- LinkedIn: [linkedin.com/in/nathaniel-wang](https://www.linkedin.com/in/nathaniel-wang/)
- Medium: [@nathanielwang](https://medium.com/@nathanielwang)

## 📜 License

MIT. See [LICENSE](./LICENSE).
