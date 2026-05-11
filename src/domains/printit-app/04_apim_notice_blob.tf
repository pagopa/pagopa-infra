locals {

  hostname_blob_notices = data.azurerm_storage_account.notices_storage_sa.primary_blob_host
  hostname_blob_ci      = data.azurerm_storage_account.institutions_storage_sa.primary_blob_host

  apim_notices_blob_pagopa_api = {
    display_name          = "Payment Notices Blob Product pagoPA"
    description           = "API for Payment Notices Blob Storage"
    path                  = "printit-blob"
    subscription_required = false
    service_url           = null
  }
}

module "apim_notices_blob_product" {
  count = var.is_feature_enabled.printit ? 1 : 0

  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "pagopa-notices-blob"
  display_name = "Payment Notices Blob Storage"
  description  = "Stampa Avvisi Blob Storage (printit)"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "apim_notices_blob_api" {
  count = var.is_feature_enabled.printit ? 1 : 0

  name                = "${var.env_short}-notices-blob-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_notices_blob_pagopa_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_notices_blob_api_v1" {
  count  = var.is_feature_enabled.printit ? 1 : 0
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${var.env_short}-notices-blob-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_notices_blob_product[0].product_id]
  subscription_required = local.apim_notices_blob_pagopa_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_notices_blob_api[0].id
  api_version           = "v1"

  description  = local.apim_notices_blob_pagopa_api.description
  display_name = local.apim_notices_blob_pagopa_api.display_name
  path         = local.apim_notices_blob_pagopa_api.path
  protocols    = ["https"]
  service_url  = local.apim_notices_blob_pagopa_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/notices-blob/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/notices-blob/v1/_base_policy.xml", {})


  api_operation_policies = [
    {
      operation_id = "getLogo",
      xml_content = templatefile("./api/notices-blob/v1/_get_logo_policy.xml", {
        hostname = local.hostname_blob_ci
      })
    },
    {
      operation_id = "getNotices",
      xml_content = templatefile("./api/notices-blob/v1/_get_notices_policy.xml", {
        hostname = local.hostname_blob_notices
      })
    },
  ]

}
