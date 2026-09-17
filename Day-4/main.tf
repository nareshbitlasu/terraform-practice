resource "aws_vpc" "vpc_variable" {
  cidr_block =var.vpc_cidr
  tags = {
    Name = "project-vpc"
  }
}
resource "aws_subnet" "subnet_variable" {
  vpc_id     = aws_vpc.vpc_variable.id
  cidr_block = var.subnet_cidr
  tags = {
    Name = "project-subnet"  
  }
}
resource "aws_subnet" "subnet_variable_private" {
  vpc_id     = aws_vpc.vpc_variable.id
  cidr_block = var.subnet_cidr1
  tags = {
    Name = "project-subnet-private"
  }
}
resource "aws_security_group" "sg_variable" {
  name        = "project-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.vpc_variable.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "igw_variable" {
  vpc_id = aws_vpc.vpc_variable.id
  tags = {
    Name = "project-igw"
  }
}
resource "aws_route_table" "rt_variable" {
  vpc_id = aws_vpc.vpc_variable.id
  tags = {
    Name = "project-rt"
  }
}
resource "aws_route_table_association" "rt_assoc_variable" {
  subnet_id      = aws_subnet.subnet_variable.id
  route_table_id = aws_route_table.rt_variable.id
}
resource "aws_route" "route_variable" {
  route_table_id         = aws_route_table.rt_variable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_variable.id
}
resource "aws_nat_gateway" "nat_variable" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet_variable_private.id
  tags = {
    Name = "project-nat"
  }
}
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "project-nat-eip"
  }
}

resource "aws_route_table" "private_rt_variable" {
  vpc_id = aws_vpc.vpc_variable.id
  tags = {
    Name = "project-private-rt"
  }
}
# resource "aws_route" "private_route_variable" {
#     route_table_id         = aws_route_table.private_rt_variable.id
#     destination_cidr_block = "0.0.0.0/0"
#     nat_gateway_id         = aws_nat_gateway.nat_variable.id
# }
resource "aws_route_table_association" "private_rt_assoc_variable" {
  subnet_id      = aws_subnet.subnet_variable_private.id
  route_table_id = aws_route_table.private_rt_variable.id
}
resource "aws_route" "private_route_variable" {
  route_table_id         = aws_route_table.private_rt_variable.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_variable.id
}
resource "aws_instance" "ec2_variable" {
  ami                    = "ami-0e34b50e714a297f1"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.subnet_variable.id
  vpc_security_group_ids = [aws_security_group.sg_variable.id]
  tags = {
    Name = "project-ec2"
  }
}

