variable "domain_info" {
  type = object({
    name            = string
    tls_secret_name = string
  })
}

variable "service_conf" {
  type = object({
    middlewares = list(object({
      name      = string
      namespace = string
    }))
    name = string
  })
}
