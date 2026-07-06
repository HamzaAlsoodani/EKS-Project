# ─────────────────────────────────────────────────────────────────────────────
# Input slots for this module. The root eks.tf fills these in when it calls us.
# ─────────────────────────────────────────────────────────────────────────────

variable "cluster_name" {
  description = "Name for the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version to run"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC (network) to build the cluster in"
  type        = string
}

variable "private_subnets" {
  description = "Private subnet IDs where worker nodes will run"
  type        = list(string)
}

# Managed node groups in the community module's format. "any" lets you pass a
# flexible nested map (instance_types, disk_size, min/max/desired_size, etc.).
variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions"
  type        = any
  default = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
  }
}
