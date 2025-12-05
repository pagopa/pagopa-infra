##############
## Products ##
##############

module "apim_ecommerce_checkout_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

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

##################
## Named value  ##
##################

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

data "azurerm_key_vault_secret" "ecommerce_for_checkout_google_recaptcha_secret" {
  name         = "ecommerce-for-checkout-google-recaptcha-secret"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "ecommerce_for_checkout_google_recaptcha_secret_named_value" {
  name                = "ecommerce-for-checkout-google-recaptcha-secret"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "ecommerce-for-checkout-google-recaptcha-secret"
  value               = data.azurerm_key_vault_secret.ecommerce_for_checkout_google_recaptcha_secret.value
  secret              = true
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
  source = "./.terraform/modules/__v4__/api_management_api"

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
    ecommerce_ingress_hostname = local.ecommerce_hostname,
    origins                    = var.env_short == "d" ? "<origin>*</origin>" : "<origin>${local.checkout_origin}</origin><origin>${local.ecommerce_origin}</origin>"
  })
}

resource "azurerm_api_management_api_operation_policy" "get_transaction_info" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getTransactionInfo"

  xml_content = templatefile("./api/ecommerce-checkout/v1/_validate_transactions_jwt_token.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "get_transaction_info_v2" {
  api_name            = "${local.project}-ecommerce-checkout-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getTransactionInfo"

  xml_content = templatefile("./api/ecommerce-checkout/v2/_validate_transactions_jwt_token.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "get_transaction_outcomes" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getTransactionOutcomes"

  xml_content = templatefile("./api/ecommerce-checkout/v1/_validate_transactions_jwt_token.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "delete_transaction" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "requestTransactionUserCancellation"

  xml_content = templatefile("./api/ecommerce-checkout/v1/_validate_transactions_jwt_token.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "get_fees" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "calculateFees"

  xml_content = templatefile("./api/ecommerce-checkout/v1/_validate_transactions_jwt_token.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "get_card_data_information" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getSessionPaymentMethod"

  xml_content = templatefile("./api/ecommerce-checkout/v1/_validate_jwt_with_order_and_transaction_id.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "get_payment_request_info_api_policy" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getPaymentRequestInfo"

  xml_content = file("./api/ecommerce-checkout/v1/_payment_request_policy.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "transaction_authorization_request" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "requestTransactionAuthorization"

  xml_content = templatefile("./api/ecommerce-checkout/v1/_auth_request.xml.tpl", {
    ecommerce_xpay_psps_list   = var.ecommerce_xpay_psps_list
    ecommerce_vpos_psps_list   = var.ecommerce_vpos_psps_list
    ecommerce_ingress_hostname = local.ecommerce_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "get_carts_redirect" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "GetCartsRedirect"

  xml_content = templatefile("./api/ecommerce-checkout/v1/_carts_redirect.xml.tpl", {
    checkout_hostname = "${var.dns_zone_checkout}.${var.external_domain}"
  })
}

resource "azurerm_api_management_api_operation_policy" "transaction_activation_request" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "newTransaction"

  xml_content = file("./api/ecommerce-checkout/v1/_transaction_policy.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "create_session" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "createSession"

  xml_content = file("./api/ecommerce-checkout/v1/_post_sessions.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "get_method_testing" {
  api_name            = "${local.project}-ecommerce-checkout-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getAllPaymentMethods"

  xml_content = file("./api/ecommerce-checkout/v1/_methods_testing_policy.xml.tpl")
}

# pagopa-ecommerce APIs for checkout V2

module "apim_ecommerce_checkout_api_v2" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-ecommerce-checkout-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_checkout_product.product_id]
  subscription_required = local.apim_ecommerce_checkout_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_checkout_api_v1.id
  api_version           = "v2"
  service_url           = local.apim_ecommerce_checkout_api.service_url

  description  = local.apim_ecommerce_checkout_api.description
  display_name = local.apim_ecommerce_checkout_api.display_name
  path         = local.apim_ecommerce_checkout_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-checkout/v2/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-checkout/v2/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
    checkout_origin            = var.env_short == "d" ? "*" : "https://${var.dns_zone_checkout}.${var.external_domain}"
  })
}

resource "azurerm_api_management_api_operation_policy" "transaction_activation_request_v2" {
  depends_on          = [module.apim_ecommerce_checkout_api_v2]
  api_name            = "${local.project}-ecommerce-checkout-api-v2"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "newTransaction"

  xml_content = templatefile("./api/ecommerce-checkout/v2/_transaction_policy.xml.tpl", {
    pdv_api_base_path = var.pdv_api_base_path
  })
}

resource "azurerm_api_management_api_operation_policy" "get_fees_v2" {
  api_name            = "${local.project}-ecommerce-checkout-api-v2"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "calculateFees"

  xml_content = templatefile("./api/ecommerce-checkout/v2/_calculate_fees_policy.xml.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
    wallet_ingress_hostname = local.wallet_hostname
  })
}

# pagopa-ecommerce APIs for checkout V3 (authenticated)

module "apim_ecommerce_checkout_api_v3" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-checkout-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_checkout_product.product_id]
  subscription_required = local.apim_ecommerce_checkout_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_checkout_api_v1.id
  api_version           = "v3"
  service_url           = local.apim_ecommerce_checkout_api.service_url

  description  = local.apim_ecommerce_checkout_api.description
  display_name = local.apim_ecommerce_checkout_api.display_name
  path         = local.apim_ecommerce_checkout_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-checkout/v3/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-checkout/v3/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
    checkout_origin            = var.env_short == "d" ? "*" : "https://${var.dns_zone_checkout}.${var.external_domain}"
    checkout_ingress_hostname  = local.checkout_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "transaction_activation_request_v3" {
  depends_on          = [module.apim_ecommerce_checkout_api_v3]
  api_name            = "${local.project}-checkout-api-v3"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "newTransactionV3"

  xml_content = templatefile("./api/ecommerce-checkout/v3/_transaction_policy.xml.tpl", {
    pdv_api_base_path         = var.pdv_api_base_path
    checkout_ingress_hostname = local.checkout_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "get_payment_request_info_api_policy_v3" {
  api_name            = "${local.project}-checkout-api-v3"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getPaymentRequestInfoV3"

  xml_content = file("./api/ecommerce-checkout/v3/_payment_request_policy.xml.tpl")
}

# pagopa-ecommerce APIs for checkout V4 (authenticated)

module "apim_ecommerce_checkout_api_v4" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-checkout-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_checkout_product.product_id]
  subscription_required = local.apim_ecommerce_checkout_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_checkout_api_v1.id
  api_version           = "v4"
  service_url           = local.apim_ecommerce_checkout_api.service_url

  description  = local.apim_ecommerce_checkout_api.description
  display_name = local.apim_ecommerce_checkout_api.display_name
  path         = local.apim_ecommerce_checkout_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-checkout/v4/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-checkout/v4/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
    checkout_origin            = var.env_short == "d" ? "*" : "https://${var.dns_zone_checkout}.${var.external_domain}"
    checkout_ingress_hostname  = local.checkout_hostname
  })
}
