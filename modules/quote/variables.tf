variable "k8s_conf" {
  type = object({
    cluster_ca_certificate = string,
    host                   = string,
    token                  = string,
  })
}

variable "quote_conf" {
  type = object({
    image = string
  })
}
