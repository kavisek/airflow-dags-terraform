# Creating a unique VPC per environment.

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 3.0"

  project_id   = var.project
  network_name = "${var.env}-${var.app}-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "${var.env}-${var.app}-${var.region}-subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = var.region
    },
    {
      subnet_name           = "${var.env}-${var.app}-${var.region}-subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "[subnet description]"
    },
    {
      subnet_name               = "${var.env}-${var.app}-${var.region}-subnet-03"
      subnet_ip                 = "10.10.30.0/24"
      subnet_region             = var.region
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.7
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    }
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "${var.env}-${var.app}-${var.region}-subnet-01-secondary-01"
        ip_cidr_range = "192.168.64.0/24"
      },
    ]

    subnet-02 = []
  }

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]
}

# This is a private VPN connection between our VPC and GCP managed service provider.
resource "google_compute_global_address" "private_ip_alloc" {
  name          = "private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "${var.env}-${var.app}-vpc"
}

resource "google_service_networking_connection" "foobar" {
  network                 = "${var.env}-${var.app}-vpc"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}
