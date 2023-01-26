##############
## Products ##
##############

module "apim_ecommerce_checkout_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "ecommerce-checkout"
  display_name = "Ecommerce for checkout pagoPA"
  description  = "Ecommerce pagoPA product dedicated to checkout pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

# pagopa-ecommerce APIs for checkout
locals {
  apim_ecommerce_checkout_api = {
    display_name          = "Ecommerce API for checkout pagoPA"
    description           = "Ecommerce pagoPA API dedicated to checkout pagoPA for pagoPA payment"
    path                  = "ecommerce/checkout"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "ecommerce_checkout_api_v1" {
  name                = "${local.project}-ecommerce-checkout-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_checkout_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_checkout_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = "${local.project}-ecommerce-checkout-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_checkout_product.product_id]
  subscription_required = local.apim_ecommerce_checkout_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_checkout_api_v1.id
  api_version           = "v1"
  service_url           = local.apim_ecommerce_checkout_api.service_url

  description  = local.apim_ecommerce_checkout_api.description
  display_name = local.apim_ecommerce_checkout_api.display_name
  path         = local.apim_ecommerce_checkout_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-checkout/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-checkout/v1/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
    checkout_origin            = var.env_short == "d" ? "*" : "https://${var.dns_zone_checkout}.${var.external_domain}"
  })
}

data "azurerm_key_vault_secret" "ecommerce_checkout_sessions_jwt_secret" {
  name         = "sessions-jwt-secret"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "ecommerce_checkout_transaction_jwt_signing_key" {
  name                = "ecommerce-checkout-transaction-jwt-signing-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ecommerce-checkout-transaction-jwt-signing-key"
  value               = data.azurerm_key_vault_secret.ecommerce_checkout_sessions_jwt_secret.value
  secret              = true
}

resource "azurerm_api_management_api_operation_policy" "get_payment_request_info_api" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getPaymentRequestInfo"

  xml_content = file("./api/ecommerce-checkout/v1/_recaptcha_check.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "transaction_authorization_request" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "requestTransactionAuthorization"

  xml_content = templatefile("./api/ecommerce-checkout/v1/_auth_request.xml.tpl", {
    ecommerce_xpay_psps_list = var.ecommerce_xpay_psps_list
    ecommerce_vpos_psps_list = var.ecommerce_vpos_psps_list
  })
}


resource "azurerm_api_management_api_operation_policy" "get_transaction_info" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getTransactionInfo"

  xml_content = file("./api/ecommerce-transactions-service/v1/_validate_transactions_jwt_token.tpl")
}
