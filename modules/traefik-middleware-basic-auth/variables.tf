variable "basic_auth_conf" {
  type = object({
    name  = string
    users = list(string)
  })
}
