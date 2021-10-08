variable "consul_conf" {
  type = object({
    version = string
  })
}

variable "k8s_info" {
  type = object({
    cluster_ca_certificate = string,
    host                   = string,
    token                  = string,
  })
}
