# GitHub Actions OIDC: lets workflows in THIS repo assume an IAM role using
# short-lived tokens, with no static access keys stored in GitHub.

# OIDC identity provider for GitHub Actions
resource "aws_iam_openid_connect_provider" "github_actions" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1b511abead59c6cee45d44c9f3d8aa3b5ed9f5a3"
  ]
}

# Role that the workflows assume
resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Federated = aws_iam_openid_connect_provider.github_actions.arn }
        Action    = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            # YOUR repo. Tighten to ":ref:refs/heads/main" to allow main only.
            "token.actions.githubusercontent.com:sub" = "repo:HamzaAlsoodani/EKS-Project:*"
          }
        }
      }
    ]
  })

  tags = {
    Project   = local.cluster_name
    ManagedBy = "terraform"
  }
}

# ECR push permissions (for the build-push pipeline)
resource "aws_iam_role_policy" "ecr_push_policy" {
  name = "ecr-push-policy"
  role = aws_iam_role.github_actions_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ecr:GetAuthorizationToken"]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ]
        Resource = "arn:aws:ecr:${local.region}:076056288980:repository/app-2048"
      }
    ]
  })
}

# Terraform remote state backend: S3 state + DynamoDB lock
resource "aws_iam_role_policy" "backend_policy" {
  name = "terraform-backend-policy"
  role = aws_iam_role.github_actions_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
        Resource = "arn:aws:s3:::eks-2048-tfstate-076056288980/infra/terraform.tfstate"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = "arn:aws:s3:::eks-2048-tfstate-076056288980"
      },
      {
        # REQUIRED for state locking (the template was missing this)
        Effect   = "Allow"
        Action   = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem"]
        Resource = "arn:aws:dynamodb:${local.region}:076056288980:table/eks-2048-tflock"
      }
    ]
  })
}

# Terraform infrastructure management (broad service-level access)
resource "aws_iam_role_policy" "terraform_infra_policy" {
  name = "terraform-infra-policy"
  role = aws_iam_role.github_actions_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Effect = "Allow", Action = "ec2:*", Resource = "*" },
      { Effect = "Allow", Action = "eks:*", Resource = "*" },
      { Effect = "Allow", Action = "iam:*", Resource = "*" },
      { Effect = "Allow", Action = "logs:*", Resource = "*" },
      { Effect = "Allow", Action = "autoscaling:*", Resource = "*" },
      { Effect = "Allow", Action = "route53:*", Resource = "*" },
      { Effect = "Allow", Action = "kms:*", Resource = "*" },
      { Effect = "Allow", Action = "elasticloadbalancing:*", Resource = "*" }
    ]
  })
}

output "github_actions_role_arn" {
  description = "Set this as the AWS_ROLE_ARN repo variable in GitHub"
  value       = aws_iam_role.github_actions_role.arn
}
