resource "azurerm_resource_group" "zabbix" {
  name     = local.project
  location = var.location
}
