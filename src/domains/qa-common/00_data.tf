data "azurerm_key_vault" "domain_kv" {
  name                = "${local.product}-${var.location_short}-${local.domain_short}-kv"
  resource_group_name = "${local.product}-${var.location_short}-${local.domain}-sec-rg"
}


data "azurerm_virtual_network" "hub_vnet" {
  name                = local.hub_vnet_name
  resource_group_name = local.hub_vnet_resource_group_name
}

data "azurerm_virtual_network" "spoke_data_vnet" {
  name                = local.spoke_data_vnet_name
  resource_group_name = local.spoke_data_vnet_resource_group_name
}

data "azurerm_virtual_network" "spoke_compute_vnet" {
  name                = local.spoke_compute_vnet_name
  resource_group_name = local.spoke_compute_vnet_resource_group_name
}

data "azurerm_virtual_network" "spoke_security_vnet" {
  name                = local.spoke_security_vnet_name
  resource_group_name = local.spoke_security_vnet_resource_group_name
}

data "azurerm_virtual_network" "spoke_streaming_vnet" {
  name                = local.spoke_streaming_vnet_name
  resource_group_name = local.spoke_streaming_vnet_resource_group_name
}

data "azurerm_virtual_network" "spoke_tools_vnet" {
  name                = local.spoke_tools_vnet_name
  resource_group_name = local.spoke_tools_vnet_resource_group_name
}


data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.log_analytics_workspace_resource_group_name
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = local.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = local.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}


data "azurerm_monitor_action_group" "opsgenie" {
  count               = var.alert_use_opsgenie ? 1 : 0
  resource_group_name = local.monitor_resource_group_name
  name                = local.monitor_action_group_opsgenie_name
}

#
# Private DNS Zones
#
data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}


data "azurerm_private_dns_zone" "postgres" {
  name                = "private.postgres.database.azure.com"
  resource_group_name = local.private_dns_zone_rg_name
}







