output "info" {
  # sensitive = true
  value = {
    namespace = yamldecode(kubectl_manifest.namespace.yaml_body_parsed).metadata.name
    route     = var.route_conf.active ? module.traefik_ingress_route[0].route : "none"

  }
}
