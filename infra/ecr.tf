# Registry for the app image. The build pipeline pushes here on every commit.
resource "aws_ecr_repository" "app" {
  name = "app-2048"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project   = local.cluster_name
    ManagedBy = "terraform"
  }
}
