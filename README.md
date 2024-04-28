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

------------------------------------------

Task 3 : CI/CD with GitHub Actions

CI/CD with GitHub Actions
This repository folder github-actions contains scripts and configurations for implementing CI and CD pipelines using GitHub Actions for a Node.js sample application. The CI/CD pipeline includes building, testing, and deploying the application to a staging environment.

To set up the CI/CD pipeline for your Node.js application, follow these steps:

GitHub Repository Setup: Create a GitHub repository for your Node.js application.

GitHub Secrets Configuration: Add the following secrets to your GitHub repository:

AWS_ACCESS_KEY_ID: AWS Access Key ID

AWS_SECRET_ACCESS_KEY: AWS Secret Access Key

Deployment Configuration:

Ensure that ArgoCD is configured and accessible in your staging environment.

The provided workflow will automatically deploy the application to the staging environment using ArgoCD.


Workflow Description:

The main.yaml workflow file defines the following steps:

Build Image: This step builds the Docker image for the Node.js application.

Configure AWS Credentials: Configures AWS credentials using GitHub Secrets.

Login to Amazon ECR: Logs in to Amazon ECR to push the Docker image.

Image Tagging: Tags the Docker image using the GitHub Build number.

Build, Tag, and Push Image: Builds the Docker image, tags it, and pushes it to Amazon ECR.
Update values.yaml: Updates the values.yaml file with the new image tag and pushes the changes to the GitHub repository

-------------------------------

Task 4 : DevOps & Automation

AWS S3 Backup and EC2 Insatance Scaling Automation

This repository folder devops-automation contains scripts to automate two tasks:

1. Backup an AWS S3 bucket to a local directory.
2. Automatically scale EC2 instances based on CPU utilization.

Scripts:

backup_s3.py/backup_s3.sh: This script automates the backup process of an AWS S3 bucket.

instance_scale_cpu.py: This script implements automatic scaling of EC2 instances based on CPU utilization.

I would like to suggest also below alternative automation to achieve this 

S3 Replication for Backup:
Instead of downloading S3 objects to a local directory/Server, an alternative solution is to utilize S3 Replication. S3 Replication allows automatic replication of objects from one S3 bucket to another, either within the same AWS Region or across different Regions. This ensures data redundancy and disaster recovery without the need for manual intervention.

Auto Scaling Policies for EC2
Rather than managing EC2 instance scaling through custom scripts, AWS offers Auto Scaling Policies that can be configured to automatically adjust the number of EC2 instances based on various metrics, including CPU utilization. Specifically, Step Scaling Policies can be employed to define scaling adjustments based on predefined thresholds.

Setup and Usage
To use the provided scripts, follow the steps below:

1. Prerequisites:
Ensure you have Python installed on your system.

Install the required AWS CLI, Python, Python packages using pip install boto3.

Note:

Ensure proper IAM roles and permissions are configured for the AWS credentials used by the scripts to access S3 and EC2 resources.

Review and test the scripts in a non-production environment before deploying them to production.