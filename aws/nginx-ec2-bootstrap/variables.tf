variable "ami_id" {
  description = "Amazon Linux 2 AMI ID for your region (EC2 console > AMIs, or AWS Systems Manager public parameters)."
  type        = string
}

variable "key_name" {
  description = "Name of an existing EC2 key pair."
  type        = string
}

variable "private_key_path" {
  description = "Local path to the key pair's private key, used by the remote-exec provisioner to SSH in."
  type        = string
}
