#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        // Jenkins will use the credentials added earlier
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "ap-southeast-1"
    }
    stages {
        // Stage 1
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('tf-eks') {
                        // Jenkins will run these commands for us
                        sh "terraform init"
                        sh "terraform validate"
                        sh "terraform apply --var-file=\"variables/terraform.tfvars\" -auto-approve"
                    }
                }
            }
        }
        // Stage 2
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        // Update packages inside the cluster
                        sh "aws eks update-kubeconfig --name eks-cluster"
                        // Deploy an application
                        sh "kubectl apply -f nginx-deployment.yaml"
                        // Deploy a service
                        sh "kubectl apply -f nginx-service.yaml"
                    }
                }
            }
        }
    }
}