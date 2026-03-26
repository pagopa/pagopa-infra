module "tls_checker" {
  source                              = "./.terraform/modules/__v3__/tls_checker"
  depends_on                          = [module.workload_identity]
  https_endpoint                      = local.selfcare_hostname
  alert_name                          = local.selfcare_hostname
  alert_enabled                       = true
  helm_chart_present                  = true
  namespace                           = kubernetes_namespace.namespace.metadata[0].name
  location_string                     = var.location_string
  application_insights_resource_group = data.azurerm_resource_group.monitor_rg.name
  application_insights_id             = data.azurerm_application_insights.application_insights.id
  application_insights_action_group_ids = [
    data.azurerm_monitor_action_group.slack.id,
    data.azurerm_monitor_action_group.email.id
  ]
  kv_secret_name_for_application_insights_connection_string = "ai-${var.env_short}-connection-string"
  keyvault_name                                             = data.azurerm_key_vault.kv.name
  keyvault_tenant_id                                        = data.azurerm_client_config.current.tenant_id
  workload_identity_enabled                                 = true
  workload_identity_service_account_name                    = module.workload_identity.workload_identity_service_account_name
  workload_identity_client_id                               = module.workload_identity.workload_identity_client_id

}

module "cert_mounter" {
  depends_on                             = [module.workload_identity]
  source                                 = "./.terraform/modules/__v3__/cert_mounter"
  namespace                              = var.domain
  certificate_name                       = replace(local.selfcare_hostname, ".", "-")
  kv_name                                = data.azurerm_key_vault.kv.name
  tenant_id                              = data.azurerm_subscription.current.tenant_id
  workload_identity_enabled              = true
  workload_identity_service_account_name = module.workload_identity.workload_identity_service_account_name
  workload_identity_client_id            = module.workload_identity.workload_identity_client_id
}

resource "helm_release" "reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = "v1.0.48"
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  # enabled it if you remove accidentally reloader
  # force_update = true

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
}
