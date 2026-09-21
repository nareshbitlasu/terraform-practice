provider "aws" {
    region = "us-east-1"
    profile = "dev-env"
    alias = "dev"
}
provider "aws" {
    region = "us-west-2"
    profile = "prod-env"
    alias = "test"
}