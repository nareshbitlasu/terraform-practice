variable "tag" {
    default = ["dev", "test"]
    type = list(string)
  
}
resource "aws_instance" "name" {
    ami = "ami-77ug78t7g7t0785"
    instance_type = "t2.micro"
    count = length(var.tag)
    tags = {
        Name = var.tag[count.index]
    }

}