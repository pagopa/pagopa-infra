data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}

data "azurerm_kusto_cluster" "data_explorer" {
  name                = replace("${local.product}dataexplorer", "-", "")
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_kusto_database" "data_explorer_re" {
  name                = "re"
  resource_group_name = data.azurerm_kusto_cluster.data_explorer.resource_group_name
  cluster_name        = data.azurerm_kusto_cluster.data_explorer.name
}
