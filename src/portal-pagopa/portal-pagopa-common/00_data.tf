data "azurerm_key_vault" "portal" {
  name                = local.key_vault_name
  resource_group_name = local.key_vault_resource_group_name
}

data "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = local.acr_resource_group_name
}

data "azurerm_resource_group" "rg_vnet" {
  name = local.spoke_data_vnet_resource_group_name
}

data "azurerm_virtual_network" "spoke_data_vnet" {
  name                = local.spoke_data_vnet_name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

data "azurerm_private_dns_zone" "privatelink_postgres_database_azure_com" {
  name                = "private.postgres.database.azure.com"
  resource_group_name = "${local.product}-vnet-rg"
}

data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.log_analytics_workspace_resource_group_name
}

data "azurerm_monitor_action_group" "email" {
  name                = local.monitor_action_group_email_name
  resource_group_name = local.log_analytics_workspace_resource_group_name
}

data "azurerm_monitor_action_group" "slack" {
  name                = local.monitor_action_group_slack_name
  resource_group_name = local.log_analytics_workspace_resource_group_name
}

data "azurerm_key_vault_secret" "pgres_flex_admin_login" {
  name         = var.postgres_admin_login_secret_name
  key_vault_id = data.azurerm_key_vault.portal.id
}

data "azurerm_key_vault_secret" "pgres_flex_admin_pwd" {
  name         = var.postgres_admin_password_secret_name
  key_vault_id = data.azurerm_key_vault.portal.id
}

data "azurerm_key_vault_secret" "portal_app" {
  for_each = var.app_secret_names

  name         = each.value
  key_vault_id = data.azurerm_key_vault.portal.id
}

