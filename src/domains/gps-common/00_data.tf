data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_virtual_network" "vnet_italy" {
  name                = local.vnet_italy_name
  resource_group_name = local.vnet_italy_resource_group_name
}

data "azurerm_virtual_network" "spoke_data_vnet" {
  name                = local.spoke_data_vnet_name
  resource_group_name = local.hub_spoke_vnet_rg_name
}

data "azurerm_virtual_network" "vnet_italy_cstar_integration" {
  name                = local.vnet_italy_name
  resource_group_name = local.vnet_italy_resource_group_name
}

data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}

data "azurerm_resource_group" "rg_vnet" {
  name = local.vnet_resource_group_name
}



data "azurerm_private_dns_zone" "storage" {
  count               = var.env_short != "d" ? 1 : 0
  name                = local.storage_dns_zone_name
  resource_group_name = local.storage_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "storage_queue" {
  count               = var.env_short != "d" ? 1 : 0
  name                = local.storage_queue_dns_zone_name
  resource_group_name = local.storage_dns_zone_resource_group_name
}

data "azurerm_subnet" "aks_snet" {
  name                 = local.aks_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_subnet" "azdo_snet" {
  name                 = local.azdo_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_subnet" "aks_subnet" {
  name                 = local.aks_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_subnet" "common_itn_private_endpoint_subnet" {
  name                 = local.common_private_endpoint_snet
  virtual_network_name = local.vnet_italy_name
  resource_group_name  = local.vnet_italy_resource_group_name
}

data "azurerm_subnet" "common_itn_cstar_integration_private_endpoint_subnet" {
  name                 = local.common_private_endpoint_snet_cstar_integration
  virtual_network_name = local.vnet_italy_cstar_integration_name
  resource_group_name  = local.vnet_italy_resource_group_name
}

data "azurerm_private_dns_zone" "cosmos" {
  name                = local.cosmos_dns_zone_name
  resource_group_name = local.cosmos_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "cosmos_table" {
  name                = local.cosmos_table_dns_zone_name
  resource_group_name = local.cosmos_table_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "privatelink_servicebus_windows_net" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = local.msg_resource_group_name
}

data "azurerm_resource_group" "rg_event_private_dns_zone" {
  name = local.msg_resource_group_name
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}

data "azurerm_monitor_action_group" "infra_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = local.monitor_resource_group_name
  name                = local.monitor_action_group_infra_opsgenie_name
}

data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = var.application_insights_name
  resource_group_name = var.monitor_resource_group_name
}

data "azurerm_monitor_action_group" "opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_opsgenie_name
}

data "azurerm_eventhub_authorization_rule" "nodo_dei_pagamenti_cache_aca_rx" {
  name                = "nodo-dei-pagamenti-cache-aca-rx"
  namespace_name      = "${local.product}-weu-core-evh-ns04"
  eventhub_name       = "nodo-dei-pagamenti-cache"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_data_factory" "data_factory" {
  name                = "pagopa-${var.env_short}-weu-nodo-df"
  resource_group_name = "pagopa-${var.env_short}-weu-nodo-df-rg"
}

#gps security resource group
data "azurerm_resource_group" "sec_rg" {
  name = "${local.product}-${var.domain}-sec-rg"
}

# gps KV
data "azurerm_key_vault" "gps_kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = data.azurerm_resource_group.sec_rg.name
}

data "azurerm_key_vault_secret" "gpd_db_usr" {
  name         = "db-apd-user-name"
  key_vault_id = data.azurerm_key_vault.gps_kv.id
}

data "azurerm_key_vault_secret" "gpd_db_pwd" {
  name         = "db-apd-user-password"
  key_vault_id = data.azurerm_key_vault.gps_kv.id
}
