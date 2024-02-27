resource "aws_vpc" "marak-tf-vpc" {
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  instance_tenancy     = "default"

  tags = {
    Name = "marak-tf-vpc"
  }
}

resource "aws_subnet" "marak-tf-subnet-public-1" {
  vpc_id                  = aws_vpc.marak-tf-vpc.id
  cidr_block              = "10.2.1.0/24"
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = "us-east-1a"

  tags = {
    Name = "marak-tf-subnet-public-1"
  }
}
