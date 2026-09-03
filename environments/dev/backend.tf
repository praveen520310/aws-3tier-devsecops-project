terraform {
  backend "s3" {
    bucket         = "prav-tf-test-buck"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}