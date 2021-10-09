output "info" {
  value = {
    ref = {
      kind = kubernetes_manifest.cert_manager_cluster_issuer_digitalocean.object.kind
      name = kubernetes_manifest.cert_manager_cluster_issuer_digitalocean.object.metadata.name
    }
  }
}
