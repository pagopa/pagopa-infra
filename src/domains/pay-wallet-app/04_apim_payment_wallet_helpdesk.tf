##############
## Products ##
##############

module "apim_payment_wallet_helpdesk_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "payment-wallet-helpdesk"
  display_name = "payment-wallet pagoPA helpdesk service"
  description  = "Product for payment-wallet pagoPA helpdesk service"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#############################################
## API payment-wallet helpdesk service ##
#############################################
locals {
  apim_pagopa_payment_wallet_helpdesk_service_api = {
    display_name          = "pagoPA payment-wallet - helpdesk service API"
    description           = "API to support manual operation for payment-wallet operations - helpdesk service"
    path                  = "payment-wallet/helpdesk-service"
    subscription_required = true
    service_url           = null
  }
}

# helpdesk service APIs
resource "azurerm_api_management_api_version_set" "pagopa_payment_wallet_helpdesk_service_api" {
  name                = "${local.project}-helpdesk-service-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pagopa_payment_wallet_helpdesk_service_api.display_name
  versioning_scheme   = "Segment"
}


#helpdesk api for payment-wallet
module "apim_pagopa_payment_wallet_helpdesk_service_api_v1" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-helpdesk-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_payment_wallet_helpdesk_product.product_id]
  subscription_required = local.apim_pagopa_payment_wallet_helpdesk_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_payment_wallet_helpdesk_service_api.id
  api_version           = "v1"

  description  = local.apim_pagopa_payment_wallet_helpdesk_service_api.description
  display_name = local.apim_pagopa_payment_wallet_helpdesk_service_api.display_name
  path         = local.apim_pagopa_payment_wallet_helpdesk_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_payment_wallet_helpdesk_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/payment-wallet-helpdesk-api/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/payment-wallet-helpdesk-api/v1/_base_policy.xml.tpl", {
    hostname = local.payment_wallet_hostname
  })
}
