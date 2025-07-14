resource "aws_codebuild_project" "build" {
  name          = var.project_name
  description   = "Build Docker image"
  service_role  = var.service_role_arn
  source {
    type      = "GITHUB"
    location  = var.repo_url
    buildspec = "buildspec.yml"
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }
}