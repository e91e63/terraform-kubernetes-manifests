variable "domain_info" {
  type = object({
    name            = string
    tls_secret_name = string
  })
}

variable "route_conf" {
  type = object({
    name = string
  })
}