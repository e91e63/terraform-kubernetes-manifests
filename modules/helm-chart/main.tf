module "traefik_ingress_route" {
  count  = var.route_conf.active ? 1 : 0
  source = "../traefik-ingress-route/"

  domain_info = var.domain_info
  route_conf = defaults(
    var.route_conf,
    {
      service_name = var.helm_conf.name
      service_port = 80
    }
  )
  service_conf = var.helm_conf
}

resource "helm_release" "main" {
  chart      = var.helm_conf.chart
  name       = var.helm_conf.name
  namespace  = var.helm_conf.namespace
  repository = var.helm_conf.repository
  version    = var.helm_conf.chart_version

  values = [
    jsonencode(var.helm_conf.values)
  ]
}
