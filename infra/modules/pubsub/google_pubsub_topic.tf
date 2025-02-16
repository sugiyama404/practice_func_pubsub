resource "google_pubsub_topic" "email_topic" {
  name    = "email-topic"
  project = var.project_id
}
