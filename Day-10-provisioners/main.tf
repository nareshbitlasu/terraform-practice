resource "aws_key_pair" "key" {
    key_name = "task"
    public_key = file("../../Users/91970/.ssh/id_ed25519.pub")  
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "myvpc"
    }
}

resource "aws_subnet" "mysubnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone="us-east-1a"
   map_public_ip_on_launch = true
   tags = {
    Name = "publicsubnet"
   }
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
 } 

resource "aws_route_table" "route" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_security_group" "sg" {
    vpc_id= aws_vpc.myvpc.id
    name="mysg"
    ingress {
        description = "test"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "test1"
        from_port = 22
        to_port=22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_instance" "server" {
    ami = "ami-0b6d9d3d33ba97d99"       
    instance_type = "t3.micro"
    key_name = aws_key_pair.key.key_name
    subnet_id = aws_subnet.mysubnet.id
    vpc_security_group_ids = [aws_security_group.sg.id] 
    associate_public_ip_address = true
    tags = {
        Name = "server"
    }
}

resource "null_resource" "file" {
    provisioner "file" {
        connection {
            host =  aws_instance.server.public_ip
            user = "ubuntu"
            private_key = file("../../Users/91970/.ssh/id_ed25519")
        }
        source = "script.sh"
        destination = "/tmp/script.sh"
    }
}

resource "null_resource" "run_script" {
    provisioner "remote-exec" {
        connection {
            host = aws_instance.server.public_ip
            user = "ubuntu"
            private_key = file("../../Users/91970/.ssh/id_ed25519")
        }
        inline = [
            "chmod +x /tmp/script.sh",
            "sudo /tmp/script.sh"
        ]
    }
    depends_on = [null_resource.file]
    # triggers = {
    #     always_run = "${timestamp()}"
    # }
    triggers = {
        script_hash = filemd5("script.sh")
    }

}

