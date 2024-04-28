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