resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.domain
  }
}

module "pod_identity" {
  source = "./.terraform/modules/__v3__/kubernetes_pod_identity"

  resource_group_name = local.aks_resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_subscription.current.tenant_id
  cluster_name        = local.aks_name

  identity_name = "${kubernetes_namespace.namespace.metadata[0].name}-pod-identity"
  namespace     = kubernetes_namespace.namespace.metadata[0].name
  key_vault_id  = data.azurerm_key_vault.key_vault_checkout.id

  secret_permissions = ["Get"]
}

module "workload_identity" {
  source                                = "./.terraform/modules/__v3__/kubernetes_workload_identity_configuration"
  workload_identity_name_prefix         = var.domain
  workload_identity_resource_group_name = data.azurerm_kubernetes_cluster.aks.resource_group_name
  aks_name                              = data.azurerm_kubernetes_cluster.aks.name
  aks_resource_group_name               = data.azurerm_kubernetes_cluster.aks.resource_group_name
  namespace                             = var.domain
  key_vault_id                          = data.azurerm_key_vault.key_vault_checkout.id
  key_vault_certificate_permissions     = ["Get"]
  key_vault_key_permissions             = ["Get"]
  key_vault_secret_permissions          = ["Get"]
}
