module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"
  cluster_name = "eks-cluster"
  cluster_version = "1.29"


  cluster_endpoint_public_access = true
  
  vpc_id = module.eks-vpc.vpc_id
  subnet_ids = module.eks-vpc.private_subnets


  tags = {
    environment = "developement",
    application = "my-app"
  }

  eks_managed_node_groups = {
    dev = {
        min_size = 1
        max_size = 4
        desired_size = 2

        instance_type = ["t2.small"]
    }
  }
}

resource "aws_kms_alias" "eks_cluster_alias" {
  name          = "alias/eks/eks-cluster"
  target_key_id = aws_kms_key.eks_cluster_key.id
}