variable "conf" {
  type = object({
    name  = string
    users = list(string)
  })
}
