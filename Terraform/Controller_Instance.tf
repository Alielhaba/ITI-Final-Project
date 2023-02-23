resource "google_compute_instance" "gke_controller" {
  name         = "controler"
  machine_type = var.M-type-VM
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.management_subnet.id
  }

}



