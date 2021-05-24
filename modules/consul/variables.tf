variable "kube_config" {
  type = object({
    client_certificate     = string,
    client_key             = string,
    cluster_ca_certificate = string,
    host                   = string,
    token                  = string,
  })
}
