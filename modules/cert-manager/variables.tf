variable "cert_manager_conf" {
  type = object({
    email                 = string
    personal_access_token = string
    version               = string
  })
}

variable "k8s_conf" {
  type = object({
    cluster_ca_certificate = string,
    host                   = string,
    token                  = string,
  })
}
