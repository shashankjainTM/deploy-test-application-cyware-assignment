terraform {
  backend "s3" {
    bucket         = "terraform-assignment-state"
    key            = "cyware-assignment/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform_lock"
    encrypt        = true
  }
}