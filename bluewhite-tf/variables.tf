variable "google_project_id" {
  description = "The ID of your Google Cloud project"
  type        = string
}

variable "google_region" {
  description = "The region to deploy the resources in"
  type        = string
}

variable "gke_service_account_id" {
  description = "The ID of the GKE service account"
  type        = string
}

variable "gke_service_account_display_name" {
  description = "The display name of the GKE service account"
  type        = string
}

variable "gke_cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "gke_node_machine_type" {
  description = "The machine type for GKE nodes"
  type        = string
}

variable "gke_schedulable_node_count" {
  description = "The number of schedulable nodes in the node pool"
  type        = number
}

variable "gke_unschedulable_node_count" {
  description = "The number of unschedulable nodes in the node pool"
  type        = number
}

variable "gke_disk_size_gb" {
  description = "The disk size in GB for each node"
  type        = number
}

variable "gke_disk_type" {
  description = "The disk type for each node"
  type        = string
}
