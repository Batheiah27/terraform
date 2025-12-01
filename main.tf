terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Create VPC
resource "aws_vpc" "one" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terraform-vpc"
  }
}

# Create Subnet (must be smaller CIDR)
resource "aws_subnet" "two" {
  vpc_id            = aws_vpc.one.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true   # Auto-assign public IP

  tags = {
    Name = "terraform-subnet"
  }
}

# Create EC2 Instance
resource "aws_instance" "three" {
  ami           = "ami-0341d95f75f311023"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.two.id

  tags = {
    Name = "terraform-server"
  }
}
