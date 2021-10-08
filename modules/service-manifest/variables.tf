variable "domain_info" {
  type = object({
    name            = string
    tls_secret_name = string
  })
}
variable "k8s_info" {
  type = object({
    cluster_ca_certificate = string,
    host                   = string,
    token                  = string,
  })
}

variable "service_conf" {
  type = object({
    container_port = string
    image          = string
    name           = string
  })
}
