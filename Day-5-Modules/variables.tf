variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = ""
}
variable "subnet_cidr" {
    description = "The CIDR block for the subnet"
    type        = string
    default     = ""
}
variable "ec2_ami" {
    description = "The AMI ID for the EC2 instance"
    type        = string
    default     = ""
}