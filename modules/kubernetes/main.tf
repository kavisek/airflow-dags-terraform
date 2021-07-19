data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project
  name                       = "airflow-cluster"
  regional                   = false
  region                     = var.region
  zones                      = [var.zone]
  network                    = var.network
  subnetwork                 = var.subnet
  ip_range_pods              = "${var.app}-${var.region}-subnet-01-pod-range"
  ip_range_services          = "${var.app}-${var.region}-subnet-01-service-range"
  create_service_account     = false
  remove_default_node_pool   = true
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = false

  node_pools = [
    {
      name                      = "airflow-pool"
      machine_type              = "e2-standard-2"
      node_locations            = var.zone
      min_count                 = 1
      initial_node_count        = 1
      max_count                 = 10
      local_ssd_count           = 0
      disk_size_gb              = 10
      disk_type                 = "pd-standard"
      image_type                = "COS"
      auto_repair               = true
      auto_upgrade              = true
      service_account           = var.service_account
      preemptible               = false
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    airflow-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {
      all-pools-example = true
    }
    airflow-pool = {
      airflow-pool-example = true
    }
  }

  node_pools_taints = {
    all = [
      {
        key    = "all-pools-example"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
    airflow-pool = [
      {
        key    = "airflow-pool-example"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = [
      "all-node-example",
    ]
    airflow-pool = [
      "${var.network}-allow-ssh-rdp",
      "${var.network}-allow-ingress-from-iap",
      "${var.network}-allow-http",
    ]
  }
}