resource "aws_codepipeline" "pipeline" {
  name     = var.pipeline_name
  role_arn = var.role_arn

  artifact_store {
    location = var.bucket_name
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn     = var.connection_arn
        FullRepositoryId  = var.repo
        BranchName        = var.branch
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = var.build_project_name
      }
    }
  }
}