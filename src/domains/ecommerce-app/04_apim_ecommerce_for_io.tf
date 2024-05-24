
# pagopa-ecommerce APIs for io with payment-wallet
locals {
  apim_ecommerce_for_io_api = {
    display_name          = "eCommerce API for IO App"
    description           = "eCommerce pagoPA API dedicated to IO App for pagoPA payment with payment wallet"
    path                  = "ecommerce-io"
    subscription_required = var.env_short == "p"
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "ecommerce_for_io_api_v1" {
  name                = "${local.project}-for-io-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_for_io_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_for_io_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = "${local.project}-for-io-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_io_product.product_id]
  subscription_required = local.apim_ecommerce_for_io_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_for_io_api_v1.id
  api_version           = "v1"
  service_url           = local.apim_ecommerce_for_io_api.service_url

  description  = local.apim_ecommerce_for_io_api.description
  display_name = local.apim_ecommerce_for_io_api.display_name
  path         = local.apim_ecommerce_for_io_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-for-io/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-for-io/v1/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname   = local.ecommerce_hostname
    wallet_ingress_hostname      = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "io_post_wallet_transactions" {
  api_name            = "${local.project}-for-io-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "createWalletForTransactionsForIO"

  xml_content = templatefile("./api/ecommerce-for-io/v1/_wallet_transactions.xml.tpl", {
    wallet-basepath = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "io_transaction_authorization_request" {
  api_name            = "${local.project}-for-io-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "requestTransactionAuthorizationForIO"

  xml_content = templatefile("./api/ecommerce-for-io/v1/_auth_request.xml.tpl", {
    wallet-basepath              = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "io_calculate_fee" {
  api_name            = "${local.project}-for-io-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "calculateFeesForIO"

  xml_content = templatefile("./api/ecommerce-io/v1/_calculate_fees_policy.xml.tpl",
    {
      ecommerce-basepath           = local.ecommerce_hostname
      wallet-basepath              = local.wallet_hostname
    }
  )
}

resource "azurerm_api_management_api_operation_policy" "io_transaction_outcome" {
  api_name            = "${local.project}-for-io-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getTransactionOutcome"

  xml_content = file("./api/ecommerce-io/v1/_transaction_outcome.xml.tpl")
}

