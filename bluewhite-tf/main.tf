provider "google" {
  project = var.google_project_id
  region  = var.google_region
}

resource "google_service_account" "default" {
  account_id   = var.gke_service_account_id
  display_name = var.gke_service_account_display_name
}

resource "google_container_cluster" "primary" {
  name               = var.gke_cluster_name
  location           = var.google_region
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "schedulable_nodes" {
  name       = "schedulable-node-pool"
  location   = var.google_region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_schedulable_node_count

  node_config {
    preemptible      = true
    machine_type     = var.gke_node_machine_type
    service_account  = google_service_account.default.email
    oauth_scopes     = ["https://www.googleapis.com/auth/cloud-platform"]
    labels           = {
      "schedulable-node" = "true"
    }
    disk_size_gb = 10
    disk_type    = "pd-standard"
  }
}

resource "google_container_node_pool" "non_schedulable_nodes" {
  name       = "non-schedulable-node-pool"
  location   = var.google_region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_unschedulable_node_count

  node_config {
    preemptible      = true
    machine_type     = var.gke_node_machine_type
    service_account  = google_service_account.default.email
    oauth_scopes     = ["https://www.googleapis.com/auth/cloud-platform"]
    labels           = {
      "schedulable-node" = "false"
    }
    disk_size_gb = 10
    disk_type    = "pd-standard"
  }
}

resource "null_resource" "kubectl_config" {
  provisioner "local-exec" {
    command = "(gcloud container clusters get-credentials ${var.gke_cluster_name} --region ${var.google_region} --project ${var.google_project_id} && kubectl config view --raw) > ~/.kube/config"
    interpreter = ["/bin/bash", "-c"]
  }
}

provider "helm" {
  kubernetes {
    config_path              = "~/.kube/config"
    host                     = google_container_cluster.primary.endpoint
    cluster_ca_certificate   = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
    client_certificate       = base64decode(google_container_cluster.primary.master_auth[0].client_certificate)
    client_key               = base64decode(google_container_cluster.primary.master_auth[0].client_key)
  }
}

resource "helm_release" "app" {
  name       = "hostname-display"
  chart      = "./hostname-display"
  timeout    = 1000
}
