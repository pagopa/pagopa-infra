data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-${var.location_short}-${local.domain}-kv"
  resource_group_name = "${local.product}-${var.location_short}-${local.domain}-sec-rg"
}

data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_resource_group" "rg_vnet" {
  name = local.vnet_resource_group_name
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

data "azurerm_key_vault" "domain_kv" {
  name                = "${local.project}-kv"
  resource_group_name = "${local.project}-sec-rg"
}
#
# Private DNS Zones
#
data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}


data "azurerm_private_dns_zone" "postgres" {
    count               = var.env_short != "d" ? 1 : 0
    name                = "private.postgres.database.azure.com"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}


data "azurerm_subnet" "private_endpoint_subnet" {
    count               = var.env_short != "d" ? 1 : 0
    name                 = "${local.product}-common-private-endpoint-snet"
  resource_group_name  = "${local.product}-${var.location_short}-vnet-rg"
  virtual_network_name = "${local.product}-${var.location_short}-vnet"
}

data "azurerm_private_dns_zone" "privatelink_redis_cache_windows_net" {
    count               = var.env_short != "d" ? 1 : 0
    name                = "privatelink.redis.cache.windows.net"
  resource_group_name = "${local.product}-vnet-rg"
}

data "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
    count               = var.env_short != "d" ? 1 : 0
    name                = "privatelink.documents.azure.com"
  resource_group_name = "${local.product}-vnet-rg"
}








