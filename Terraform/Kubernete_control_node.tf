resource "google_container_cluster" "main-cluster" {
  name                     = "main-cluster"
  location                 = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.vpc.id
  subnetwork               = google_compute_subnetwork.restricted_subnet.id
  networking_mode          = "VPC_NATIVE"
  
  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
    
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "ali-elhabal-378620.svc.id.goog"
  }
  ip_allocation_policy {
    cluster_secondary_range_name  = "cluster-range"
    services_secondary_range_name = "service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
    
  }
  master_authorized_networks_config {
  cidr_blocks {
    cidr_block = google_compute_subnetwork.management_subnet.ip_cidr_range
    display_name = "my-cidr"
  }
}
}