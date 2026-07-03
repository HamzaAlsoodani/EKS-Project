terraform {
  backend "s3" {
    bucket         = "eks-2048-tfstate-076056288980"
    key            = "infra/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "eks-2048-tflock"
    encrypt        = true
  }
}
