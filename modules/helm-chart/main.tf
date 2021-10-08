module "traefik_ingress_route" {
  source = "../traefik-ingress-route/"

  domain_info = var.domain_info
  route_conf  = var.helm_conf
}

resource "helm_release" "main" {
  chart      = var.helm_conf.chart
  name       = var.helm_conf.name
  repository = var.helm_conf.repository
  version    = var.helm_conf.chart_version

  values = [
    jsonencode(var.helm_conf.values)
  ]
}
