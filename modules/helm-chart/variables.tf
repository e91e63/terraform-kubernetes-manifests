variable "domain_info" {
  default = {
    name            = null
    tls_secret_name = null
  }
  type = object({
    name            = string
    tls_secret_name = string
  })
}

variable "helm_conf" {
  type = object({
    chart         = string
    chart_version = string
    name          = string
    namespace     = string
    repository    = string
    values        = any
  })
}

variable "route_conf" {
  default = {
    active       = false
    middlewares  = []
    service_port = -1
  }
  type = object({
    active       = bool
    middlewares  = any
    service_name = optional(string)
    service_port = optional(number)
  })
}
