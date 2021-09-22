variable "kube_config" {
  type = object({
    cluster_ca_certificate = string,
    host                   = string,
    token                  = string,
  })
}

variable "google_oauth" {
  type = object({
    client_id     = string
    client_secret = string
  })
}
