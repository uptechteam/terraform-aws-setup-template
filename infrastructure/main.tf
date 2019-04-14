terraform {
  backend "s3" {
    key = "dev/state.tfstate"
    encrypt = true
  }
}


# VPC
module "vpc" {
  source = "vpc"
  name = "${var.project_name}"
  cidr = "${var.vpc_cidr}"
  subnets_cidrs = "${var.vpc_subnets_cidrs}"
  aws_region = "${var.aws_region}"
}

#IAM
module "service_iam" {
  source = "iam"
  username = "${var.project_name}-service-user"
}
