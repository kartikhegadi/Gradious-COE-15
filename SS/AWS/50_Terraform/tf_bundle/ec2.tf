resource "aws_instance" "marak-tf-web1" {

  ami           = "ami-077333cd242106499"
  instance_type = "t2.micro"

  # VPC
  subnet_id = aws_subnet.marak-tf-subnet-public-1.id

  # Security Group
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

  # the Public SSH key
  key_name = "marak-nv"

}
