variable "domain_info" {
  default = {}
  type    = any
}

variable "conf" {
  type = object({
    image          = string
    name           = string
    namespace      = optional(string)
    port_container = optional(number)
    port_service   = optional(number)
    route = object({
      middlewares = list(object({
        name      = string
        namespace = string
      }))
      subdomain = optional(string)
    })
  })
}
