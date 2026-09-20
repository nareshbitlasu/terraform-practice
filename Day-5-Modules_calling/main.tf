module "env_test" {
  source = "../Day-5-Modules"
  vpc_cidr = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
  ec2_ami = "ami-0bd3fbcdc633a1b1a"
}
