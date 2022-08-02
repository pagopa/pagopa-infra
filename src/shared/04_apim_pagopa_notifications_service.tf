module "apim_pagopa_notifications_service_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "pagoPA"
  display_name = "pagoPA Notifications Service"
  description  = "API product for pagoPA Notifications Service"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

##############################
## API notifications service ##
##############################
locals {
  apim_pagopa_notifications_service_api = {
    display_name          = "pagoPA Shared - notifications service API"
    description           = "API to support notifications service"
    path                  = "shared/notifications-service"
    subscription_required = false
    service_url           = null
  }
}

# Notifications service APIs
resource "azurerm_api_management_api_version_set" "pagopa_notifications_service_api" {
  name                = format("%s-notifications-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pagopa_notifications_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pagopa_notifications_service_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-notifications-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_pagopa_notifications_service_product.product_id]
  subscription_required = local.apim_pagopa_notifications_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_notifications_service_api.id
  api_version           = "v1"

  description  = local.apim_pagopa_notifications_service_api.description
  display_name = local.apim_pagopa_notifications_service_api.display_name
  path         = local.apim_pagopa_notifications_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_notifications_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/pagopa-notifications-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/pagopa-notifications-service/v1/_base_policy.xml.tpl", {
    hostname = local.shared_hostname
  })
}