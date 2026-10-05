variable "allowed_ports" {
    type = map(string)
    default = {
        22 = "203.0.113.0/24"
        80 = "0.0.0.0/0"
        443 = "0.0.0.0/0"
        8080 = "10.0.0.0/16"
        9090 = "192.168.1.0/24"
        3389 = "10.0.1.0/24"
    }
}

resource "aws_security_group" "devops-project" {
    name = "devops-project"
    description = "allow restricted inbound traffic"
    dynamic "ingress" {
        for_each = var.allowed_ports
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
    tags = {
        Name = "devops-project"
    }
}