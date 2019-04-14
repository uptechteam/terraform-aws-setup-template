variable "name" {
  type = "string"
}

variable "env" {
  type = "string"
}

variable "subnet_ids" {
  type = "list"
  default = []
}

variable "security_group_ids" {
  type = "list"
  default = []
}

variable "username" {
  type = "string"
}

variable "password" {
  type = "string"
}

variable "db_name" {
  type = "string"
}
