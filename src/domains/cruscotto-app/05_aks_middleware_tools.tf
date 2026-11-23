module "aks_middleware" {
  source = "../../aks_middleware"

  https_endpoint                                            = local.domain_hostname
  namespace                                                 = kubernetes_namespace.namespace.metadata[0].name
  location_string                                           = var.location_string
  kv_secret_name_for_application_insights_connection_string = "app-insight-connection-string"
  application_insights_resource_group                       = data.azurerm_resource_group.monitor_italy_rg.name
  application_insights_id                                   = data.azurerm_application_insights.application_insights_italy.id
  application_insights_action_group_ids                     = [data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.email.id]
  keyvault_name                                             = data.azurerm_key_vault.kv.name
  keyvault_tenant_id                                        = data.azurerm_client_config.current.tenant_id

  workload_identity_service_account_name = module.workload_identity.workload_identity_service_account_name
  workload_identity_client_id            = module.workload_identity.workload_identity_client_id

  depends_on = [module.workload_identity]
}