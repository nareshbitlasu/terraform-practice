locals {
  bucket = "uiyututjyjy"
  region = "us-east-1"
  env="dev"
}
provider "aws" {
    profile = local.env
}
resource "aws_s3_bucket" "name" {
    bucket = local.bucket
    region = local.region
}
