# create an IGW (Internet Gateway)
# It enables your vpc to connect to the internet
resource "aws_internet_gateway" "marak-tf-igw" {
  vpc_id = aws_vpc.marak-tf-vpc.id

  tags = {
    Name = "marak-tf-igw"
  }
}

# create a custom route table for public subnets
# public subnets can reach to the internet buy using this
resource "aws_route_table" "marak-tf-public-crt" {
  vpc_id = aws_vpc.marak-tf-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.marak-tf-igw.id
  }

  tags = {
    Name = "marak-tf-public-crt"
  }
}

# route table association for the public subnets
resource "aws_route_table_association" "marak-tf-crta-public-subnet-1" {
  subnet_id      = aws_subnet.marak-tf-subnet-public-1.id
  route_table_id = aws_route_table.marak-tf-public-crt.id
}

# security group
resource "aws_security_group" "ssh-allowed" {

  vpc_id = aws_vpc.marak-tf-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["183.82.117.42/32"]
  }

  //If you do not add this rule, you can not reach the NGIX
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-allowed"
  }
}
