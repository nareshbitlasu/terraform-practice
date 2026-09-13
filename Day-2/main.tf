resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "my-vpc"
    }
}
resource "aws_subnet" "public" {
        vpc_id = aws_vpc.dev.id
        cidr_block = "10.0.0.0/24"
        availability_zone = "us-east-1a"
        map_public_ip_on_launch = true
        tags = {
            Name = "public-subnet-1"
        }
}