# This Terraform configuration deploys an EC2 instance with NGINX on Amazon Linux 2
# Here's what you must configure *outside* this file:

provider "aws" {
  region = "us-east-1" # <-- Set your AWS region (example: us-east-1)
}

# Retrieves the default VPC
data "aws_vpc" "default" {
  default = true
}

# Retrieves the first public subnet from the default VPC
data "aws_subnet" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }

  availability_zone = "us-east-1a" # <-- Replace with AZ in your selected region
}

#    AWS Key Pair must be created outside Terraform
#    Create one in AWS Console or use `aws ec2 create-key-pair --key-name test-key`
#    Save the private key as test-key.pem in ~/.ssh or appropriate local path
resource "aws_security_group" "nginx_sg" {
  name        = "nginx-sg"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "nginx_server" {
  ami                    = "ami-xxxxxxxxxxxxxxxxx" # <-- Replace with a current Amazon Linux 2 AMI ID for your region
  instance_type          = "t2.micro"              # Free tier eligible instance type
  key_name               = "your-key-name"         # <-- Replace with the name of your AWS EC2 key pair
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  subnet_id              = data.aws_subnet.default.id

  tags = {
    Name = "nginx-server"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/your-key.pem") # <-- Update with path to your private key
      host        = self.public_ip
    }
  }
}
