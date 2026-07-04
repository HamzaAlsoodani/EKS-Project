# ─────────────────────────────────────────────────────────────────────────────
# These are the "input slots" for this module — the values it needs to be given.
# Think of them like the blanks in a form. The root main.tf fills them in when it
# calls this module. Declaring them here is what makes the red "var.*" errors go away.
# ─────────────────────────────────────────────────────────────────────────────

variable "cluster_name" {
  description = "Name for the EKS cluster"
  type        = string # a plain piece of text, e.g. "eks-2048"
}

variable "cluster_version" {
  description = "Kubernetes version to run"
  type        = string # text like "1.31"
}

variable "vpc_id" {
  description = "ID of the VPC (network) to build the cluster in"
  type        = string # comes from the vpc module's output
}

variable "private_subnets" {
  description = "Private subnet IDs where worker nodes (servers) will run"
  type        = list(string) 
}

variable "instance_types" {
  description = "EC2 server size for each worker node"
  type        = list(string)
  default     = ["t3.medium"] 
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number #
  default     = 1
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "desired_size" {
  description = "How many worker nodes to run right now"
  type        = number
  default     = 2
}
