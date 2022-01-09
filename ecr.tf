resource "aws_ecr_repository" "github_actions" {
  name                 = "github_actions"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}