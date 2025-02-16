output "storage_bucket_fun_bucket_name" {
  value = google_storage_bucket.fun_bucket.name
}

output "storage_bucket_object_srccode_name" {
  value = google_storage_bucket_object.srccode.name
}
