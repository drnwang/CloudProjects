### Cloud Beginner FAQ (Context-Based)

**Q1: What happens if I lose my `.pem` file?**
If you lose your `.pem` file, you won't be able to SSH into your instance. AWS doesn't allow downloading the same key pair again. Your options:

* Stop the instance and detach the volume
* Attach the volume to another instance
* Mount the volume and add a new key to `~/.ssh/authorized_keys`
* Reattach to a new instance

**Q2: What username should I use when connecting via SSH?**
Use `ec2-user` for Amazon Linux 2 AMIs. Other AMIs have different usernames (e.g., `ubuntu`, `admin`, or `centos`).

**Q3: How do I find my EC2 public IP address?**
Go to the EC2 Dashboard, click your instance ID, and scroll down to find "Public IPv4 address" under the "Details" tab.

**Q4: I'm getting a 'Permission denied (publickey)' error when connecting via SSH. What should I check?**

* Make sure your `.pem` file has the correct permissions (`chmod 400` on Linux/macOS)
* Ensure you're using the correct IP address
* Confirm the username matches the OS
* Verify you’re using the correct path to your `.pem` file

**Q5: I ran the SSH command but nothing is happening. What now?**

* It might be a firewall/security group issue — ensure port 22 (SSH) is open in your EC2 security group
* Make sure your instance is in the "running" state
* Check your internet connection

**Q6: Can I use Windows Command Prompt to SSH?**
No. The standard Command Prompt doesn't support SSH with `.pem` files easily. Use PowerShell, Git Bash, or WSL.

**Q7: I get a warning about host authenticity. Should I worry?**
This is normal when connecting for the first time. Type `yes` to proceed. It's a fingerprint validation to confirm the host identity.

**Q8: How do I uninstall NGINX from the EC2 instance?**

```bash
sudo yum remove nginx -y
```

**Q9: What if I forgot to open port 80 or 22 during setup?**

* Go to EC2 > Security Groups
* Select your instance's security group
* Click "Edit inbound rules"
* Add rules for:

  * Type: SSH | Port: 22 | Source: Anywhere (0.0.0.0/0)
  * Type: HTTP | Port: 80 | Source: Anywhere (0.0.0.0/0)

**Q10: Is it safe to open SSH and HTTP to 0.0.0.0/0?**
It's okay for beginners and testing, but not recommended for production. Later you can restrict IPs or use VPNs/Firewalls.

---

More FAQs coming as users explore the guide.
