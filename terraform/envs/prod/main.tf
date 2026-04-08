provider "aws" {
  region = var.primary_region
}

provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
}

module "vpc_primary" {
  source = "../../modules/vpc"

  providers = {
    aws = aws
  }

  project_name = var.project_name
  environment  = "${var.environment}-primary"
  vpc_cidr     = "10.10.0.0/16"
  azs          = [var.primary_az]
}

module "vpc_secondary" {
  source = "../../modules/vpc"

  providers = {
    aws = aws.secondary
  }

  project_name = var.project_name
  environment  = "${var.environment}-secondary"
  vpc_cidr     = "10.20.0.0/16"
  azs          = [var.secondary_az]
}
