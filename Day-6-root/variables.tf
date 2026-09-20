variable "vpc_cidr" {
  default     = ""  
  description = "The CIDR block for the VPC"
  type        = string
}   
variable "subnet_cidr" {
  default     = ""  
  description = "The CIDR block for the Subnet"
  type        = string
}
variable "ec2_ami" {
  default     = ""  
  description = "The AMI ID for the EC2 instance"
  type        = string
}