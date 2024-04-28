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
    key            = "aws/accounts/assignment/ap-south-1/vpc/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "assignment-common-dynamodb"
  }
}

################################################
# Tags variables defined into locals
################################################

locals {
  name         = "qoala-assign"
  region       = "ap-south-1"
  environment  = "dev"
  tags = {
    Organization = "Qoala"
    Project      = "Assignment"
    Application  = "network"
  }
}

################################################
# VPC Module
################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${local.name}-${local.environment}-vpc"
  cidr = "10.0.0.0/16"

  azs                 = ["${local.region}a", "${local.region}b"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24"]

  create_database_subnet_group = false

  manage_default_route_table = true
  default_route_table_tags   = { DefaultRouteTable = true }

  enable_dns_hostnames    = true
  enable_dns_support      = true
  enable_vpn_gateway      = true
  map_public_ip_on_launch = false

  private_subnet_suffix     = "app"
  public_subnet_suffix      = "public"

  enable_nat_gateway = true
  single_nat_gateway = false

 # enable_dhcp_options              = false
  #dhcp_options_domain_name         = "service.consul"
  #dhcp_options_domain_name_servers = ["10.183.8.2"]

  # Default security group - ingress/egress rules cleared to deny all
 manage_default_security_group  = true
 default_security_group_ingress = []
 default_security_group_egress  = []


  

  tags = local.tags
}

