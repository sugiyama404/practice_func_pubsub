resource "google_cloudfunctions_function_iam_member" "allowaccess" {
  region         = google_cloudfunctions_function.fun_from_tf.region
  cloud_function = google_cloudfunctions_function.fun_from_tf.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
