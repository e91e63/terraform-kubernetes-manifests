output "info" {
  value = {
    namespace = yamldecode(kubectl_manifest.namespace.yaml_body_parsed).metadata.name
    url       = var.conf.route != null ? module.traefik_ingress_route[0].info.url : null

  }
}
