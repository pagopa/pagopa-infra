##############
## Products ##
##############

module "apim_io_payment_wallet_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

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
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

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

resource "azurerm_api_management_api_operation_policy" "delete_io_wallets" {
  api_name            = "${local.project}-io-payment-wallet-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "deleteIOPaymentWalletById"

  xml_content = file("./api/io-payment-wallet/v1/_delete_wallet.xml.tpl")
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

resource "azurerm_api_management_api_operation_policy" "get_wallets_by_user_and_walletId_for_io" {
  api_name            = "${local.project}-io-payment-wallet-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getIOPaymentWalletById"

  xml_content = templatefile("./api/io-payment-wallet/v1/_get_wallets_by_user_and_walletId.xml.tpl", { ecommerce_hostname = local.ecommerce_hostname })
}

resource "azurerm_api_management_api_operation_policy" "get_wallets_by_user_for_io" {
  api_name            = "${local.project}-io-payment-wallet-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getIOPaymentWalletsByIdUser"

  xml_content = templatefile("./api/io-payment-wallet/v1/_get_wallets_by_user.xml.tpl", { ecommerce_hostname = local.ecommerce_hostname })
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

resource "azurerm_api_management_api_operation_policy" "update_applications_for_io" {
  api_name            = "${local.project}-io-payment-wallet-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "updateIOPaymentWalletApplicationsById"

  xml_content = file("./api/io-payment-wallet/v1/_update_applications.xml.tpl")
}


resource "azurerm_api_management_named_value" "pay_wallet_family_friends_user_ids" {
  name                = "pay-wallet-family-friends-user-ids"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "pay-wallet-family-friends-user-ids"
  value               = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}


#######################################################################
## Fragment policy to extract user id from session token             ##
#######################################################################

resource "azapi_resource" "pay_wallet_fragment_user_id_from_session_token" {

  # provider  = azapi.apim
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "pay-wallet-user-id-from-session-token"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Component that extract userId from JWT session token"
      format      = "rawxml"
      value = templatefile("./api/fragments/_fragment_policy_user_id_from_session_token.tpl.xml", {
      })

    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}
