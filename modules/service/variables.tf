variable "domain_info" {
  default = {}
  type    = any
}

variable "service_conf" {
  type = object({
    container_port = string
    image          = string
    middlewares    = list(any)
    name           = string
  })
}
