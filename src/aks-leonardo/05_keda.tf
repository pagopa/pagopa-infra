resource "kubernetes_namespace" "keda" {
  metadata {
    name = "keda"
  }
}

resource "helm_release" "keda" {
  name       = "keda"
  chart      = "keda"
  repository = "https://kedacore.github.io/charts"
  version    = var.keda_helm_version
  namespace  = kubernetes_namespace.keda.metadata[0].name
  wait       = false

  set {
    name  = "podIdentity.azureWorkload.enabled"
    value = true
  }

  set {
    name  = "podIdentity.azureWorkload.clientId"
    value = module.keda_workload_identity_configuration.workload_identity_client_id
  }

  set {
    name  = "podIdentity.azureWorkload.tenantId"
    value = data.azurerm_client_config.current.tenant_id
  }

  depends_on = [
    module.aks_leonardo
  ]
}

module "keda_workload_identity_init" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_workload_identity_init?ref=v8.103.0"


  workload_identity_name_prefix         = "keda"
  workload_identity_resource_group_name = azurerm_resource_group.rg_aks.name
  workload_identity_location            = var.location
}

module "keda_workload_identity_configuration" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_workload_identity_configuration?ref=v8.103.0"

  workload_identity_name_prefix         = "keda"
  workload_identity_resource_group_name = azurerm_resource_group.rg_aks.name
  aks_name                              = module.aks_leonardo.name
  aks_resource_group_name               = azurerm_resource_group.rg_aks.name
  namespace                             = kubernetes_namespace.keda.metadata[0].name

  key_vault_configuration_enabled = false

  depends_on = [module.keda_workload_identity_init]
}

resource "azurerm_role_assignment" "keda_workload_identity_monitoring_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Monitoring Reader"
  principal_id         = module.keda_workload_identity_configuration.workload_identity_principal_id

  depends_on = [
    module.aks_leonardo
  ]
}