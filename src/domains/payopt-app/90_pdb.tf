resource "kubernetes_pod_disruption_budget_v1" "payment_options" {

  for_each = var.pod_disruption_budgets

  metadata {
    namespace = kubernetes_namespace.namespace.metadata[0].name
    name      = each.key
  }
  spec {
    min_available = each.value.minAvailable
    selector {
      match_labels = each.value.matchLabels
    }
  }
}
