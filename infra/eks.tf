# Build the cluster
module "eks" {
  source = "./modules/eks"

  cluster_name    = local.cluster_name
  cluster_version = "1.36"

  vpc_id                = module.vpc.vpc_id
  private_subnets       = module.vpc.private_subnets
  control_plane_subnets = module.vpc.public_subnets
}
