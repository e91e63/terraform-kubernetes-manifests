locals {
  route_split = split("`", kubernetes_manifest.main.object.spec.routes[0].match)
  domain      = local.route_split[1]
  path        = local.route_split[3]
}

output "info" {
  value = {
    route = "https://${local.domain}/${local.path}"
  }
}
