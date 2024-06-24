###########################
###                     ###
### ECOMMERCE IO V2     ###
###                     ###
###########################

resource "azurerm_api_management_api_version_set" "apim_v2_ecommerce_io_api_v1" {
  name                = "${local.project}-ecommerce-io-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_v2
  display_name        = local.apim_ecommerce_io_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_named_value" "apim_v2pay_wallet_family_friends_user_ids" {
  name                = "pay-wallet-family-friends-user-ids"
  api_management_name = local.pagopa_apim_v2
  resource_group_name = local.pagopa_apim_rg
  display_name        = "pay-wallet-family-friends-user-ids"
  value               = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

module "apim_v2_ecommerce_io_api_v2" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = "${local.project}-ecommerce-io-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_v2
  product_ids           = [module.apim_ecommerce_io_product.product_id]
  subscription_required = local.apim_ecommerce_io_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_io_api_v1.id
  api_version           = "v2"
  service_url           = local.apim_ecommerce_io_api.service_url

  description  = local.apim_ecommerce_io_api.description
  display_name = local.apim_ecommerce_io_api.display_name
  path         = local.apim_ecommerce_io_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-io/v2/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-io/v2/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
    wallet_ingress_hostname    = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "apim_v2_io_post_wallet_transactions_v2" {
  api_name            = "${local.project}-ecommerce-io-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_v2
  operation_id        = "createWalletForTransactionsForIO"

  xml_content = templatefile("./api/ecommerce-io/v2/_wallet_transactions.xml.tpl", {
    wallet-basepath = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "apim_v2_io_transaction_authorization_request_v2" {
  api_name            = "${local.project}-ecommerce-io-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_v2
  operation_id        = "requestTransactionAuthorizationForIO"

  xml_content = templatefile("./api/ecommerce-io/v2/_auth_request.xml.tpl", {
    authurl-basepath = var.env_short == "d" ? local.apim_hostname : "{{wisp2-gov-it}}"
    wallet-basepath  = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "apim_v2_io_calculate_fee_v2" {
  api_name            = "${local.project}-ecommerce-io-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_v2
  operation_id        = "calculateFeesForIO"

  xml_content = templatefile("./api/ecommerce-io/v2/_calculate_fees_policy.xml.tpl",
    {
      ecommerce-basepath = local.ecommerce_hostname
      wallet-basepath    = local.wallet_hostname
    }
  )
}

resource "azurerm_api_management_api_operation_policy" "apim_v2_delete_transactions_v2" {
  api_name            = "${local.project}-ecommerce-io-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_v2
  operation_id        = "requestTransactionUserCancellationForIO"

  xml_content = templatefile("./api/ecommerce-io/v2/_delete_transaction.xml.tpl", {
    wallet-basepath = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "apim_v2_get_transactions_v2" {
  api_name            = "${local.project}-ecommerce-io-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_v2
  operation_id        = "getTransactionInfoForIO"

  xml_content = templatefile("./api/ecommerce-io/v2/get_transaction.xml.tpl", {
    wallet-basepath = local.wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "apim_v2_create_transactions_v2" {
  api_name            = "${local.project}-ecommerce-io-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_v2
  operation_id        = "newTransactionForIO"

  xml_content = templatefile("./api/ecommerce-io/v2/post_transactions.xml.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "apim_v2_io_wallets_by_user_v2" {
  api_name            = "${local.project}-ecommerce-io-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_v2
  operation_id        = "getWalletsByIdIOUser"

  xml_content = templatefile("./api/ecommerce-io/v2/_get_wallets_by_user_with_pm.xml.tpl", {
    ecommerce-hostname = local.ecommerce_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "apim_v2_io_get_all_payment_methods" {
  api_name            = "${local.project}-ecommerce-io-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_v2
  operation_id        = "getAllPaymentMethodsForIO"

  xml_content = templatefile("./api/ecommerce-io/v2/_get_payment_methods.xml.tpl", {
    enabled_payment_wallet_method_ids_pm = var.enabled_payment_wallet_method_ids_pm
  })
}
