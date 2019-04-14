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

# S3
module "dev_bucket" {
  source = "s3"
  user_arn = "${module.service_iam.iam_user_arn}"
  bucket_name = "${var.project_name}-dev-bucket"
  aws_region = "${var.aws_region}"
}

module "staging_bucket" {
  source = "s3"
  user_arn = "${module.service_iam.iam_user_arn}"
  bucket_name = "${var.project_name}-staging-bucket"
  aws_region = "${var.aws_region}"
}

# Security groups
module "security_groups" {
  source = "security_group"
  name = "${var.project_name}"
  vpc_id = "${module.vpc.vpc-id}"
  public_ports = ["${var.public_ports}"]
  whitelisted_cidrs = ["${module.vpc.private-subnet-cidr}", "${module.vpc.public-subnet-cidr}"]
}

# EC2
module "dev_instance" {
  source = "instance"
  project_name = "${var.project_name}"
  env = "dev"
  instance_ami = "${var.instance_ami}"
  instance_type = "${var.dev_instance_type}"
  s3_bucket_access_role_name = "${module.dev_bucket.s3-access-role-name}"
  subnet_id = "${module.vpc.public-subnet-id}"
  ssh_key_path = "${var.dev_instance_ssh_key_path}"
  volume_size = "${var.dev_instance_volume_size}"
  security_groups = ["${module.security_groups.public-security-group-id}", "${module.security_groups.private-security-group-id}"]
}

module "staging_instance" {
  source = "instance"
  project_name = "${var.project_name}"
  env = "staging"
  instance_ami = "${var.instance_ami}"
  instance_type = "${var.staging_instance_type}"
  s3_bucket_access_role_name = "${module.staging_bucket.s3-access-role-name}"
  subnet_id = "${module.vpc.public-subnet-id}"
  ssh_key_path = "${var.staging_instance_ssh_key_path}"
  volume_size = "${var.staging_instance_volume_size}"
  security_groups = ["${module.security_groups.public-security-group-id}", "${module.security_groups.private-security-group-id}"]
}