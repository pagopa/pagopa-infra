data "azurerm_kusto_cluster" "data_explorer" {
  name                = replace("${local.product}dataexplorer", "-", "")
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_kusto_database" "data_explorer_re" {
  name                = "re"
  resource_group_name = data.azurerm_kusto_cluster.data_explorer.resource_group_name
  cluster_name        = data.azurerm_kusto_cluster.data_explorer.name
}

data "azurerm_user_assigned_identity" "uai_nodo_pod_identity" {
  name                = "nodo-pod-identity"
  resource_group_name = local.aks_resource_group_name
}

resource "azurerm_kusto_database_principal_assignment" "nodo_pod_identity" {
  name                = "KustoPrincipalAssignment"
  resource_group_name = data.azurerm_kusto_cluster.data_explorer.resource_group_name
  cluster_name        = data.azurerm_kusto_cluster.data_explorer.name
  database_name       = data.azurerm_kusto_database.data_explorer_re.name

  tenant_id      = data.azurerm_client_config.current.tenant_id
  principal_id   = data.azurerm_user_assigned_identity.uai_nodo_pod_identity.principal_id
  principal_type = "App"
  role           = "Viewer"
}

data "azurerm_user_assigned_identity" "workload_identity_clientid" {
  name                = "nodo-workload-identity"
  resource_group_name = "pagopa-${var.env_short}-weu-${var.env}-aks-rg"
}

resource "azurerm_kusto_database_principal_assignment" "nodo_workload_identity_kusto_principal_assignment" {
  name                = "KustoPrincipalAssignmentWorkloadIdentity"
  resource_group_name = data.azurerm_kusto_cluster.data_explorer.resource_group_name
  cluster_name        = data.azurerm_kusto_cluster.data_explorer.name
  database_name       = data.azurerm_kusto_database.data_explorer_re.name

  tenant_id      = data.azurerm_client_config.current.tenant_id
  principal_id   = data.azurerm_user_assigned_identity.workload_identity_clientid.principal_id
  principal_type = "App"
  role           = "Viewer"
}
