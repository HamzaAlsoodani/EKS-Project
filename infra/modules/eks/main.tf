
module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version


  cluster_endpoint_public_access = true


  enable_cluster_creator_admin_permissions = true


  cluster_addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }


  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets


  eks_managed_node_groups = {
    default = {
      instance_types = var.instance_types 
      min_size       = var.min_size       
      max_size       = var.max_size       
      desired_size   = var.desired_size
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
