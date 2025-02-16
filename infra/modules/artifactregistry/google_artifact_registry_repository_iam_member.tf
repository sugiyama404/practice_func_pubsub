resource "google_artifact_registry_repository_iam_member" "repo_writer" {
  repository = google_artifact_registry_repository.app_engine_tmp.name
  location   = google_artifact_registry_repository.app_engine_tmp.location
  role       = "roles/artifactregistry.admin"
  member     = "serviceAccount:${var.compute_engine_default_service_account}"
}
