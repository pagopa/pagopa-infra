data "azurerm_container_app_environment" "tools_cae" {
  name                = "${local.product}-tools-cae"
  resource_group_name = "${local.product}-core-tools-rg"
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = local.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "infra_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = local.monitor_resource_group_name
  name                = local.monitor_action_group_infra_opsgenie_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = local.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}

data "azurerm_monitor_action_group" "opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = local.monitor_resource_group_name
  name                = local.monitor_action_group_opsgenie_name
}

data "azurerm_resource_group" "rg_vnet_core" {
  name = local.vnet_core_resource_group_name
}


data "azurerm_private_dns_zone" "storage_account_table" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = data.azurerm_resource_group.rg_vnet_core.name
}

data "azurerm_virtual_network" "vnet_core" {
  name                = local.vnet_core_name
  resource_group_name = local.vnet_core_resource_group_name
}

data "azurerm_subnet" "private_endpoint_subnet" {
  count                = var.use_private_endpoint ? 1 : 0
  name                 = "${local.product}-common-private-endpoint-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet_core.name
  virtual_network_name = data.azurerm_virtual_network.vnet_core.name
}

data "azurerm_public_ip" "appgateway_public_ip" {
  name                = format("%s-appgateway-pip", local.product)
  resource_group_name = data.azurerm_resource_group.rg_vnet_core.name
}

data "azurerm_dashboard_grafana" "managed_grafana" {
  name                = local.grafana_name
  resource_group_name = local.grafana_rg_name
}

#
# 🔒 Secrets
#

data "azurerm_key_vault" "key_vault" {
  name                = local.key_vault_name
  resource_group_name = local.key_vault_rg_name
}

data "azurerm_key_vault_secret" "grafana_key" {
  name         = "grafana-api-key"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
