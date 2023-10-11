


resource "azurerm_data_factory_linked_service_kusto" "dataexp_ls" {
  count = var.dexp_db.enable ? 1 : 0

  name                 = "AzureDataExplorer${var.env_short}LinkService"
  data_factory_id      = data.azurerm_data_factory.qi_data_factory.id
  kusto_endpoint       = azurerm_kusto_cluster.data_explorer_cluster[count.index].uri
  kusto_database_name  = azurerm_kusto_database.re_db[count.index].name
  use_managed_identity = true
}


resource "azurerm_kusto_database_principal_assignment" "qi_principal_assignment" {

  count = var.dexp_db.enable ? 1 : 0

  name                = "DexpPrincipalAssignment"
  resource_group_name = azurerm_kusto_cluster.data_explorer_cluster[count.index].resource_group_name
  cluster_name        = azurerm_kusto_cluster.data_explorer_cluster[count.index].name
  database_name       = azurerm_kusto_database.re_db[count.index].name

  tenant_id      = data.azurerm_data_factory.qi_data_factory.identity.0.tenant_id
  principal_id   = data.azurerm_data_factory.qi_data_factory.identity.0.principal_id
  principal_type = "App"
  role           = "Admin"
}
