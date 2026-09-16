resource "aws_vpc" "vpc_name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_project"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.vpc_name.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id     = aws_vpc.vpc_name.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_internet_gateway" "vpc-ig" {
  vpc_id = aws_vpc.vpc_name.id
  tags = {
    Name = "project-ig"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_name.id
  tags = {
    Name = "public-rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-ig.id
  }
}

resource "aws_route_table" "private-rta" {
  tags = {
    Name = "privat-rt"
  }
  vpc_id = aws_vpc.vpc_name.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.project-nat.id
  }
}

resource "aws_route_table_association" "rt-associa" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.public_rt.id
}



resource "aws_nat_gateway" "nat" {
  tags = {
    Name = "project-nat-gw"
  }
  subnet_id     = aws_subnet.subnet-2.id
  allocation_id = aws_eip.nat.id
  depends_on    = [aws_internet_gateway.vpc-ig]
}

resource "aws_route_table_association" "nat_associate" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.private-rta.id
}


resource "aws_security_group" "sg-1" {
  tags = {
    Name = "project-sg"
  }
  description = "test"
  vpc_id      = aws_vpc.vpc_name.id
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



resource "aws_instance" "ec2_name" {
  tags = {
    Name = "public-instance"
  }
  ami                    = "ami-0413c9aa513b49c44"
  instance_type          = "t3.micro"
  subnet_id                   = aws_subnet.subnet-1.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg-1.id]
}


