resource "google_artifact_registry_repository" "app_engine_tmp" {
  repository_id = "app-engine-tmp"
  format        = "DOCKER"
  location      = var.region
  project       = var.project_id
}
