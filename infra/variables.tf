variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "project_number" {
  description = "The project number"
  type        = string
}

variable "repository_name" {
  description = "The repository name"
  type        = string
  default     = "my-repository"
}

variable "image_name" {
  description = "The image name"
  type        = string
  default     = "myimage"
}

variable "compute_engine_default_service_account" {
  description = "Compute Engine default service account"
  type        = string
}

variable "region" {
  description = "GCP region to create resources in"
  type        = string
  default     = "asia-northeast1"
}

variable "upper_region" {
  description = "GCP region to create resources in"
  type        = string
  default     = "ASIA-NORTHEAST1"
}

variable "zone" {
  description = "GCP zone to create resources in"
  type        = string
  default     = "asia-northeast1-a"
}

variable "smtp_email" {
  description = "The SMTP email"
  type        = string
}
variable "smtp_password" {
  description = "The SMTP password"
  type        = string
}
variable "recipient_email" {
  description = "The recipient email"
  type        = string
}
