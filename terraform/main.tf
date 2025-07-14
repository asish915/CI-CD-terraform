provider "aws" {
  region = "ap-south-1"
}

module "codestar" {
  source          = "./modules/codestar"
  connection_name = "asish-github-connection"
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "asish-codepipeline-bucket"
}

module "iam" {
  source = "./modules/iam"
}

module "codebuild" {
  source             = "./modules/codebuild"
  project_name       = "asish-codebuild-project"
  service_role_arn   = "arn:aws:iam::ACCOUNT_ID:role/CodeBuildServiceRole"
  repo_url           = "https://github.com/asish915/devops-demo.git"
}

module "codepipeline" {
  source              = "./modules/codepipeline"
  pipeline_name       = "asish-codepipeline"
  role_arn            = "arn:aws:iam::ACCOUNT_ID:role/CodePipelineRole"
  bucket_name         = module.s3.bucket_name
  connection_arn      = "arn:aws:codestar-connections:REGION:ACCOUNT_ID:connection/UUID"
  repo                = "asish915/devops-demo"
  branch              = "main"
  build_project_name  = module.codebuild.project_name
}