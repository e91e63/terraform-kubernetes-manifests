variable "k8s_info" {
  type = object({
    cluster_ca_certificate = string,
    host                   = string,
    token                  = string,
  })
}

variable "whoami_conf" {
  type = object({
    domain_name = string
    image       = string
    name        = string
  })
}
