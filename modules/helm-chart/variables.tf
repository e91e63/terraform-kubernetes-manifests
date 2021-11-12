variable "domain_info" {
  default = {}
  type    = any
}

variable "conf" {
  type = object({
    helm = object({
      chart         = string
      chart_version = string
      name          = string
      namespace     = optional(string)
      repository    = string
      values        = any
    })
    route = optional(object({
      middlewares = list(object({
        name      = string
        namespace = string
      }))
      service = object({
        name      = optional(string)
        namespace = optional(string)
        port      = optional(number)
      })
      subdomain = optional(string)
    }))
  })
}
