variable "traefik_conf" {
  type = object({
    users = object({
      admin   = string
      private = string
    })
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
