variable "project_name" {
  type = "string"
}

variable "env" {
  type = "string"
}

variable "instance_ami" {
  type = "string"
  default = "ami-0922553b7b0369273"
}

variable "instance_type" {
  type = "string"
  default = "t2.micro"
}

variable "s3_bucket_access_role_name" {
  type = "string"
}

variable "subnet_id" {
  type = "string"
}

variable "ssh_key_path" {
  type = "string"
}

variable "volume_size" {
  default = 10
}

variable "security_groups" {
  default = []
}