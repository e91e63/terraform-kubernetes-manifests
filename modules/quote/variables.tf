variable "kube_config" {
  type = object({
    cluster_ca_certificate = string,
    host                   = string,
    token                  = string,
  })
}
