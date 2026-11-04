module "aks_middleware" {
  source = "./.terraform/modules/__v4__/kubernetes_middleware"

  https_endpoint                                            = var.https_endpoint
  alert_name                                                = var.https_endpoint
  alert_enabled                                             = true
  helm_chart_present                                        = true
  namespace                                                 = var.namespace
  location_string                                           = var.location_string
  kv_secret_name_for_application_insights_connection_string = var.kv_secret_name_for_application_insights_connection_string
  application_insights_resource_group                       = var.application_insights_resource_group
  application_insights_id                                   = var.application_insights_id
  application_insights_action_group_ids                     = var.application_insights_action_group_ids
  keyvault_name                                             = var.keyvault_name
  keyvault_tenant_id                                        = var.keyvault_tenant_id

  workload_identity_service_account_name = var.workload_identity_service_account_name
  workload_identity_client_id            = var.workload_identity_client_id

}