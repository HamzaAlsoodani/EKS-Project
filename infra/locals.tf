# Shared values used across the config, defined once here so we don't repeat them.
locals {
  region       = "eu-west-2"
  cluster_name = "eks-2048"
  domain       = "hamza-alsoodani.com"
  zone_id      = "Z09462481WSUBXYSKQHGQ"
  zone_arn     = "arn:aws:route53:::hostedzone/Z09462481WSUBXYSKQHGQ"
}
