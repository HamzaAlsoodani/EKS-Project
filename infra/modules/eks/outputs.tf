# ─────────────────────────────────────────────────────────────────────────────


output "cluster_name" {
  description = "The cluster's name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Web address of the cluster's API (kubectl connects here)"
  value       = module.eks.cluster_endpoint
}


output "oidc_provider_arn" {
  description = "OIDC provider ARN, used later to give specific pods scoped AWS access"
  value       = module.eks.oidc_provider_arn
}

output "cluster_security_group_id" {
  description = "The firewall (security group) ID controlling traffic to the cluster"
  value       = module.eks.cluster_security_group_id
}

output "cluster_certificate_authority_data" {
  description = "Base64 CA cert used to securely connect to the cluster API"
  value       = module.eks.cluster_certificate_authority_data
}
