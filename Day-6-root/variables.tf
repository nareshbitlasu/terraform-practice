variable "vpc_cidr" {
  default     = ""  
  description = "The CIDR block for the VPC"
  type        = string
}   
variable "vpc_name" {
  default     = ""  
  description = "The name of the VPC"
  type        = string
}
variable "subnet_cidr" {
  default     = ""  
  description = "The CIDR block for the Subnet"
  type        = string
}
variable "subnet_name" {
  default     = ""  
  description = "The name of the Subnet"
  type        = string
}
variable "ec2_ami" {
  default     = ""  
  description = "The AMI ID for the EC2 instance"
  type        = string
}
variable "instance_type" {
  default     = ""  
  description = "The instance type for the EC2 instance"
  type        = string
}
variable "instance_name" {
  default     = ""  
  description = "The name of the EC2 instance"
  type        = string
}