data "azurerm_subnet" "apim_snet" {
  name                 = format("%s-apim-snet", local.project)
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet_integration.name
}

data "azurerm_resource_group" "rg_api" {
  name = format("%s-api-rg", local.project)
}



locals {
  api_domain = format("api.%s.%s", var.dns_zone_prefix, var.external_domain)
}

###########################
## Api Management (apim) ##
###########################

data "azurerm_api_management" "apim_migrated" {
  count               = 1
  name                = local.pagopa_apim_migrated_name
  resource_group_name = local.pagopa_apim_migrated_rg
}


#################
## NAMED VALUE ##
#################
# migrated in next-core


#########
## API ##
#########

## monitor moved to next-core ##

