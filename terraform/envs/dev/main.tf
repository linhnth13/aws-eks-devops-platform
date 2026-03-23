provider "aws" {
  region = var.aws_region
}

locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-vpc"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-igw"
  })
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name                                                           = "${var.project_name}-${var.environment}-public-1"
    "kubernetes.io/role/elb"                                       = "1"
    "kubernetes.io/cluster/${var.project_name}-${var.environment}" = "shared"
  })
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name                                                           = "${var.project_name}-${var.environment}-public-2"
    "kubernetes.io/role/elb"                                       = "1"
    "kubernetes.io/cluster/${var.project_name}-${var.environment}" = "shared"
  })
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = "${var.aws_region}a"

  tags = merge(local.common_tags, {
    Name                                                           = "${var.project_name}-${var.environment}-private-1"
    "kubernetes.io/role/internal-elb"                              = "1"
    "kubernetes.io/cluster/${var.project_name}-${var.environment}" = "shared"
  })
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = "${var.aws_region}b"

  tags = merge(local.common_tags, {
    Name                                                           = "${var.project_name}-${var.environment}-private-2"
    "kubernetes.io/role/internal-elb"                              = "1"
    "kubernetes.io/cluster/${var.project_name}-${var.environment}" = "shared"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-public-rt"
  })
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}