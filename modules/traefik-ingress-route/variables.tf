variable "domain_info" {
  type = object({
    name            = string
    tls_secret_name = string
  })
}

variable "route_conf" {
  type = object({
    middlewares = list(object({
      name      = string
      namespace = string
    }))
    path         = optional(string)
    service_kind = optional(string)
    service_name = string
    service_port = number
  })
}

variable "service_conf" {
  type = object({
    name      = string
    namespace = optional(string)
  })
}
