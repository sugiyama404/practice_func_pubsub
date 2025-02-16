resource "google_storage_bucket_iam_member" "storage_object_viewer" {
  bucket = google_storage_bucket.fun_bucket.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${var.service_account_email}"
}
