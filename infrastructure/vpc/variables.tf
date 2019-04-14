variable "name" {
  type = "string"
} 

variable "cidr" {
  type = "string"
  description = "The CIDR block for the VPC."
  default = "10.0.0.0/26"
}

variable "subnets_cidrs" {
  type = "map"
  default = {
    public = "10.0.0.0/27"
    private = "10.0.0.32/27"
  }
}

variable "aws_region" {
  type = "string"
}