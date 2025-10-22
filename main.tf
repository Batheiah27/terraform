provider "aws" {
region = "us-east-1"
}
resource "aws_vpc" "one" {
cidr_block = "10.0.0.0/16"
tags = {
Name = "terraform-vpc"
}
}
resorce "aws_subnet" "two" {
cidr_block = "10.0.0.0/16"
vpc_id = aws_vpc.one.id
availability_zone = "us-east-1b" 
tags = {
Name = "terraform-subnet"
}
}

resource "aws_instance" "three" {
ami = "ami-0341d95f75f311023"
instance_type = "t2.micro"
subnet_id = aws_subnet.two.id
tags = {
Name = "terraform-server"
}
}

