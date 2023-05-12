provider "aws" {
  region = "us-west-2"
}

locals {
  environment = "prod"
}


resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${local.environment}-example"
  }
}

resource "aws_security_group" "example" {
  description = "Example security group"
  name        = "example"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "${local.environment}-example"
  }
}
