variable "project_name" {
  type = "string"
}

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  type = "string"
}

variable "vpc_cidr" {
  type = "string"
  default = "10.0.0.0/26"
}

variable "vpc_subnets_cidrs" {
  type = "map"
  default = {
    public = "10.0.0.0/27"
    private = "10.0.0.32/27"
  }
}

variable "public_ports" {
  type = "list"
  default = [22, 80, 443]
}

variable "dev_instance_ssh_key_path" {
  type = "string"
}

variable "staging_instance_ssh_key_path" {
  type = "string"
}

variable "dev_instance_volume_size" {
  default = 20
}

variable "staging_instance_volume_size" {
  default = 20
}

variable "instance_ami" {
  type = "string"
  default = "ami-0922553b7b0369273"
}

variable "dev_instance_type" {
  type = "string"
  default = "t2.micro"
}

variable "staging_instance_type" {
  type = "string"
  default = "t2.micro"
}

# RDS
variable "dev_db_username" {
  type = "string"
}

variable "dev_db_password" {
  type = "string"
}

variable "dev_db_name" {
  type = "string"
}

variable "staging_db_username" {
  type = "string"
}

variable "staging_db_password" {
  type = "string"
}

variable "staging_db_name" {
  type = "string"
}

variable "route53_domain_name" {
  type = "string"
}