##############
## Products ##
##############

module "apim_bizevents_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "bizevents"
  display_name = "Biz Events Service"
  description  = "Servizio per gestire eventi di pagamento"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/bizevents-service/_base_policy.xml")
}

#################
##    API Biz Events  ##
#################
locals {
  apim_bizevents_service_api = {
    display_name          = "Biz Events Service"
    description           = "API to handle biz events payments"
    path                  = "bizevents/service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_bizevents_api" {

  name                = format("%s-bizevents-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_bizevents_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_bizevents_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-bizevents-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_bizevents_product.product_id]
  subscription_required = local.apim_bizevents_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_bizevents_api.id
  api_version           = "v1"

  description  = local.apim_bizevents_service_api.description
  display_name = local.apim_bizevents_service_api.display_name
  path         = local.apim_bizevents_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_bizevents_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/bizevents-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/bizevents-service/v1/_base_policy.xml", {
    hostname = local.bizevents_hostname
  })
}
