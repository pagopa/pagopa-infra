locals {
  apim_anonymizer_api = {
    display_name          = "Anonymizer Product pagoPA"
    description           = "API to anonymize PII",
    path                  = "shared/anonymizer"
    subscription_required = true
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
