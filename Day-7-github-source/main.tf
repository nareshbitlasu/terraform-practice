module "name" {
    source = "github.com/nareshbitlasu/terraform-practice//Day-6-root"
    vpc_cidr = "10.0.0.0/16"
    subnet_cidr = "10.0.1.0/24"
    ec2_ami = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
}