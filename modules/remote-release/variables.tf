variable "domain_info" {
  type = object({
    name            = string
    tls_secret_name = string
  })
}

variable "release_conf" {
  type = object({
    name      = string
    namespace = string
    urls      = list(string)
  })
}

variable "route_conf" {
  default = {
    active       = false
    middlewares  = []
    service_name = ""
    service_port = ""
  }
  type = object({
    active       = bool
    middlewares  = any
    service_name = string
    service_port = string
  })
}
