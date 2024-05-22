# backend.tf

terraform {
  backend "s3" {
    bucket = "jenkins-app-bucket-v2"
    key = "jenkins/terraform.tfstate"
    region = "ap-southeast-1"
  }
}