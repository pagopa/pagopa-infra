# Reference the existing ADX cluster.
data "azurerm_kusto_cluster" "fdr_recovery" {
  count = var.recovery_adx_viewer == null ? 0 : 1

  name                = var.recovery_adx_viewer.cluster_name
  resource_group_name = var.monitor_resource_group_name
}

# Allow recovery discovery to query the existing ADX database.
resource "azurerm_kusto_database_principal_assignment" "fdr_recovery_viewer" {
  count = var.recovery_adx_viewer == null ? 0 : 1

  name                = "FdrRecoveryWorkloadIdentityViewer"
  resource_group_name = data.azurerm_kusto_cluster.fdr_recovery[0].resource_group_name
  cluster_name        = data.azurerm_kusto_cluster.fdr_recovery[0].name
  database_name       = var.recovery_adx_viewer.database_name

  tenant_id      = data.azurerm_client_config.current.tenant_id
  principal_id   = module.workload_identity.workload_identity_client_id
  principal_type = "App"
  role           = "Viewer"
}