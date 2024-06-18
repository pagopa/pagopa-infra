##############
## Products ##
##############

module "apim_checkout_product" {
  count  = var.checkout_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.76.1"

  product_id   = "checkout"
  display_name = "checkout pagoPA"
  description  = "Product for checkout pagoPA"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/checkout/_base_policy.xml")
}

module "apim_checkout_auth_product" {
  count  = var.checkout_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.76.1"

  product_id   = "checkout-auth"
  display_name = "checkout auth  pagoPA"
  description  = "Product for checkout auth pagoPA"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/checkout/_base_policy.xml")
}

#####################################
## API checkout payment activation ##
#####################################
locals {
  apim_checkout_payment_activations_api = {
    display_name          = "Checkout 2.0 payment activations API"
    description           = "API to support payment activations"
    path                  = "checkout/payments"
    subscription_required = false
    service_url           = null
  }

  apim_checkout_payment_activations_auth_api = {
    display_name          = "Checkout payment activations auth API"
    description           = "Authenticated API to support payment activations"
    path                  = "checkout/auth/payments"
    subscription_required = true
    service_url           = null
  }
}

# Payment activation APIs (new)
resource "azurerm_api_management_api_version_set" "checkout_payment_activations_api" {
  name                = format("%s-checkout-payment-activations-api", local.parent_project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_checkout_payment_activations_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_payment_activations_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.76.1"

  name                  = format("%s-checkout-payment-activations-api", local.parent_project)
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_product[0].product_id]
  subscription_required = local.apim_checkout_payment_activations_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_payment_activations_api.id
  api_version           = "v1"
  service_url           = local.apim_checkout_payment_activations_api.service_url

  description  = local.apim_checkout_payment_activations_api.description
  display_name = local.apim_checkout_payment_activations_api.display_name
  path         = local.apim_checkout_payment_activations_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/checkout/checkout_payment_activations/v1/_swagger.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile(var.env_short == "d" ? "./api/checkout/checkout_payment_activations/v1/_base_policy_dev.xml.tpl" : "./api/checkout/checkout_payment_activations/v1/_base_policy.xml.tpl", {
    origin = format("https://%s.%s/", var.dns_zone_checkout, var.external_domain)
  })
}

resource "azurerm_api_management_api_operation_policy" "get_payment_info_api" {
  api_name            = format("%s-checkout-payment-activations-api-v1", local.parent_project)
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = "getPaymentInfo"

  xml_content = file("./api/checkout/checkout_payment_activations/v1/_recaptcha_check.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "activate_payment_api" {
  api_name            = format("%s-checkout-payment-activations-api-v1", local.parent_project)
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = "activatePayment"

  xml_content = file("./api/checkout/checkout_payment_activations/v1/_recaptcha_check.xml.tpl")
}

# Payment activation authenticated APIs
resource "azurerm_api_management_api_version_set" "checkout_payment_activations_auth_api" {
  name                = format("%s-checkout-payment-activations-auth-api", local.parent_project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_checkout_payment_activations_auth_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_payment_activations_api_auth_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.76.1"

  name                  = format("%s-checkout-payment-activations-auth-api", local.parent_project)
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_product[0].product_id, module.apim_checkout_auth_product[0].product_id]
  subscription_required = local.apim_checkout_payment_activations_auth_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_payment_activations_auth_api.id
  api_version           = "v1"
  service_url           = local.apim_checkout_payment_activations_auth_api.service_url

  description  = local.apim_checkout_payment_activations_auth_api.description
  display_name = local.apim_checkout_payment_activations_auth_api.display_name
  path         = local.apim_checkout_payment_activations_auth_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/checkout/checkout_payment_activations_auth/v1/_swagger.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = file("./api/checkout/checkout_payment_activations_auth/v1/_base_policy.xml.tpl")
}

# Payment activation v2 authenticated APIs
module "apim_checkout_payment_activations_api_auth_v2" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.76.1"

  name                  = format("%s-checkout-payment-activations-auth-api", local.parent_project)
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_product[0].product_id, module.apim_checkout_auth_product[0].product_id]
  subscription_required = local.apim_checkout_payment_activations_auth_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_payment_activations_auth_api.id
  api_version           = "v2"
  service_url           = local.apim_checkout_payment_activations_auth_api.service_url

  description  = local.apim_checkout_payment_activations_auth_api.description
  display_name = local.apim_checkout_payment_activations_auth_api.display_name
  path         = local.apim_checkout_payment_activations_auth_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/checkout/checkout_payment_activations_auth/v2/_swagger.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = file(var.env_short == "d" ? "./api/checkout/checkout_payment_activations_auth/v2/_base_policy_dev.xml.tpl" : "./api/checkout/checkout_payment_activations_auth/v2/_base_policy.xml.tpl")
}

# pagopa-proxy SOAP web service FespCdService
locals {
  apim_cd_info_wisp = {
    display_name          = "IO for Node WS"
    description           = "SOAP service used from Nodo to relay idPayment"
    path                  = "checkout/io-for-node/CdInfoWisp"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "cd_info_wisp" {
  name                = format("%s-cd-info-wisp", local.parent_project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_cd_info_wisp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_cd_info_wisp_v1" {
  name                  = format("%s-cd-info-wisp", local.parent_project)
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  subscription_required = local.apim_cd_info_wisp.subscription_required
  service_url           = local.apim_cd_info_wisp.service_url
  version_set_id        = azurerm_api_management_api_version_set.cd_info_wisp.id
  version               = "v1"
  revision              = "1"

  description  = local.apim_cd_info_wisp.description
  display_name = local.apim_cd_info_wisp.display_name
  path         = local.apim_cd_info_wisp.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/checkout/checkout_nodo_ws/v1/CdPerNodo.wsdl")
    wsdl_selector {
      service_name  = "FespCdService"
      endpoint_name = "FespCdPortType"
    }
  }
}

resource "azurerm_api_management_api_policy" "apim_cd_info_wisp_policy_v1" {
  api_name            = resource.azurerm_api_management_api.apim_cd_info_wisp_v1.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/checkout/checkout_nodo_ws/v1/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = var.ecommerce_ingress_hostname
  })
}

