
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

variable "control_plane_subnets" {
  description = "Subnet IDs for the cluster's control plane network interfaces"
  type        = list(string)
  default     = []
}


variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions"
  type        = any
  default = {
    default = {
      min_size     = 2
      max_size     = 4
      desired_size = 2
    }
  }
}

# Applied to every node group above.
variable "node_group_defaults" {
  description = "Defaults applied to every managed node group"
  type        = any
  default = {
    instance_types = ["t3a.large", "t3.large"]
    ami_type       = "AL2023_x86_64_STANDARD" # AL2 is not available on 1.33+

    # disk_size is ignored when a custom launch template is used, so set it here
    block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs = {
          volume_size           = 50
          volume_type           = "gp3"
          encrypted             = true
          delete_on_termination = true
        }
      }
    }
  }
}

variable "tags" {
  description = "Extra tags merged into the module's baseline tags"
  type        = map(string)
  default     = {}
}
