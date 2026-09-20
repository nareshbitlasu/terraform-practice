module "test" {
    source = "../Day-6-root"
    vpc_cidr = "10.0.0.0/16"
    subnet_cidr = "10.0.1.0/24"
    ec2_ami = "ami-0fef201115eefe936"
    instance_type = "t3.micro"
    vpc_name = "test-vpc"
    subnet_name = "test-subnet"
    instance_name = "test-instance"
}
module "s3_bucket_for_logs" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket-for-logs-111111111111111"

  # Allow deletion of non-empty bucket
  force_destroy = true

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  attach_lb_log_delivery_policy = true # Required for ALB/NLB logs
}
output "vpc_id" {
  value = module.test.vpc_id
}
