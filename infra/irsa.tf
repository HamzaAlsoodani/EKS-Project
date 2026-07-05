module "external_dns_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks" 
  version = "~> 5.0"                                                                   

  role_name                     = "${local.cluster_name}-external-dns"                   
  attach_external_dns_policy    = true                                                   
  external_dns_hosted_zone_arns = ["arn:aws:route53:::hostedzone/Z09462481WSUBXYSKQHGQ"] 

  oidc_providers = {
    eks = {                                                      
      provider_arn               = module.eks.oidc_provider_arn  
      namespace_service_accounts = ["external-dns:external-dns"] 
    }
  }
}


module "cert_manager_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks" 
  version = "~> 5.0"                                                                   

  role_name                     = "${local.cluster_name}-cert-manager"                   
  attach_cert_manager_policy    = true                                                   
  cert_manager_hosted_zone_arns = ["arn:aws:route53:::hostedzone/Z09462481WSUBXYSKQHGQ"] 

  oidc_providers = {
    eks = {
      provider_arn               = module.eks.oidc_provider_arn  
      namespace_service_accounts = ["cert-manager:cert-manager"] 
    }
  }
}
