resource "google_project_iam_member" "cloud_func_sa_user" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/logging.viewer",
    "roles/viewer",
    "roles/artifactregistry.writer",
    "roles/artifactregistry.reader",
    "roles/iam.securityAdmin",
    "roles/pubsub.subscriber"
  ])
  role    = each.key
  project = var.project_id
  member  = "serviceAccount:${var.compute_engine_default_service_account}"
}

resource "google_project_iam_member" "cloud_run_sa_user" {
  for_each = toset([
    "roles/iam.securityAdmin",
    "roles/pubsub.subscriber",
  ])
  role    = each.key
  project = var.project_id
  member  = "serviceAccount:${google_service_account.main.email}"
}
