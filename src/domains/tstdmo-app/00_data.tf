

data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-${var.location_short}-${local.domain}-kv"
  resource_group_name = "${local.product}-${var.location_short}-${local.domain}-sec-rg"

}

data "azurerm_resource_group" "monitor_rg" {
  name = local.monitor_rg_name
}

data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = local.log_analytics_workspace_name
  resource_group_name = local.log_analytics_workspace_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = local.application_insight_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

#
# Actions Group
#

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = local.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
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

data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}

data "azurerm_subnet" "private_endpoint_subnet" {
    count               = var.env_short != "d" ? 1 : 0
    name                 = "${local.product}-common-private-endpoint-snet"
  resource_group_name  = "${local.product}-${var.location_short}-vnet-rg"
  virtual_network_name = "${local.product}-${var.location_short}-vnet"
}


data "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.aks_name}"
  resource_group_name = "${local.aks_rg_name}"
}

data "azurerm_api_management" "apim" {
  name                = local.apim_name
  resource_group_name = local.apim_rg_name
}

data "azurerm_private_dns_zone" "azurewebsites" {
    count               = var.env_short != "d" ? 1 : 0
    name                = "privatelink.azurewebsites.net"
  resource_group_name = local.vnet_name
}


data "azurerm_subnet" "_snet" {
  name                 = "${local.project}--snet"
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name

}

data "azurerm_subnet" "_snet" {
name                 = "${local.project}--snet"
virtual_network_name = local.vnet_name
resource_group_name  = local.vnet_resource_group_name

}
