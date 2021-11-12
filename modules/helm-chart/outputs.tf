output "info" {
  value = {
    namespace = helm_release.main.namespace
    url       = var.conf.route != null ? module.traefik_ingress_route[0].info.url : null
  }
}
