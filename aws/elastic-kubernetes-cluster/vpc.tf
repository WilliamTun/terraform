# Resource: 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs

resource "aws_vpc" "main" {
  # CIDR (Classless Inter-Domain Routing) block for the VPC
  cidr_block = "192.168.0.0/16"

  # ensures the instances are shared on the host
  instance_tenancy = "default"

  # required for EKS. Enable DNS (Domain Name System) support in the VPC
  enable_dns_support   = true
  enable_dns_hostnames = true

  # Disable classicLink for VPC to prevent EC2-classic instances linking to VPC.
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  assign_generated_ipv6_cidr_block = false

  # A map of tags to assign to the resource
  tags = {
    Name = "main"
  }
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id."

  # Setting the sensitive parameter as FALSE prevents Terraform from showing this value
  sensitive = false
}