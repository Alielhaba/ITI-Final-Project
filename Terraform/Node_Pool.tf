resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
}


resource "google_container_node_pool" "node_1" {
  name       = "node-1"
  cluster    = google_container_cluster.main-cluster.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = var.M-type-Node
    
    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

