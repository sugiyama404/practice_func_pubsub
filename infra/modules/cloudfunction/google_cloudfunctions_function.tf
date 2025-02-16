resource "google_cloudfunctions_function" "fun_from_tf" {
  name                  = "send-email-function"
  runtime               = "python311"
  entry_point           = "send_email"
  description           = "This is my first function from terraform script."
  available_memory_mb   = 128
  source_archive_bucket = var.storage_bucket_fun_bucket_name
  source_archive_object = var.storage_bucket_object_srccode_name
  service_account_email = var.service_account_email
  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = var.pubsub_topic_email_topic_id
  }
  environment_variables = {
    SMTP_EMAIL      = var.smtp_email
    SMTP_PASSWORD   = var.smtp_password
    RECIPIENT_EMAIL = var.recipient_email
  }
}
