data "azurerm_key_vault_secret" "pm_onprem_hostname" {
  name         = "pm-onprem-hostname"
  key_vault_id = module.key_vault.id
}

##############
## Products ##
##############

module "apim_payment_transactions_gateway_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.84"

  product_id   = "payment-transactions-gateway"
  display_name = "Payment Transactions Gateway pagoPA"
  description  = "Product for Payment Transactions Gateway pagoPA"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/payment_transactions_gateway_api/_base_policy.xml")
}

############################################
## API payment-transactions-gateway-core  ##
############################################
locals {
  apim_payment_transactions_gateway_api = {
    # params for all api versions
    display_name          = "Payment Transactions Gateway - payment-transactions-gateway"
    description           = "RESTful APIs provided to support payments with payment gateways"
    path                  = "payment-transactions-gateway"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "payment_transactions_gateway_api" {

  name                = format("%s-payment-transactions-gateway-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_payment_transactions_gateway_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_payment_transactions_gateway_core_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-payment-transactions-gateway-core-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_transactions_gateway_product.product_id]
  subscription_required = local.apim_payment_transactions_gateway_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.payment_transactions_gateway_api.id
  api_version           = "v1"
  service_url           = local.apim_payment_transactions_gateway_api.service_url

  description  = local.apim_payment_transactions_gateway_api.description
  display_name = local.apim_payment_transactions_gateway_api.display_name
  path         = local.apim_payment_transactions_gateway_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_transactions_gateway_api/core/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_transactions_gateway_api/core/v1/_base_policy.xml.tpl")
}

############################################
## API payment-transactions-gateway-check ##
############################################
locals {
  apim_payment_transactions_gateway_check_api = {
    # params for all api versions
    display_name          = "Payment Transactions Gateway - payment-transactions-gateway-check"
    description           = "RESTful APIs provided to support webview polling"
    path                  = "payment-transactions-gateway-check"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "payment_transactions_gateway_check_api" {

  name                = format("%s-payment-transactions-gateway-check-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_payment_transactions_gateway_check_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_payment_transactions_gateway_core_api_check_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-payment-transactions-gateway-check-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_transactions_gateway_product.product_id]
  subscription_required = local.apim_payment_transactions_gateway_check_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.payment_transactions_gateway_api.id
  api_version           = "v1"
  service_url           = local.apim_payment_transactions_gateway_check_api.service_url

  description  = local.apim_payment_transactions_gateway_check_api.description
  display_name = local.apim_payment_transactions_gateway_check_api.display_name
  path         = local.apim_payment_transactions_gateway_check_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_transactions_gateway_api/check/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_transactions_gateway_api/check/v1/_base_policy.xml.tpl")
}
