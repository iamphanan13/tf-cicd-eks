module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"
  cluster_name = "eks-cluster"
  cluster_version = "1.28"


  cluster_endpoint_public_access = true
  
  vpc_id = module.eks_vpc.vpc_id
  subnet_ids = module.eks_vpc.private_subnets


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