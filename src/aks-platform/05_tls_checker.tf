####################################
# 👤 TLS Checker workload identity #
####################################
module "tls_checker_workload_identity_init" {
  source = "./.terraform/modules/__v4__//kubernetes_workload_identity_init"


  workload_identity_name_prefix         = "tls"
  workload_identity_resource_group_name = azurerm_resource_group.aks_rg.name
  workload_identity_location            = var.location
}

module "tls_checker_workload_identity_configuration" {
  source = "./.terraform/modules/__v4__//kubernetes_workload_identity_configuration"

  workload_identity_name_prefix         = "tls"
  workload_identity_resource_group_name = azurerm_resource_group.aks_rg.name
  aks_name                              = module.aks.name
  aks_resource_group_name               = azurerm_resource_group.aks_rg.name
  namespace                             = kubernetes_namespace.monitoring.metadata[0].name

  key_vault_configuration_enabled   = true
  key_vault_id                      = data.azurerm_key_vault.kv.id
  key_vault_certificate_permissions = []
  key_vault_key_permissions         = ["Get"]
  key_vault_secret_permissions      = ["Get"]

  depends_on = [module.tls_checker_workload_identity_init]
}

###############################
# 📦 TLS Checker helm release #
###############################
module "tls_checker" {
  source = "./.terraform/modules/__v4__//tls_checker"

  for_each = { for chkr in var.tls_checker_https_endpoints_to_check : chkr.alert_name => chkr }

  https_endpoint                      = each.value.https_endpoint
  alert_name                          = each.value.alert_name
  alert_enabled                       = each.value.alert_enabled
  helm_chart_present                  = each.value.helm_present
  namespace                           = kubernetes_namespace.monitoring.metadata[0].name
  location_string                     = var.location_string
  application_insights_resource_group = data.azurerm_resource_group.monitor_rg.name
  application_insights_id             = data.azurerm_application_insights.application_insights.id

  application_insights_action_group_ids = flatten([
    [
      data.azurerm_monitor_action_group.slack.id,
      data.azurerm_monitor_action_group.email.id,
    ],
    # Under here only production deployment monitor action group
    (var.env == "prod" ? [
      data.azurerm_monitor_action_group.opsgenie.0.id,
    ] : [])
  ])

  kv_secret_name_for_application_insights_connection_string = "ai-${var.env_short}-connection-string"
  keyvault_name                                             = data.azurerm_key_vault.kv.name
  keyvault_tenant_id                                        = data.azurerm_client_config.current.tenant_id

  workload_identity_enabled              = true
  workload_identity_service_account_name = module.tls_checker_workload_identity_configuration.workload_identity_service_account_name
  workload_identity_client_id            = module.tls_checker_workload_identity_configuration.workload_identity_client_id

  depends_on = [module.tls_checker_workload_identity_configuration]
}
