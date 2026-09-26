provider "aws" {
    region = "us-east-1"
}
resource "aws_db_instance" "mysql_rds" {
    identifier = "my-mysql-db"
    engine = "mysql"
    instance_class = "db.t3.micro"
    username = "admin"
    password = "Password123!"
    db_name = "dev"
    allocated_storage = 20
    skip_final_snapshot = true
    publicly_accessible = true
}
resource "aws_instance" "sql_runner" {
    ami = "ami-0fef201115eefe936"
    instance_type = "t3.micro"
    key_name = "my-key"
    associate_public_ip_address = true
    tags = {
        Name = "SQl Runner"
    }
}

resource "null_resource" "remote_exec" {
    depends_on = [aws_db_instance.mysql_rds, aws_instance.sql_runner]
    connection {
        type= "ssh"
        user= "ec2-user"
        private_key = file("../../my-key.pem")
        host = aws_instance.sql_runner.public_ip
    }
    provisioner "file" {
        source = "init.sql"
        destination = "/tmp/init.sql"
    }

    provisioner "remote-exec" {
        inline = [ 
            "sudo yum install mariadb105-server -y",
            "mysql --version",
            "mysql -h ${aws_db_instance.mysql_rds.address} -u admin -pPassword123! dev < init.sql"
        ]
    }

    triggers = {
      sql_file = filemd5("init.sql")
    }

}
