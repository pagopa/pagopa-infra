##############
## Products ##
##############

module "apim_ecommerce_checkout_auth_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "ecommerce-checkout-auth"
  display_name = "Ecommerce for checkout pagoPA with authentication"
  description  = "Ecommerce pagoPA product dedicated to checkout pagoPA with authentication"

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


# pagopa-ecommerce APIs for checkout-auth
locals {
  apim_ecommerce_checkout_auth_api = {
    display_name          = "Ecommerce API for checkout pagoPA for authenticated flux"
    description           = "Ecommerce pagoPA API dedicated to checkout pagoPA for pagoPA payment with authentication"
    path                  = "ecommerce/checkout/auth"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "ecommerce_checkout_auth_api_v1" {
  name                = "${local.project}-ecommerce-checkout-auth-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_checkout_auth_api.display_name
  versioning_scheme   = "Segment"
}

# pagopa-ecommerce APIs for checkout-auth V1

module "apim_ecommerce_checkout_auth_api_v1" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-checkout-auth-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_checkout_auth_product.product_id]
  subscription_required = local.apim_ecommerce_checkout_auth_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_checkout_auth_api_v1.id
  api_version           = "v1"
  service_url           = local.apim_ecommerce_checkout_auth_api.service_url

  description  = local.apim_ecommerce_checkout_auth_api.description
  display_name = local.apim_ecommerce_checkout_auth_api.display_name
  path         = local.apim_ecommerce_checkout_auth_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-checkout-auth/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-checkout-auth/v1/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
    checkout_origin            = var.env_short == "d" ? "*" : "https://${var.dns_zone_checkout}.${var.external_domain}"
    checkout_ingress_hostname  = local.checkout_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "transaction_activation_request_v1" {
  depends_on          = [module.apim_ecommerce_checkout_auth_api_v1]
  api_name            = "${local.project}-checkout-auth-api-v1"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "newTransactionAuth"

  xml_content = templatefile("./api/ecommerce-checkout-auth/v1/_transaction_policy.xml.tpl", {
    pdv_api_base_path         = var.pdv_api_base_path
    checkout_ingress_hostname = local.checkout_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "get_payment_request_info_api_policy_v1" {
  api_name            = "${local.project}-checkout-auth-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getPaymentRequestInfoAuth"

  xml_content = file("./api/ecommerce-checkout-auth/v1/_payment_request_policy.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "post_payment_methods_v1" {
  api_name            = "${local.project}-checkout-auth-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getAllPaymentMethodsAuth"

  xml_content = file("./api/ecommerce-checkout-auth/v1/_post_payment_methods_policy.xml.tpl")
}
