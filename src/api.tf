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
  publisher_email         = "daje@daje.com" # data.azurerm_key_vault_secret.apim_publisher_email.value
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


#########
## API ##
#########
