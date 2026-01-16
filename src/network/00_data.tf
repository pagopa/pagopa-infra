data "azurerm_key_vault" "kv_domain" {
  name                = "${local.project}-kv"
  resource_group_name = "${local.project}-sec-rg"
}


data "azurerm_key_vault_secret" "external_database_username" {
  for_each     = var.external_database_connection
  name         = each.value.user_secret_name
  key_vault_id = data.azurerm_key_vault.kv_domain.id
}

data "azurerm_key_vault_secret" "external_database_password" {
  for_each     = var.external_database_connection
  name         = each.value.password_secret_name
  key_vault_id = data.azurerm_key_vault.kv_domain.id
}

data "azurerm_virtual_network" "vnet_weu_core" {
  name                = local.vnet_core_name
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_virtual_network" "vnet_weu_fe" {
  name                = local.vnet_integration_name
  resource_group_name = local.vnet_integration_resource_group_name
}

data "azurerm_virtual_network" "vnet_itn_compute" {
  name                = local.vnet_italy_name
  resource_group_name = local.vnet_italy_resource_group_name
}


data "azurerm_key_vault_secret" "vnet_address_space" {
  for_each     = local.hub_spoke_vnet
  name         = each.value.address_space_secret_key
  key_vault_id = data.azurerm_key_vault.kv_domain.id
}
