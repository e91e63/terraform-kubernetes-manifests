variable "alpine_conf" {
  type = object({
    image = string
    name  = string
  })
}
