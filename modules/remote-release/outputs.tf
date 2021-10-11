output "route" {
  value = var.route_conf.active ? module.traefik_ingress_route[0].route : "none"
}
