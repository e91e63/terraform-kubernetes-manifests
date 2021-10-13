module "traefik_ingress_route" {
  count  = var.route_conf.active ? 1 : 0
  source = "../traefik-ingress-route/"

  domain_info  = var.domain_info
  route_conf   = var.route_conf
  service_conf = var.release_conf
}

data "http" "main" {
  count = length(var.release_conf.urls)

  url = var.release_conf.urls[count.index]
}

data "kubectl_file_documents" "main" {
  count = length(data.http.main)

  content = data.http.main[count.index].body
}

locals {
  # TODO: filter out namespaces and run those first
  flat_documents     = flatten(data.kubectl_file_documents.main[*].documents)
  namespace_document = slice(local.flat_documents, 0, 1)[0]
  documents          = slice(local.flat_documents, 1, length(local.flat_documents))
}

resource "kubectl_manifest" "namespace" {
  wait      = true
  yaml_body = local.namespace_document
}

resource "kubectl_manifest" "main" {
  count = length(local.documents)
  depends_on = [
    kubectl_manifest.namespace
  ]

  wait      = true
  yaml_body = local.documents[count.index]
}
