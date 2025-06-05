##############
## Products ##
##############

module "apim_anonymizer_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "anonymizer"
  display_name = "Anonymizer"
  description  = "Anonymizer"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 0

  policy_xml = file("./api_product/anonymizer/_base_policy.xml")
}

######################
##    API anonymizer  ##
######################
locals {
  apim_anonymizer_service_api = {
    display_name          = "Anonymizer"
    description           = "Anonymizer"
    path                  = "anonymizer/service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_anonymizer_api" {
  name                = "${var.env_short}-anonymizer-service-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_anonymizer_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_anonymizer_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-anonymizer-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_anonymizer_product.product_id]
  subscription_required = local.apim_anonymizer_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_anonymizer_api.id
  api_version           = "v1"

  description  = local.apim_anonymizer_service_api.description
  display_name = local.apim_anonymizer_service_api.display_name
  path         = local.apim_anonymizer_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_anonymizer_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/anonymizer/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_anonymizer_product.product_id
  })

  xml_content = templatefile("./api/anonymizer/v1/_base_policy.xml.tpl", {
    hostname = "${module.anonymizer_function.name}.azurewebsites.net"
  })
}
