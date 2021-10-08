variable "whoami_conf" {
  type = object({
    domain_name = string
    image       = string
    name        = string
  })
}
