
# Crea un User Managed Identity
resource "azurerm_user_assigned_identity" "zabbix" {
  resource_group_name = azurerm_resource_group.zabbix.name
  location            = azurerm_resource_group.zabbix.location
  name                = "${local.project}-zabbix-mgmt"
}

# Crea un Service Principal associato alla User Managed Identity
resource "azurerm_role_assignment" "zabbix" {
  scope                = azurerm_user_assigned_identity.zabbix.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.zabbix.principal_id
}
