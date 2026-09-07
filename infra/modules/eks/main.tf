
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version


  cluster_endpoint_public_access = true # for testing purposes only


  enable_cluster_creator_admin_permissions = true


  enable_irsa = true # enable IAM Roles for Service Accounts (IRSA) so pods can borrow AWS roles


  cluster_addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }


  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets
  control_plane_subnet_ids = var.control_plane_subnets


  # Node groups use the community module's format (instance_types, scaling, etc.)
  eks_managed_node_groups         = var.eks_managed_node_groups
  eks_managed_node_group_defaults = var.node_group_defaults

  tags = merge({
    Environment = "dev"
    Terraform   = "true"
  }, var.tags)
}
