resource "google_pubsub_subscription" "email_subscription" {
  name                 = "email-subscription"
  topic                = google_pubsub_topic.email_topic.name
  ack_deadline_seconds = 20
}
