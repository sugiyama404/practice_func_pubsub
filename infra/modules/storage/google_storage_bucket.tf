resource "google_storage_bucket" "fun_bucket" {
  name          = "fun-bucket-tf-${random_string.storage_unique_key.result}"
  location      = var.region
  force_destroy = true
}

resource "random_string" "storage_unique_key" {
  length  = 10
  upper   = false
  lower   = true
  numeric = true
  special = false
}
