# Build the network
module "vpc" {
  source = "./modules/vpc"

  name            = "${local.cluster_name}-vpc"
  cidr            = "10.0.0.0/16"
  azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  cluster_name    = local.cluster_name
}
