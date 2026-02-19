provider "aws" {
region = "us-east-1"
}

resource "aws_vpc" "one" {
cidr_block = "10.0.0.0/16"
tags = {
Name = "${terraform.workspace}"
}
}

resource "aws_subnet" "two" {
cidr_block = "10.0.0.0/21"
availability_zone = "us-east-1a"
vpc_id = aws_vpc.one.id
tags = {
Name = "${terraform.workspace}"
}
}

resource "aws_instance" "three" {
ami = "ami-0f3caa1cf4417e51b"
count = var.instance_count
instance_type = "var.instance_type"
tags = {
Name = "${terraform.workspace}"
}
}
