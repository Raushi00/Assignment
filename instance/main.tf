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
    key            = "aws/accounts/assignment/ap-south-1/EC2/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "assignment-common-dynamodb"
  }
}

################################################
# Tags variables defined into locals
################################################

locals {
  name          = "private-instance"
  region        = "ap-south-1"
  environment   = "dev"
  ami           = "ami-001843b876406202a"
  instance_type = "t2.micro"
  key_name      = "assignment-dev"
  tags = {
    Name              = "${local.name}-${local.environment}"
    Organization      = "Qoala"
    Environment       = "dev"
    Project           = "Assignment"
    Application       = "private-subnet"
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
# EC2 Module
################################################

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "${local.name}"

  ami                    = local.ami
  instance_type          = local.instance_type
  key_name               = local.key_name
  vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.private_security_group_id]
  subnet_id              = data.terraform_remote_state.vpc.outputs.private_subnet_zone_a
 # iam_instance_profile   = local.profile

  root_block_device = [{
    volume_type = "gp3"
    volume_size = 50
  }]

 # ebs_block_device = [
 #   {
 #     device_name = "/dev/sdf"
 #     volume_type = "gp3"
 #     volume_size = 100
 #   }
 # ]
  volume_tags = local.tags
  tags        = local.tags
}
