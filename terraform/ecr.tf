# ECR Repository (already created, but Terraform will manage it too)
resource "aws_ecr_repository" "app" {
  name = "static-site"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = false
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}

