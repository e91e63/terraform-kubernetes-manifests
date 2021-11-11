locals {
  route_split = split("`", kubernetes_manifest.main.object.spec.routes[0].match)
  subdomain   = route_split[1]
  path        = route_split[3]
}

output "info" {
  value = {
    route = "https://${local.domain}/${local.path}"
  }
}
