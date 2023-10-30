resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.domain
  }
}

module "pod_identity" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_pod_identity?ref=v6.4.1"

  resource_group_name = local.aks_resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_subscription.current.tenant_id
  cluster_name        = local.aks_name

  identity_name = "${kubernetes_namespace.namespace.metadata[0].name}-pod-identity" // TODO add env in name
  namespace     = kubernetes_namespace.namespace.metadata[0].name
  key_vault_id  = data.azurerm_key_vault.kv.id

  secret_permissions = ["Get"]
}

resource "kubernetes_pod_disruption_budget_v1" "receipts" {

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
