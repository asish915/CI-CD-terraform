output "pipeline_url" {
  description = "CodePipeline Console URL"
  value       = "https://console.aws.amazon.com/codesuite/codepipeline/pipelines/${module.codepipeline.pipeline_name}/view"
}