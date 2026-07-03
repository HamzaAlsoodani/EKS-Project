variable "name" {
  description = "Name prefix for the VPC and its resources"
  type        = string
}

variable "cidr" {
  description = "CIDR block for the VPC (e.g. 10.0.0.0/16)"
  type        = string
}

variable "azs" {
  description = "Availability zones to spread subnets across"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets (worker nodes)"
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets (load balancers)"
  type        = list(string)
}

variable "cluster_name" {
  description = "EKS cluster name, used for subnet discovery tags"
  type        = string
}
