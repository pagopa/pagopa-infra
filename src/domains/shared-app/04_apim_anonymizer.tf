locals {
  apim_anonymizer_api = {
    display_name          = "Anonymizer Product pagoPA"
    description           = "API to anonymize PII",
    path                  = "shared/anonymizer"
    subscription_required = false
    service_url           = null
  }
}

module "apim_anonymizer_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "anonymizer"
  display_name = local.apim_anonymizer_api.display_name
  description  = local.apim_anonymizer_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "api_anonymizer_api" {

  name                = format("%s-anonymizer-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_anonymizer_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_anonymizer_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-anonymizer-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_anonymizer_product.product_id]
  subscription_required = local.apim_anonymizer_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_anonymizer_api.id
  api_version           = "v1"

  description  = local.apim_anonymizer_api.description
  display_name = local.apim_anonymizer_api.display_name
  path         = local.apim_anonymizer_api.path
  protocols    = ["https"]
  service_url  = local.apim_anonymizer_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/anonymizer/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/anonymizer/v1/_base_policy.xml", {
    hostname = local.shared_hostname
  })
}