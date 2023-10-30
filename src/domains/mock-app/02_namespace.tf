resource "kubernetes_namespace" "namespace" {
  count = var.env_short == "d" ? 1 : 0
  metadata {
    name = var.domain
  }
}

module "pod_identity" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_pod_identity?ref=v6.4.1"

  resource_group_name = local.aks_resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_subscription.current.tenant_id
  cluster_name        = local.aks_name

  identity_name = "${kubernetes_namespace.namespace[0].metadata[0].name}-pod-identity" // TODO add env in name
  namespace     = kubernetes_namespace.namespace[0].metadata[0].name
  key_vault_id  = data.azurerm_key_vault.kv.id

  secret_permissions = ["Get"]
}
