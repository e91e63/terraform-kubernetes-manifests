variable "domain_info" {
  default = {}
  type    = any
}

variable "conf" {
  type = object({
    release = object({
      name      = string
      namespace = string
      urls      = list(string)
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


# variable "release_conf" {
#   type = object({
#     name      = string
#     namespace = string
#     urls      = list(string)
#   })
# }

# variable "route_conf" {
#   default = {
#     active       = false
#     middlewares  = []
#     service_name = ""
#     service_port = ""
#   }
#   type = object({
#     active       = bool
#     middlewares  = any
#     service_name = string
#     service_port = string
#   })
# }
