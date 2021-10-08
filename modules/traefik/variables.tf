variable "traefik_conf" {
  type = object({
    users = object({
      admin   = string
      private = string
    })
    version = string
  })
}
