resource "azurerm_resource_group" "rg_api" {
  name     = format("%s-api-rg", local.project)
  location = var.location

  tags = var.tags
}

locals {
  apim_cert_name_proxy_endpoint   = format("%s-proxy-endpoint-cert", local.project)
  portal_cert_name_proxy_endpoint = format("%s-proxy-endpoint-cert", "portal")

  api_domain        = var.env_short == "p" ? "api.services.pagopa.it" : format("api.%s.services.pagopa.it", lower(var.tags["Environment"]))
  portal_domain     = var.env_short == "p" ? "portal.services.pagopa.it" : format("portal.%s.services.pagopa.it", lower(var.tags["Environment"]))
  management_domain = var.env_short == "p" ? "management.services.pagopa.it" : format("management.%s.services.pagopa.it", lower(var.tags["Environment"]))
}


###########################
## Api Management (apim) ## 
###########################

module "apim" {
  source                  = "git::https://github.com/pagopa/azurerm.git//api_management?ref=v1.0.48"
  subnet_id               = module.apim_snet.id
  location                = azurerm_resource_group.rg_api.location
  name                    = format("%s-apim", local.project)
  resource_group_name     = azurerm_resource_group.rg_api.name
  publisher_name          = var.apim_publisher_name
  publisher_email         = "daje@daje.com" # fixme # data.azurerm_key_vault_secret.apim_publisher_email.value
  sku_name                = var.apim_sku
  virtual_network_type    = "Internal"
  redis_connection_string = module.redis.primary_connection_string
  # This enables the Username and Password Identity Provider
  sign_up_enabled = true

  lock_enable = var.lock_enable

  sign_up_terms_of_service = {
    consent_required = false
    enabled          = false
    text             = ""
  }

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

# fixme
# resource "azurerm_api_management_custom_domain" "api_custom_domain" {
#   api_management_id = module.apim.id

#   proxy {
#     # host_name    = trim(azurerm_private_dns_a_record.private_dns_a_record_api.fqdn, ".")
#     host_name = local.api_domain
#     # fixme
#     # key_vault_id = trimsuffix(
#     #   data.azurerm_key_vault_certificate.app_gw_cstar.secret_id,
#     #   data.azurerm_key_vault_certificate.app_gw_cstar.version
#     # )
#   }

#   developer_portal {
#     # host_name = trim(azurerm_private_dns_a_record.private_dns_a_record_portal.fqdn, ".")
#     host_name = local.portal_domain
#     # fixme
#     # key_vault_id = trimsuffix(
#     #   data.azurerm_key_vault_certificate.portal_cstar.secret_id,
#     #   data.azurerm_key_vault_certificate.portal_cstar.version
#     # )
#   }

#   management {
#     host_name = local.management_domain
#     # fixme
#     # key_vault_id = trimsuffix(
#     #   data.azurerm_key_vault_certificate.management_cstar.secret_id,
#     #   data.azurerm_key_vault_certificate.management_cstar.version
#     # )
#   }
# }


#########
## API ##
#########

module "api_mockec_service" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                = format("%s-mockec-service", var.env_short)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  description  = ""
  display_name = "mock ec service payment"
  path         = "mockec/payment"
  protocols    = ["https", "http"]

  service_url  = format("https://%s/mockEcService", module.mock_ec[0].default_site_hostname) # fixme
  # service_url  = format("https://%s", "pagopa-d-app-mock-ec.azurewebsites.net/mockEcService")
  
  content_format = "swagger-json"

  # fixme
  # content_value = templatefile("./api/mockec_service/paForNode_Service.yaml", {
  #   host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  # })

  content_value = file("./api/mockec_service/swagger.json")


  xml_content = file("./api/base_policy.xml")

  product_ids           = [module.mockec_product.product_id]
  subscription_required = true
}


module "mockec_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.42"

  product_id   = "mockec-api-product"
  display_name = "MOCKEC_API_PRODUCT"
  description  = "MOCKEC_API_PRODUCT"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 50

  policy_xml = file("./api_product/mockec_api/policy.xml")
}