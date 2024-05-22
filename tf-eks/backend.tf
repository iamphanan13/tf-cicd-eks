terraform {
  backend "s3" {
    bucket = "jenkins-app-bucket-v2"
    key = "eks/terraform.tfstate"
    region = "ap-southeast-1"
  }
}