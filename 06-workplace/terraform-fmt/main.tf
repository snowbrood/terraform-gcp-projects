variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "cidr_block" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "Subnet CIDR block"
  default     = "10.0.1.0/24"
}

variable "environment" {
  description = "Deployment environment"
  default     = "prod"
}

variable "allowed_ssh_cidr_blocks" {
  description = "List of CIDR blocks allowed to SSH"
  type        = list(string)
  default     = ["10.0.0.0/8"]
}

provider "aws" {
  region  = var.aws_region
  profile = var.environment
}

locals {
  common_tags = {
    Environment = var.environment
  }
}

resource "aws_vpc" "example" {
  cidr_block = var.cidr_block
  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-vpc"
    },
  )
}

resource "aws_security_group" "example" {
  name        = "${var.environment}-sg"
  description = "Example security group"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr_blocks
  }

  tags = local.common_tags
}

resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.example.id
  cidr_block = var.subnet_cidr_block
  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-subnet"
    },
  )
}
