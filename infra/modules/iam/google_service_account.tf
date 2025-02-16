# サービスアカウントの作成
resource "google_service_account" "main" {
  account_id   = "terraform-service-account"
  display_name = "Service Account Main"

  lifecycle {
    ignore_changes = [account_id]
  }
}
