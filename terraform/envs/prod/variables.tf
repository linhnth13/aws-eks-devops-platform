variable "primary_region" {
  description = "Primary AWS region for production"
  type        = string
  default     = "ap-southeast-1"
}

variable "secondary_region" {
  description = "Secondary AWS region for production"
  type        = string
  default     = "ap-southeast-2"
}

variable "primary_az" {
  description = "Primary AZ in the primary production region"
  type        = string
  default     = "ap-southeast-1a"
}

variable "secondary_az" {
  description = "Primary AZ in the secondary production region"
  type        = string
  default     = "ap-southeast-2a"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "aws-eks-devops-platform"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}
