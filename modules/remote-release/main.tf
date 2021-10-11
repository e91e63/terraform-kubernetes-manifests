module "traefik_ingress_route" {
  count  = var.route_conf.active ? 1 : 0
  source = "../traefik-ingress-route/"

  domain_info  = var.domain_info
  route_conf   = var.route_conf
  service_conf = var.release_conf
}

data "http" "main" {
  url = var.release_conf.url
}

data "kubectl_file_documents" "main" {
  content = data.http.main.body
}

resource "kubectl_manifest" "test" {
  count     = length(data.kubectl_file_documents.main.documents)
  wait      = true
  yaml_body = element(data.kubectl_file_documents.main.documents, count.index)
}
