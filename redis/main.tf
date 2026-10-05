resource "aws_vpc" "rds_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "rds_vpc"
    }
}
resource "aws_subnet" "rds_subnet" {
    vpc_id = aws_vpc.rds_vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "rds_subnet"
    }
}
variable "data" {
    type = map(string)
    default = {
        22 = "0.0.0.0/0"
        80 = "172.81.5.1/24"
    }
}
resource "aws_security_group" "rds_sg" {
    vpc_id = aws_vpc.rds_vpc.id
    name = "rds-sg"
    description = "allow inbound traffic"
    dynamic  ingress {
        for_each = var.data
        content {
        from_port = ingress.key
        to_port = ingress.key
        protocol = "tcp"
        cidr_blocks = [ingress.value]
        }
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_db_subnet_group" "rds_subgrp" {
    name = "test-rds-subgrp"
    subnet_ids = ["10.0.1.0/24", "10.0.2.0/24"]
    tags = {
        Name = "rds_subgrp"
    }
}

resource "aws_db_instance" "db_instance" {
    identifier = "test-rds-instance"
    allocated_storage = 20
    engine = "mysql"
    engine_version = "8.0"
    instance_class = ""
    multi_az = false
    db_name = "test_db"
    username = "admin"
    password = "password"
    skip_final_snapshot = true
    vpc_security_group_ids = [aws_security_group.rds_sg.id]
    publicly_accessible = true
    backup_retention_period = 7
    db_subnet_group_name = aws_db_subnet_group.rds_db_subgrp.name
    tags = {
        Name= "test-rds"
    }
}

resource "aws_db_read_replica" "rds_rr" {
    identifier = "rr_test"
    source_db_instance_identifier = "aws_db_instance.db_instance.id"

}
resource "aws_db_read_replica" "rds_rr2" {
    identifier = "rr_test2"
    source_db_instance_identifier = "aws_db_instance.db_instance.id"

}