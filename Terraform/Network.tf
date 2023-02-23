resource "google_compute_network" "vpc" {
  name                            = "main-vpc"
  project                         = var.project-id
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = false
}


resource "google_compute_subnetwork" "management_subnet" {
  name                     = "management-subnet"
  ip_cidr_range            = "10.1.1.0/24"
  region                   = var.Region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true

}

resource "google_compute_subnetwork" "restricted_subnet" {
  name                     = "restricted-subnet"
  ip_cidr_range            = "10.1.2.0/24"
  region                   = var.Region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "cluster-range"
    ip_cidr_range = "10.1.12.0/24"
  }
  secondary_ip_range {
    range_name    = "service-range"
    ip_cidr_range = "20.1.22.0/24"
  }
}


resource "google_compute_router" "Router1" {
  name    = "router1"
  region  = var.Region
  network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "NAT" {
  name   = "nat"
  router = google_compute_router.Router1.name
  region = var.Region

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"

  


}

resource "google_compute_firewall" "allow-http-ssh" {
  name      = "allow-http-ssh"
  network   = google_compute_network.vpc.id
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22","80"]
  }

  source_ranges = ["0.0.0.0/0"]
}
