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