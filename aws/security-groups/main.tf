###############################################
# AWS Provider information
################################################

provider "aws" {
  region = local.region
}

################################################
# Define Terraform state backend
################################################

terraform {
  backend "s3" {
    encrypt        = "true"
    bucket         = "assignment-tf-statefile-s3"
    key            = "aws/accounts/assignment/ap-south-1/dev/security-groups/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "assignment-common-dynamodb"
  }
}

################################################
# Tags variables defined into locals
################################################

locals {
  name        = "qoala"
  region      = "ap-south-1"
  environment = "dev"
  tags = {
    Organization = "Qoala"
    Environment  = "dev"
    Project      = "security-group"
  }
}

################################################
# Get the details from vpc state file
################################################

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    region = "ap-south-1"
    bucket = "assignment-tf-statefile-s3"
    key    = "aws/accounts/assignment/ap-south-1/vpc/terraform.tfstate"
  }
}

################################################
# EC2 instance private SG
################################################

module "security_gp" {
  source      = "terraform-aws-modules/security-group/aws"
  name        = "${local.name}-${local.environment}-private-server-sg"
  description = "${local.name}-${local.environment} private instance security group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "allow all within vpc cidr"
      cidr_blocks = data.terraform_remote_state.vpc.outputs.cidr_block
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "allow outbound requests"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = local.tags

}


################################################
# Public ALB SG 
################################################

module "public_alb_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.name}-dev-alb-public-sg"
  description = "${local.name}-dev alb public sg"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "http inboud rule allowed"
      cidr_blocks = data.terraform_remote_state.vpc.outputs.cidr_block
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "outbound open for ALl"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = local.tags
  
}