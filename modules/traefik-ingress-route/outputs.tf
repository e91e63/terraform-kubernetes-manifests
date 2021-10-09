output "route" {
  value = kubernetes_manifest.main.object.spec.routes[0].match
}
