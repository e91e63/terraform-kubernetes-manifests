variable "pod_conf" {
  type = object({
    command = list(string)
    image   = string
    name    = string
  })
}
