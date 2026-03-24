variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "aws-eks-devops-platform"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

# Deprecated: VPC and subnet CIDR variables are now managed by VPC modules
# variable "vpc_cidr" {
#   description = "CIDR for VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }
#
# variable "public_subnet_1_cidr" {
#   type    = string
#   default = "10.0.1.0/24"
# }
#
# variable "public_subnet_2_cidr" {
#   type    = string
#   default = "10.0.2.0/24"
# }
#
# variable "private_subnet_1_cidr" {
#   type    = string
#   default = "10.0.11.0/24"
# }
#
# variable "private_subnet_2_cidr" {
#   type    = string
#   default = "10.0.12.0/24"
# }