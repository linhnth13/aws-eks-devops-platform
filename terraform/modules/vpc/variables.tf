variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)

  validation {
    condition     = length(var.azs) > 0
    error_message = "azs must contain at least one availability zone."
  }
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}
