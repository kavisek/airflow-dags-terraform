
locals {
  admin_enabled_apis = [
    "appengine.googleapis.com",
    "appengineflex.googleapis.com",
    "bigquery.googleapis.com",
    "cloudapis.googleapis.com",
    "cloudbuild.googleapis.com",
    "clouddebugger.googleapis.com",
    "cloudtrace.googleapis.com",
    "compute.googleapis.com",
    "containerregistry.googleapis.com",
    "datastore.googleapis.com",
    "deploymentmanager.googleapis.com",
    "iap.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "oslogin.googleapis.com",
    "pubsub.googleapis.com",
    "secretmanager.googleapis.com",
    "servicemanagement.googleapis.com",
    "servicenetworking.googleapis.com",
    "serviceusage.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "stackdriver.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "storage.googleapis.com",
    "websecurityscanner.googleapis.com",
    "vpcaccess.googleapis.com"
  ]
}

resource "google_project_service" "enabled-apis" {
  for_each = toset(local.admin_enabled_apis)
  service  = each.value
  disable_dependent_services = false
  disable_on_destroy         = true
}