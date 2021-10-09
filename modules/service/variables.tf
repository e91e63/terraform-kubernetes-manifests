variable "domain_info" {
  default = {}
  type    = any
}

variable "service_conf" {
  type = object({
    container_port = string
    image          = string
    name           = string
  })
}


variable "route_conf" {
  default = {
    active      = false
    middlewares = []
  }
  type = object({
    active      = bool
    middlewares = any
  })
}
