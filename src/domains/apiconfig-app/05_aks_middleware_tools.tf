module "aks_middleware" {
  source = "../../aks_middleware"

  https_endpoint                                            = local.apiconfig_core_locals.hostname
  namespace                                                 = kubernetes_namespace.namespace.metadata[0].name
  location_string                                           = var.location_string
  kv_secret_name_for_application_insights_connection_string = "ai-${var.env_short}-connection-string"
  application_insights_resource_group                       = data.azurerm_resource_group.monitor_rg.name
  application_insights_id                                   = data.azurerm_application_insights.application_insights.id
  application_insights_action_group_ids                     = [data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.email.id]
  keyvault_name                                             = data.azurerm_key_vault.kv.name
  keyvault_tenant_id                                        = data.azurerm_client_config.current.tenant_id

  workload_identity_service_account_name = module.workload_identity_configuration.workload_identity_service_account_name
  workload_identity_client_id            = module.workload_identity_configuration.workload_identity_client_id

  depends_on = [module.workload_identity_configuration]
}


resource "helm_release" "status_app" {
  name         = "status-app"
  repository   = "https://pagopa.github.io/aks-microservice-chart-blueprint"
  chart        = "microservice-chart"
  version      = "7.6.0"
  namespace    = var.domain
  timeout      = 120
  force_update = true

  values = [
    "${
      templatefile("${path.root}/helm/status-app.yaml.tpl", {
        NAMESPACE                   = var.domain,
        INGRESS_URL                 = local.apiconfig_cache_locals.hostname,
        ENV_SHORT                   = var.env_short,
        SERVICE_ACCOUNT_NAME        = module.workload_identity_configuration.workload_identity_service_account_name,
        WORKLOAD_IDENTITY_CLIENT_ID = module.workload_identity_configuration.workload_identity_client_id
      })
    }"
  ]
  depends_on = [module.workload_identity_configuration]
}

