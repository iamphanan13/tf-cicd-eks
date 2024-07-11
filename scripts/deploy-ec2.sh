#!/bin/sh

# Navigate to Runner Instance
cd .. && cd tf-jenkins
ls -la

# Init Terraform
terraform init --reconfigure

# Check validate Terraform files
terraform validate 

# Plan Terraform
terraform plan --var-file="variables/terraform.tfvars"

# Apply Terraform 
terraform apply --var-file="variables/terraform.tfvars" --auto-approve

