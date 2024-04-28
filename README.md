Terraform Infrastructure Deployment Guide

Overview
This repository contains Terraform code to provision and manage infrastructure on AWS using IaC principles. The code sets up an AWS VPC with two public and two private subnets an EC2 instance in one private subnet, and Public Application Load Balancer (ALB) in two public subnet for high availability.

Prerequisites
Terraform installed in workstation and server
Appropriate AWS IAM/USER role permission required

Step to execute Terraform Code

Initialize Terraform

terraform init

Plan Terraform

terraform paln

Deploy Infrastructure

terraform apply

Verify Deployment: After Terraform applies the changes successfully, verify that the infra is provisioned correctly in your AWS console.


-------------


