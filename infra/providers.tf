
terraform {
  required_version = ">= 1.5"
  required_providers {
    aws        = { source = "hashicorp/aws", version = "~> 5.0" }
    helm       = { source = "hashicorp/helm", version = "~> 2.0" }
    kubernetes = { source = "hashicorp/kubernetes", version = "~> 2.0" }
  }

  backend "s3" {
    bucket         = "eks-2048-tfstate-076056288980"
    key            = "infra/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "eks-2048-tflock"
    encrypt        = true
  }

}





