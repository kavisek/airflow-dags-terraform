# Application Service Account
resource "google_service_account" "application_service_account" {
  account_id   = "${var.app}-compute"
  display_name = "${var.app} Service Account"
  project = var.project
}


# IAM Binding
module "projects_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 6.4"

  projects = [var.project]

  bindings = {
    "roles/storage.admin" = [
      "serviceAccount:${google_service_account.application_service_account.email}"
    ]

    "roles/compute.networkAdmin" = [
      "serviceAccount:${google_service_account.application_service_account.email}"
    ]

    "roles/compute.imageUser" = [
      "serviceAccount:${google_service_account.application_service_account.email}"
    ]
  }
}