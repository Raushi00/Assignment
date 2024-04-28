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
    key            = "aws/accounts/ap-south-1/loadbalancer/alb-public/terraform.tfstate"
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
    Project      = "Assignment"
    Application  = "public-elb"
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

data "terraform_remote_state" "sg" {
  backend = "s3"

  config = {
    region = "ap-south-1"
    bucket = "assignment-tf-statefile-s3"
    key    = "aws/accounts/assignment/ap-south-1/dev/security-groups/terraform.tfstate"
  }
}


################################################
# ALB Module Public
################################################

module "public_alb" {
  source             = "git::https://github.com/terraform-aws-modules/terraform-aws-alb.git?ref=v6.0.0"
  name               = "${local.name}-${local.environment}-public"
  internal           = false
  load_balancer_type = "application"
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets            = data.terraform_remote_state.vpc.outputs.public_subnets
  security_groups    = [data.terraform_remote_state.sg.outputs.public_elb_security_group_id]

  


  tags = local.tags
}
