
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
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


  # Node groups are defined at the root and passed straight through to the
  # community module, so you can use its full format (instance_types, disk_size, scaling…).
  eks_managed_node_groups = var.eks_managed_node_groups

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
