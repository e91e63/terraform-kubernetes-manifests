variable "cert_issuer_conf" {
  type = object({
    email                              = string
    digitalocean_personal_access_token = string
  })
}