resource "azurerm_api_management_product_api" "apim_cd_info_wisp_product_v1" {
  product_id          = module.apim_checkout_product[0].product_id
  api_name            = resource.azurerm_api_management_api.apim_cd_info_wisp_v1.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

resource "azurerm_api_management_product_api" "apim_cd_info_wisp_product_v1_apim_for_node" {
  product_id          = "apim_for_node"
  api_name            = resource.azurerm_api_management_api.apim_cd_info_wisp_v1.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

######################################
## API checkout payment transaction ##
######################################
locals {
  apim_checkout_transactions_api = {
    # params for all api versions
    display_name          = "Checkout payment transaction API"
    description           = "API to support payment transaction"
    path                  = "api/checkout/payment-transactions"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "checkout_transactions_api" {
  count = var.checkout_enabled ? 1 : 0

  name                = format("%s-checkout-transactions-api", var.env_short)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_checkout_transactions_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_transactions_api_v1" {
  count = var.checkout_enabled ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.76.1"

  name                  = format("%s-checkout-transactions-api", var.env_short)
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_product[0].product_id]
  subscription_required = local.apim_checkout_transactions_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_transactions_api[0].id
  api_version           = "v1"
  service_url           = local.apim_checkout_transactions_api.service_url

  description  = local.apim_checkout_transactions_api.description
  display_name = local.apim_checkout_transactions_api.display_name
  path         = local.apim_checkout_transactions_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/checkout/checkout_transactions/v1/_swagger.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/checkout/checkout_transactions/v1/_base_policy.xml.tpl", {
    origin = format("https://%s.%s/", var.dns_zone_checkout, var.external_domain)
  })
}

# pagopa-ecommerce APIs for checkout
locals {
  apim_checkout_ecommerce_api = {
    # params for all api versions
    display_name          = "Checkout - ecommerce API"
    description           = "API for the payment transaction and payment instrument microservices of ecommerce pagoPA platform"
    path                  = "checkout/ecommerce"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "checkout_ecommerce_api_v1" {
  name                = "${local.parent_project}-checkout-ecommerce-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_checkout_ecommerce_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_ecommerce_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.76.1"

  name                  = "${local.parent_project}-checkout-ecommerce-api"
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_product[0].product_id]
  subscription_required = local.apim_checkout_ecommerce_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_ecommerce_api_v1.id
  api_version           = "v1"
  service_url           = local.apim_checkout_ecommerce_api.service_url

  description  = local.apim_checkout_ecommerce_api.description
  display_name = local.apim_checkout_ecommerce_api.display_name
  path         = local.apim_checkout_ecommerce_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/checkout/checkout_ecommerce/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/checkout/checkout_ecommerce/v1/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = var.ecommerce_ingress_hostname,
    checkout_origin            = var.env_short == "d" || var.env_short == "u" ? "*" : "https://${var.dns_zone_checkout}.${var.external_domain}"
  })
}

resource "azurerm_api_management_api_operation_policy" "get_payment_request_info_api" {
  api_name            = "${local.parent_project}-checkout-ecommerce-api-v1"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = "getPaymentRequestInfo"

  xml_content = file("./api/checkout/checkout_ecommerce/v1/_recaptcha_check.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "transaction_authorization_request" {
  api_name            = "${local.parent_project}-checkout-ecommerce-api-v1"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = "requestTransactionAuthorization"

  xml_content = templatefile("./api/checkout/checkout_ecommerce/v1/_auth_request.xml.tpl", {
    ecommerce_xpay_psps_list = var.ecommerce_xpay_psps_list
    ecommerce_vpos_psps_list = var.ecommerce_vpos_psps_list
  })
}

###############
## APIM Logs ##
###############

locals {
  api_verbose_log = [
    module.apim_checkout_payment_activations_api_auth_v1.name,
    module.apim_checkout_payment_activations_api_auth_v2.name,
    module.apim_checkout_payment_activations_api_v1.name,
  ]
}

# api verbose log with request/response body
resource "azurerm_api_management_api_diagnostic" "apim_logs" {
  for_each = toset(local.api_verbose_log)

  identifier               = "applicationinsights"
  resource_group_name      = data.azurerm_resource_group.rg_api.name
  api_management_name      = data.azurerm_api_management.apim.name
  api_name                 = each.key
  api_management_logger_id = var.apim_logger_resource_id

  sampling_percentage       = 100
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "verbose"
  http_correlation_protocol = "W3C"

  frontend_request {
    body_bytes = 8192
  }

  frontend_response {
    body_bytes = 8192
  }

  backend_request {
    body_bytes = 8192
  }

  backend_response {
    body_bytes = 8192
  }
}

resource "azurerm_api_management_named_value" "pagopa_appservice_proxy_url_value" {
  name                = "pagopa-appservice-proxy-url"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "pagopa-appservice-proxy-url"
  value               = format("https://%s", module.pagopa_proxy_app_service.default_site_hostname)
}
