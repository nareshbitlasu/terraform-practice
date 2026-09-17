terraform {
  backend "s3" {
    bucket = "terraformstatefilesbucket56354354288888"
    key = "Day-4/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
}
}