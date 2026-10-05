variable "tag" {
  default = ["dev", "test"]
  type = list(string)
}
resource "aws_instance" "name" {
    ami = "ami-886cjuffg789r623rr6"
    instance_type = "t2.micro"
    for_each = toset(var.tag)
    tags = {
        Name = each.key
    }
}