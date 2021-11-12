output "url" {
  value = local.conf.route != null ? module.traefik_ingress_route[0].info.url : null
}
