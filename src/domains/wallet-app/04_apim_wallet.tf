##############
## Products ##
##############

module "apim_wallet_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "wallet"
  display_name = "wallet pagoPA"
  description  = "Product for wallet pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#################################################
## API wallet service                          ##
#################################################
locals {
  apim_wallet_service_api = {
    display_name          = "pagoPA - wallet API"
    description           = "API to support wallet service"
    path                  = "wallet-service"
    subscription_required = true
    service_url           = null
  }
}

# Wallet service APIs
resource "azurerm_api_management_api_version_set" "wallet_service_api" {
  name                = format("%s-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_wallet_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_wallet_service_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = format("%s-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_wallet_product.product_id]
  subscription_required = local.apim_wallet_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.wallet_service_api.id
  api_version           = "v1"

  description  = local.apim_wallet_service_api.description
  display_name = local.apim_wallet_service_api.display_name
  path         = local.apim_wallet_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_wallet_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/wallet-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/wallet-service/v1/_base_policy.xml.tpl", {
    hostname = local.wallet_hostname
  })
}

module "apim_wallet_service_notification_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = format("%s-notifications-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_wallet_product.product_id]
  version_set_id        = azurerm_api_management_api_version_set.wallet_service_api.id
  api_version           = "v1"

  description  = local.apim_wallet_service_api.description
  display_name = local.apim_wallet_service_api.display_name
  path         = local.apim_wallet_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_wallet_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/npg/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/npg/v1/_base_policy.xml.tpl", {
    hostname = local.wallet_hostname
  })
}