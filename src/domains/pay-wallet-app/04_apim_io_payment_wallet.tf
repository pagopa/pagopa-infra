##############
## Products ##
##############

module "apim_io_payment_wallet_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "io-payment-wallet"
  display_name = "IO payment wallet pagoPA"
  description  = "Product for IO payment wallet pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#################################################
## API payment wallet for IO                   ##
#################################################
locals {
  apim_io_payment_wallet_api = {
    display_name          = "pagoPA - payment wallet API only for IO APP"
    description           = "API to support payment wallet only for IO APP"
    path                  = "io-payment-wallet"
    subscription_required = false
    service_url           = null
  }
}

# Payment wallet service APIs
resource "azurerm_api_management_api_version_set" "io_payment_wallet_api" {
  name                = "${local.project}-io-payment-wallet-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_io_payment_wallet_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_io_payment_wallet_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-io-payment-wallet-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_io_payment_wallet_product.product_id]
  subscription_required = local.apim_io_payment_wallet_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.io_payment_wallet_api.id
  api_version           = "v1"

  description  = local.apim_io_payment_wallet_api.description
  display_name = local.apim_io_payment_wallet_api.display_name
  path         = local.apim_io_payment_wallet_api.path
  protocols    = ["https"]
  service_url  = local.apim_io_payment_wallet_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/io-payment-wallet/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/io-payment-wallet/v1/_base_policy.xml.tpl", {
    hostname = local.payment_wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "get_payment_methods_for_io" {
  api_name            = "${local.project}-io-payment-wallet-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getAllPaymentMethodsForIO"

  xml_content = templatefile("./api/io-payment-wallet/v1/_get_payment_methods.xml.tpl",
    {
      ecommerce_hostname                   = local.ecommerce_hostname
      enabled_payment_wallet_method_ids_pm = var.enabled_payment_wallet_method_ids_pm
    }
  )
}

resource "azurerm_api_management_api_operation_policy" "post_io_wallets" {
  api_name            = "${local.project}-io-payment-wallet-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "createIOPaymentWallet"

  xml_content = templatefile("./api/io-payment-wallet/v1/_post_wallets.xml.tpl", {
    env                = var.env == "prod" ? "" : "${var.env}.",
    ecommerce_hostname = local.ecommerce_hostname
  })
}
