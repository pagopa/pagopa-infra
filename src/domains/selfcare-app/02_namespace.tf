

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.domain
  }
}


resource "kubernetes_pod_disruption_budget_v1" "selfcare" {

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

module "workload_identity" {
  source                                = "./.terraform/modules/__v3__/kubernetes_workload_identity_configuration"
  workload_identity_name_prefix         = var.domain
  workload_identity_resource_group_name = data.azurerm_kubernetes_cluster.aks.resource_group_name
  aks_name                              = data.azurerm_kubernetes_cluster.aks.name
  aks_resource_group_name               = data.azurerm_kubernetes_cluster.aks.resource_group_name
  namespace                             = var.domain
  key_vault_id                          = data.azurerm_key_vault.kv.id
  key_vault_certificate_permissions     = ["Get"]
  key_vault_key_permissions             = ["Get"]
  key_vault_secret_permissions          = ["Get"]
}
