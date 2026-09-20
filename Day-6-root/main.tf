resource "aws_vpc" "test" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}
resource "aws_subnet" "test-subnet" {
  vpc_id = aws_vpc.test.id
  cidr_block = var.subnet_cidr
  tags = {
    Name = var.subnet_name
  }
}
resource "aws_instance" "test-instance" {
  ami = var.ec2_ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.test-subnet.id
  tags = {
    Name = var.instance_name
  }
}

output "vpc_id" {
  value = aws_vpc.test.id
}