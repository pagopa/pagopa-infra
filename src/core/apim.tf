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


resource "azurerm_api_management_custom_domain" "api_custom_domain" {
  api_management_id = data.azurerm_api_management.apim_migrated[0].id

  proxy {
    host_name = local.api_domain
    key_vault_id = replace(
      data.azurerm_key_vault_certificate.app_gw_platform.secret_id,
      "/${data.azurerm_key_vault_certificate.app_gw_platform.version}",
      ""
    )
  }

  developer_portal {
    host_name = local.portal_domain
    key_vault_id = replace(
      data.azurerm_key_vault_certificate.portal_platform.secret_id,
      "/${data.azurerm_key_vault_certificate.portal_platform.version}",
      ""
    )
  }

  management {
    host_name = local.management_domain
    key_vault_id = replace(
      data.azurerm_key_vault_certificate.management_platform.secret_id,
      "/${data.azurerm_key_vault_certificate.management_platform.version}",
      ""
    )
  }

  dynamic "proxy" {
    for_each = var.env_short == "u" ? [""] : []
    content {
      host_name = local.prf_domain
      key_vault_id = replace(
        data.azurerm_key_vault_certificate.app_gw_platform_prf[0].secret_id,
        "/${data.azurerm_key_vault_certificate.app_gw_platform_prf[0].version}",
        ""
      )
    }
  }
}

#########
## API ##
#########

## monitor ##
module "monitor" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"
  name                = format("%s-monitor", var.env_short)
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "Monitor"
  display_name = "Monitor"
  path         = ""
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/monitor/openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/base_policy.xml")

  subscription_required = false

  api_operation_policies = [
    {
      operation_id = "get"
      xml_content  = file("./api/monitor/mock_policy.xml")
    }
  ]
}

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
