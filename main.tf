// Configure the Google Cloud provider
provider "google" {
 credentials = file("terraform-gcp.json")
 project     = "shibashis-practice-01"
 region      = "asia-south1"
 zone        = "asia-south1-a"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}


resource "google_compute_instance" "default" {
  name         = "practice-vm"
  machine_type = "n1-standard-2"
  zone         = "asia-south1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "gs://scripts-shibashis-practice-01/initial-installs.sh"

}