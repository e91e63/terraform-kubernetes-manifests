output "info" {
  value = {
    name      = kubernetes_manifest.traefik_middleware.object.metadata.name
    namespace = kubernetes_manifest.traefik_middleware.object.metadata.namespace
  }
}
