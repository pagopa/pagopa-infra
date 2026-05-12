#
# VNET
#
### CORE
data "azurerm_virtual_network" "vnet_core" {
  name                = local.vnet_core_name
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_resource_group" "rg_vnet_core" {
  name = local.vnet_core_resource_group_name
}

### INTEGRATION
data "azurerm_virtual_network" "vnet_integration" {
  name                = local.vnet_integration_name
  resource_group_name = local.vnet_integration_resource_group_name
}


data "azurerm_resource_group" "rg_vnet_integration" {
  name = local.vnet_integration_resource_group_name
}

#
# App GW integration
#
data "azurerm_application_gateway" "app_gw_integration" {
  name                = "pagopa-${var.env_short}-weu-integration-app-gw"
  resource_group_name = "pagopa-${var.env_short}-vnet-rg"
}


data "azurerm_key_vault_secret" "cstar_subscription_id" {
  name         = "cstar-subscription-id"
  key_vault_id = module.key_vault.id
}

### Vnet Hub - Spoke
data "azurerm_virtual_network" "spoke_tools" {
  name                = "${local.product_ita}-spoke-tools-vnet"
  resource_group_name = "${local.product_ita}-network-hub-spoke-rg"
}