##########################################
## Products session wallet token pagoPA ##
##########################################

module "apim_session_wallet_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "session-wallet-token"
  display_name = "session wallet token pagoPA"
  description  = "Product session wallet token pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/session-wallet/_base_policy.xml")
}

#################################################
## API session wallet token pagoPA for IO      ##
#################################################
locals {
  apim_session_wallet_api = {
    display_name          = "pagoPA - session wallet token pagoPA for IO APP"
    description           = "API session wallet token pagoPA for IO APP"
    path                  = "session-wallet"
    subscription_required = true
    service_url           = null
  }
}

# Session wallet token service APIs
resource "azurerm_api_management_api_version_set" "session_wallet_api" {
  name                = "${local.project}-session-wallet-api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_session_wallet_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_session_wallet_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = "${local.project}-session-wallet-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_session_wallet_product.product_id]
  subscription_required = local.apim_session_wallet_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.session_wallet_api.id
  api_version           = "v1"

  description  = local.apim_session_wallet_api.description
  display_name = local.apim_session_wallet_api.display_name
  path         = local.apim_session_wallet_api.path
  protocols    = ["https"]
  service_url  = local.apim_session_wallet_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/session-wallet/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/session-wallet/v1/_base_policy.xml.tpl", {
    hostname = null
  })
}