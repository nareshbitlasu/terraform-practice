resource "aws_vpc" "name" {
  cidr_block = var.cidr_block
}
resource "aws_subnet" "name" {
  vpc_id = aws_vpc.name.id
  cidr_block = var.subnet_cidr
}
output "subnet_id" {
  value = aws_subnet.name.id
}