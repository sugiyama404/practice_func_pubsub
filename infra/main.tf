terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

#gcp project services
module "gcp_project_services" {
  source     = "./modules/gcp_project_services"
  project_id = var.project_id
  region     = var.region
}

# IAM
module "iam" {
  source                                 = "./modules/iam"
  project_id                             = var.project_id
  region                                 = var.region
  compute_engine_default_service_account = var.compute_engine_default_service_account
}

# Arifact Registry
module "arifactregistry" {
  source                                 = "./modules/artifactregistry"
  project_id                             = var.project_id
  region                                 = var.region
  compute_engine_default_service_account = var.compute_engine_default_service_account
}

# Cloud Strorage
module "storage" {
  source                = "./modules/storage"
  service_account_email = module.iam.service_account_email
  region                = var.region
  project_number        = var.project_number
  project_id            = var.project_id
}

# Cloud Functions
module "functions" {
  source                             = "./modules/cloudfunction"
  storage_bucket_fun_bucket_name     = module.storage.storage_bucket_fun_bucket_name
  storage_bucket_object_srccode_name = module.storage.storage_bucket_object_srccode_name
  service_account_email              = module.iam.service_account_email
  pubsub_topic_email_topic_id        = module.pubsub.pubsub_topic_email_topic_id
  project_id                         = var.project_id
  smtp_email                         = var.smtp_email
  smtp_password                      = var.smtp_password
  recipient_email                    = var.recipient_email
}

# Pub/Sub
module "pubsub" {
  source = "./modules/pubsub"
}
