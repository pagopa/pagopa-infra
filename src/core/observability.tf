resource "azurerm_kusto_cluster" "data_explorer_cluster" {

  count = var.dexp_params.enabled ? 1 : 0

  name                = replace(format("%sdataexplorer", local.project), "-", "")
  location            = azurerm_resource_group.monitor_rg.location
  resource_group_name = azurerm_resource_group.monitor_rg.name

  sku {
    name     = var.dexp_params.sku.name
    capacity = var.dexp_params.sku.capacity
  }

  optimized_auto_scale {
    minimum_instances = var.dexp_params.autoscale.min_instances
    maximum_instances = var.dexp_params.autoscale.max_instances
  }

  public_network_access_enabled = var.dexp_params.public_network_access_enabled
  double_encryption_enabled     = var.dexp_params.double_encryption_enabled
  engine                        = "V3"

  tags = var.tags

}