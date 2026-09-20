resource "aws_vpc" "test" {
  cidr_block = ""
  tags = {
    Name = ""
  }
}
resource "aws_subnet" "test-subnet" {
  vpc_id = ""
  cidr_block = ""
  tags = {
    Name = ""
  }
}
resource "aws_instance" "test-instance" {
  ami = ""
  instance_type = ""
  subnet_id = ""
  tags = {
    Name = ""
  }
}
