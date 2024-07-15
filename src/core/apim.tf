# APIM subnet
module "apim_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                 = format("%s-apim-snet", local.project)
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet_integration.name
  address_prefixes     = var.cidr_subnet_apim

  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.Web"]
}

resource "azurerm_resource_group" "rg_api" {
  name     = format("%s-api-rg", local.project)
  location = var.location

  tags = var.tags
}

locals {
  apim_cert_name_proxy_endpoint   = format("%s-proxy-endpoint-cert", local.project)
  portal_cert_name_proxy_endpoint = format("%s-proxy-endpoint-cert", "portal")

  api_domain        = format("api.%s.%s", var.dns_zone_prefix, var.external_domain)
  prf_domain        = format("api.%s.%s", var.dns_zone_prefix_prf, var.external_domain)
  portal_domain     = format("portal.%s.%s", var.dns_zone_prefix, var.external_domain)
  management_domain = format("management.%s.%s", var.dns_zone_prefix, var.external_domain)
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

# apicfg cache path(s) configuration


resource "azurerm_api_management_named_value" "apicfg_core_service_path" { // https://${url_aks}/pagopa-api-config-core-service/<o|p>/
  name                = "apicfg-core-service-path"
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "apicfg-core-service-path"
  value               = var.apicfg_core_service_path_value
}
resource "azurerm_api_management_named_value" "apicfg_selfcare_integ_service_path" { // https://${hostname}/pagopa-api-config-selfcare-integration/<o|p>"
  name                = "apicfg-selfcare-integ-service-path"
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "apicfg-selfcare-integ-service-path"
  value               = var.apicfg_selfcare_integ_service_path_value
}
