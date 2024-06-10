# backend.tf

terraform {
  backend "s3" {
    bucket = "my-eks-bucket-001"
    key = "jenkins/terraform.tfstate"
    region = "ap-southeast-1"
  }
}