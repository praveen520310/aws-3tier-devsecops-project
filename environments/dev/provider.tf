provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  alias  = "region_b"
  region = "ap-southeast-1"
}