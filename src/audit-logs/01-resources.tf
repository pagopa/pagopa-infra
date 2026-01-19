# Azure AD
data "azuread_group" "adgroup_admin" {
  display_name = "${local.prefix}-${var.env_short}-adgroup-admin"
}

data "azuread_group" "adgroup_developers" {
  display_name = "${local.prefix}-${var.env_short}-adgroup-developers"
}

data "azuread_group" "adgroup_operations" {
  display_name = "${local.prefix}-${var.env_short}-adgroup-operations"
}

data "azuread_group" "adgroup_security" {
  display_name = "${local.prefix}-${var.env_short}-adgroup-security"
}

data "azuread_group" "adgroup_technical_project_managers" {
  display_name = "${local.prefix}-${var.env_short}-adgroup-technical-project-managers"
}

data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = local.log_analytics_italy_workspace_name
  resource_group_name = local.log_analytics_italy_workspace_resource_group_name
}

data "azurerm_log_analytics_workspace" "log_analytics_weu" {
  name                = local.log_analytics_weu_workspace_name
  resource_group_name = local.log_analytics_weu_workspace_resource_group_name
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = var.tags
}


module "endpoint_snet" {
  source               = "./.terraform/modules/__v4__/IDH/subnet"
  name                 = "${local.project}-snet"
  resource_group_name  = local.vnet_data_italy_resource_group_name
  virtual_network_name = local.vnet_data_italy_name
  service_endpoints    = ["Microsoft.Storage"]

  idh_resource_tier = "slash28_privatelink_true"
  product_name      = local.prefix
  env               = var.env
  tags              = var.tags
}
