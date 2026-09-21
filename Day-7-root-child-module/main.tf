module "module_1" {
    source = "./modules/network"
    cidr_block = "10.0.0.0/16"
    subnet_cidr = "10.0.1.0/24"
}
module "module_2" {
    source = "./modules/compute"
    ami = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    subnet_id = module.module_1.subnet_id
}