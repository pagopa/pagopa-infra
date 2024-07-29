locals {

  hostname_blob_notices = data.azurerm_storage_account.notices_storage_sa.primary_blob_host
  hostname_blob_ci = data.azurerm_storage_account.institutions_storage_sa.primary_blob_host

  apim_notices_blob_pagopa_api = {
    display_name = "Payment Notices Generator Product pagoPA"
    description  = "API for Payment Notices Generator"
    path                  = "blob"
    subscription_required = false
    service_url           = null
  }
}

module "apim_notices_blob_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v8.18.0"
  count  = var.is_feature_enabled.printit ? 1 : 0

  product_id   = "pagopa_notices_blob"
  display_name = local.apim_notices_blob_pagopa_api.display_name
  description  = local.apim_notices_blob_pagopa_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "apim_notices_blob_api" {
  count = var.is_feature_enabled.printit ? 1 : 0

  name                = format("%s-notices-blob-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_notices_blob_pagopa_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_notices_blob_api_v1" {
  count = var.is_feature_enabled.printit ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.76.1"

  name                  = format("%s-notices-blob-api", var.env_short)
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_notices_blob_product[0].product_id]
  subscription_required = local.apim_notices_blob_pagopa_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_notices_blob_api[0].id
  api_version           = "v1"
  service_url           = local.apim_notices_blob_pagopa_api.service_url

  description  = local.apim_notices_blob_pagopa_api.description
  display_name = local.apim_notices_blob_pagopa_api.display_name
  path         = local.apim_notices_blob_pagopa_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/notices-blob/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/checkout/checkout_transactions/v1/_base_policy.xml", {})

  api_operation_policies = [
    {
      operation_id = "getLogo",
      xml_content = templatefile("./policy/_get_logo_policy.xml", {
        hostname = local.hostname_blob_ci
      })
    },
    {
      operation_id = "getNotices",
      xml_content = templatefile("./policy/_get_notices_policy.xml", {
        hostname = local.hostname_blob_notices
      })
    },
  ]

}