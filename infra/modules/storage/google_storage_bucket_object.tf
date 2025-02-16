resource "google_storage_bucket_object" "srccode" {
  name   = "index.zip"
  bucket = google_storage_bucket.fun_bucket.name
  source = "./modules/storage/src/out/index.zip"
}

data "archive_file" "function_got_archive" {
  type        = "zip"
  source_dir  = "./modules/storage/src/in/index"
  output_path = "./modules/storage/src/out/index.zip"
}

