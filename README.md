Task 1 : Infrastructure as Code (IaC) with Terraform

Terraform Infrastructure Deployment Guide:
Overview:

This repository folder AWS contains Terraform code to provision and manage infrastructure on AWS using IaC principles. The code sets up an AWS VPC with two public and two private subnets an EC2 instance in one private subnet, and Public Application Load Balancer (ALB) in two public subnet for high availability.

Prerequisites:

Terraform installed in workstation and server
Appropriate AWS IAM/USER role permission required

Step to execute Terraform Code:

Initialize Terraform

terraform init

Plan Terraform

terraform paln

Deploy Infrastructure

terraform apply

Verify Deployment: After Terraform applies the changes successfully, verify that the infra is provisioned correctly in your AWS console.


-------------

Task 2 : Kubernetes Deployment

Kubernetes Deployment Manifest file:

This repository folder kubernetes-deployment contains YAML configurations to deploy a sample application (nginx) on a Kubernetes cluster. The deployment is configured for high availability and implements rolling updates for the application.

High Availability Configuration:
The deployment is configured for high availability through the following settings:

Replicas: The number of replicas can be scaled up to increase availability.
Rolling Updates: Updates to the application are rolled out gradually, ensuring availability during the update process.

Rolling Updates:
Rolling updates for the application are implemented with the following strategy:

Max Surge: During an update, allows for a maximum of 25% additional pods beyond the desired number of replicas.

Max Unavailable: During an update, allows for a maximum of 25% of pods to be unavailable.

----------
