variable "domain_info" {
  type = object({
    name            = string
    tls_secret_name = string
  })
}

variable "conf" {
  type = object({
    kind = optional(string)
    middlewares = list(object({
      name      = string
      namespace = string
    }))
    path = optional(string)
    service = object({
      name      = optional(string)
      namespace = optional(string)
      port      = optional(number)
    })
    subdomain = string
  })
}
