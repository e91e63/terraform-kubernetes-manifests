variable "domain_info" {
  type = object({
    name            = string
    tls_secret_name = string
  })
}

variable "helm_conf" {
  type = object({
    chart        = string
    cart_version = string
    name         = string
    repository   = string
  })
}