resource "aws_vpc" "test" {
    cidr_block = "0.0.0.0/16"
    tags = {
        Name = "test-vpc"
    }
}