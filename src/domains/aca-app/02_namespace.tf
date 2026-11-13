resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.domain
    labels = {
      domain = var.domain # Icinga Business Process domain (continuos-platform-monitoring-app)
    }
  }
}
