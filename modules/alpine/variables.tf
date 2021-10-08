variable "alpine_conf" {
  type = object({
    image = string
    name  = string
  })
}

variable "k8s_info" {
  type = object({
    cluster_ca_certificate = string,
    host                   = string,
    token                  = string,
  })
}
