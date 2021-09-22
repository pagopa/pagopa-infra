# APIM subnet
module "apim_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
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

  api_domain        = var.env_short == "p" ? "api.platform.pagopa.it" : format("api.%s.platform.pagopa.it", lower(var.tags["Environment"]))
  portal_domain     = var.env_short == "p" ? "portal.platform.pagopa.it" : format("portal.%s.platform.pagopa.it", lower(var.tags["Environment"]))
  management_domain = var.env_short == "p" ? "management.platform.pagopa.it" : format("management.%s.platform.pagopa.it", lower(var.tags["Environment"]))
}


###########################
## Api Management (apim) ## 
###########################

module "apim" {

  source                  = "git::https://github.com/pagopa/azurerm.git//api_management?ref=v1.0.50"
  subnet_id               = module.apim_snet.id
  location                = azurerm_resource_group.rg_api.location
  name                    = format("%s-apim", local.project)
  resource_group_name     = azurerm_resource_group.rg_api.name
  publisher_name          = var.apim_publisher_name
  publisher_email         = data.azurerm_key_vault_secret.apim_publisher_email.value
  sku_name                = var.apim_sku
  virtual_network_type    = "Internal"
  redis_connection_string = module.redis.primary_connection_string
  redis_cache_id          = module.redis.id

  # This enables the Username and Password Identity Provider
  sign_up_enabled = false

  lock_enable = var.lock_enable

  # sign_up_terms_of_service = {
  #   consent_required = false
  #   enabled          = false
  #   text             = ""
  # }

  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  xml_content = templatefile("./api/base_policy.tpl", {
    portal-domain         = local.portal_domain
    management-api-domain = local.management_domain
    apim-name             = format("%s-apim", local.project)
  })

  tags = var.tags

  depends_on = [
    azurerm_application_insights.application_insights
  ]
}

resource "azurerm_api_management_custom_domain" "api_custom_domain" {
  api_management_id = module.apim.id

  proxy {
    host_name = local.api_domain
    key_vault_id = trimsuffix(
      data.azurerm_key_vault_certificate.app_gw_platform.secret_id,
      data.azurerm_key_vault_certificate.app_gw_platform.version
    )
  }

  developer_portal {
    host_name = local.portal_domain
    key_vault_id = trimsuffix(
      data.azurerm_key_vault_certificate.portal_platform.secret_id,
      data.azurerm_key_vault_certificate.portal_platform.version
    )
  }

  management {
    host_name = local.management_domain
    key_vault_id = trimsuffix(
      data.azurerm_key_vault_certificate.management_platform.secret_id,
      data.azurerm_key_vault_certificate.management_platform.version
    )
  }
}

#########
## API ##
#########

## monitor ##
module "monitor" {
  source              = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"
  name                = format("%s-monitor", var.env_short)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = "Monitor"
  display_name = "Monitor"
  path         = ""
  protocols    = ["https", "http"]

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


# module "api_bpd_pm_payment_instrument" {
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

#   name                = format("%s-bpd-pm-payment-instrument", var.env_short)
#   api_management_name = module.apim.name
#   resource_group_name = azurerm_resource_group.rg_api.name

#   description  = ""
#   display_name = "BPD PM Payment Instrument"
#   path         = "bpd/pm/payment-instrument"
#   protocols    = ["https", "http"]

#   service_url = format("http://%s/bpdmspaymentinstrument/bpd/payment-instruments", var.reverse_proxy_ip)

#   content_format = "openapi"
#   content_value = templatefile("./api/bpd_pm_payment_instrument/openapi.json.tpl", {
#     host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
#   })

#   xml_content = file("./api/base_policy.xml")

#   product_ids           = [module.pm_api_product.product_id]
#   subscription_required = true
# }

# Version sets (APIs with version) #

##############
## Products ##
##############

# module "batch_api_product" {
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

#   product_id   = "batch-api-product"
#   display_name = "BATCH_API_PRODUCT"
#   description  = "BATCH_API_PRODUCT"

#   api_management_name = module.apim.name
#   resource_group_name = azurerm_resource_group.rg_api.name

#   published             = false
#   subscription_required = true
#   approval_required     = false

#   policy_xml = file("./api_product/batch_api/policy.xml")
# }
