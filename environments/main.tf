
provider "google" {
  project = var.project
}

module "api" {
  source  = "../modules/apis"
  project = var.project
}

# module "vpc" {
#   source  = "../modules/vpc"
#   project = var.project
#   env     = var.env
#   app     = var.app
#   region  = var.region
# }

# module "serverless_vpc_access_connectors" {
#   source       = "../modules/serverless_vpc_access_connectors"
#   project      = var.project
#   network_name = module.vpc.network_name
#   region       = var.region
# }

# module "firewall" {
#   source       = "../modules/firewall"
#   project      = var.project
#   network_name = module.vpc.network_name
# }

# module "buckets" {
#   source  = "../modules/buckets"
#   project = var.project
#   env     = var.env
#   app     = var.app
#   region  = var.region

# }

# module "vms" {
#   source  = "../modules/vms"
#   project = var.project
#   env     = var.env
#   subnet  = module.vpc.subnet
#   app     = var.app
#   region  = var.region
#   zone    = var.zone
# }

# module "databases" {
#   source          = "../modules/databases"
#   project         = var.project
#   env             = var.env
#   app             = var.app
#   region          = var.region
#   zone            = var.zone
#   network_name    = module.vpc.network_name
#   db_machine_type = var.db_machine_type
# }


# module "app_engines" {
#   source  = "../modules/app_engines"
#   project = var.project
#   env     = var.env
#   app     = var.app
#   region  = var.region
# }


# module "cloudbuild" {
#   source = "../modules/cloudbuild"
#   env    = var.env
#   app    = var.app
# }

# module "dashboards" {
#   source = "../modules/dashboards"
#   env    = var.env
#   app    = var.app
# }

# module "alerts" {
#   source = "../modules/alerts"
#   env    = var.env
#   app    = var.app
# }

# module "cloud_cdn" {
#   source  = "../modules/cloud_cdn"
#   project = var.project
#   env     = var.env
#   app     = var.app
#   region  = var.region
# }

# module "secrets" {
#   source  = "../modules/secrets"
#   project = var.project
#   env     = var.env
#   app     = var.app
#   region  = var.region
# }
