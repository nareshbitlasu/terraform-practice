resource "aws_vpc" "new_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "project-vpc"
  }  
}
resource "aws_subnet" "new_subnet" {
  vpc_id     = aws_vpc.new_vpc.id
  cidr_block = var.subnet_cidr
  tags = {
    Name = "project-subnet"
  }
}
resource "aws_instance" "new_ec2" {
  ami           = var.ec2_ami
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.new_subnet.id
  tags = {
    Name = "project-ec2"
  }
}