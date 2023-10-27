##############
## Products ##
##############

module "apim_ecommerce_io_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.6.0"

  product_id   = "ecommerce-io"
  display_name = "eCommerce for IO App"
  description  = "eCommerce pagoPA product dedicated to IO App"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

# pagopa-ecommerce APIs for io
locals {
  apim_ecommerce_io_api = {
    display_name          = "eCommerce API for IO App"
    description           = "eCommerce pagoPA API dedicated to IO App for pagoPA payment"
    path                  = "ecommerce/io"
    subscription_required = true
    service_url           = null
  }

  apim_ecommerce_io_webview_pay = {
    display_name          = "eCommerce-PM web view for IO App"
    description           = "Web view designed to aid compatibility between eCommerce API for IO App and Payment Manager"
    path                  = "ecommerce/io-webview"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "ecommerce_io_api_v1" {
  name                = "${local.project}-ecommerce-io-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_io_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_io_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = "${local.project}-ecommerce-io-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_io_product.product_id]
  subscription_required = local.apim_ecommerce_io_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_io_api_v1.id
  api_version           = "v1"
  service_url           = local.apim_ecommerce_io_api.service_url

  description  = local.apim_ecommerce_io_api.description
  display_name = local.apim_ecommerce_io_api.display_name
  path         = local.apim_ecommerce_io_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-io/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-io/v1/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
  })
}

resource "azurerm_api_management_api_version_set" "ecommerce_io_webview_pay_v1" {
  name                = "${local.project}-io-api-webview-pay"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_io_webview_pay.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_io_webview_pay_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = "${local.project}-io-api-webiew-pay"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_io_product.product_id]
  subscription_required = local.apim_ecommerce_io_webview_pay.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_io_webview_pay_v1.id
  api_version           = "v1"
  service_url           = local.apim_ecommerce_io_webview_pay.service_url

  description  = local.apim_ecommerce_io_webview_pay.description
  display_name = local.apim_ecommerce_io_webview_pay.display_name
  path         = local.apim_ecommerce_io_webview_pay.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-io/v1/_webview_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-io/v1/pay-pm-webview.xml.tpl", {
    pm_webview_path = "${local.apim_hostname}/pp-restapi-CD/v3/webview/transactions/pay"
  })
}

data "azurerm_key_vault_secret" "ecommerce_io_sessions_jwt_secret" {
  name         = "sessions-jwt-secret"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "ecommerce_io_transaction_jwt_signing_key" {
  name                = "ecommerce-io-transaction-jwt-signing-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ecommerce-io-transaction-jwt-signing-key"
  value               = data.azurerm_key_vault_secret.ecommerce_io_sessions_jwt_secret.value
  secret              = true
}

resource "azurerm_api_management_api_operation_policy" "io_create_transaction" {
  api_name            = "${local.project}-ecommerce-io-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "newTransaction"

  xml_content = file("./api/ecommerce-io/v1/post_transactions.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "io_get_transaction_info" {
  api_name            = "${local.project}-ecommerce-io-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getTransactionInfo"

  xml_content = file("./api/ecommerce-io/v1/get_transaction.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "io_delete_transaction" {
  api_name            = "${local.project}-ecommerce-io-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "requestTransactionUserCancellation"

  xml_content = file("./api/ecommerce-io/v1/_validate_transactions_jwt_token.tpl")
}

resource "azurerm_api_management_api_operation_policy" "io_transaction_authorization_request" {
  api_name            = "${local.project}-ecommerce-io-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "requestTransactionAuthorization"

  xml_content = templatefile("./api/ecommerce-io/v1/_auth_request.xml.tpl", {
    webview_host = local.apim_hostname
    webview_path = "ecommerce/io-webview/v1/pay"
  })
}

resource "azurerm_api_management_api_operation_policy" "io_create_session" {
  api_name            = "${local.project}-ecommerce-io-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "newSessionToken"

  xml_content = file("./api/ecommerce-io/v1/_create_new_session.xml.tpl")
}