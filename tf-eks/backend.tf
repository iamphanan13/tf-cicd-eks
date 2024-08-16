terraform {
  backend "s3" {
    bucket = "my-eks-bucket-001"
    key = "eks/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}