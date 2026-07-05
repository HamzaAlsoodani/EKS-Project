module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = "1.31"

  cluster_endpoint_public_access       = true //for testing purposes only
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  enable_irsa = true # enable IAM Roles for Service Accounts (IRSA) so pods can borrow AWS roles

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets

  eks_managed_node_group_defaults = {

    disk_size      = 50
    instance_types = ["t3a.large", "t3.large"]

  }

  eks_managed_node_groups = {
    default = {
      # create default node group with default settings
    }
  }

}
