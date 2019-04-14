variable "name" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "public_ports" {
  default = [22, 80, 443]
}

variable "whitelisted_cidrs" {
  default = []
}