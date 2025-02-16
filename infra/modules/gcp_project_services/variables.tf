variable "project_id" {}
variable "region" {}
variable "services" {
  description = "List of GCP services to enable"
  type        = list(string)
  default = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "cloudbuild.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudfunctions.googleapis.com",
  ]
}
