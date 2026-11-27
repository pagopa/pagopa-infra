resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "${var.domain}-aux"
  }
}

# nodo-aux workload identity
# WL-IDENTITY
# https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/1227751458/Migrazione+pod+Identity+vs+workload+Identity#Init-workload-identity
module "workload_identity_nodo_aux" {
  source = "./.terraform/modules/__v4__/kubernetes_workload_identity_init"

  workload_identity_name_prefix         = kubernetes_namespace.namespace.metadata[0].name
  workload_identity_resource_group_name = data.azurerm_kubernetes_cluster.aks.resource_group_name
  workload_identity_location            = var.location

  tags = module.tag_config.tags
}


# WL-IDENTITY
# https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/1227751458/Migrazione+pod+Identity+vs+workload+Identity#Init-workload-identity
module "workload_identity" {
  source = "./.terraform/modules/__v4__/kubernetes_workload_identity_configuration"

  depends_on = [module.workload_identity_nodo_aux]

  workload_identity_name_prefix         = kubernetes_namespace.namespace.metadata[0].name
  workload_identity_resource_group_name = data.azurerm_kubernetes_cluster.aks.resource_group_name
  aks_name                              = data.azurerm_kubernetes_cluster.aks.name
  aks_resource_group_name               = data.azurerm_kubernetes_cluster.aks.resource_group_name
  namespace                             = kubernetes_namespace.namespace.metadata[0].name

  key_vault_id                      = data.azurerm_key_vault.kv.id
  key_vault_certificate_permissions = ["Get"]
  key_vault_key_permissions         = ["Get"]
  key_vault_secret_permissions      = ["Get"]
}