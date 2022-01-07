##############
## Products ##
##############

module "apim_checkout_product" {
  count  = var.checkout_enabled || var.pagopa_proxy_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "checkout"
  display_name = "checkout pagoPA"
  description  = "Product for checkout pagoPA"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/checkout/_base_policy.xml")
}

#####################################
## API checkout payment activation ##
#####################################
locals {
  apim_checkout_payments_api = {
    # params for all api versions
    display_name          = "Checkout payment activation API"
    description           = "API to support payment activation"
    path                  = "api/checkout/payments"
    subscription_required = false
    service_url           = null
  }

  apim_checkout_payment_activations_api = {
    display_name          = "Checkout payment activations API [new]"
    description           = "API to support payment activation [new]"
    path                  = "api/checkout/activations"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "checkout_payments_api" {
  count = var.checkout_enabled ? 1 : 0

  name                = format("%s-checkout-payments-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_checkout_payments_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_payments_api_v1" {
  count = var.checkout_enabled ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-checkout-payments-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_product[0].product_id]
  subscription_required = local.apim_checkout_payments_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_payments_api[0].id
  api_version           = "v1"
  service_url           = local.apim_checkout_payments_api.service_url

  description  = local.apim_checkout_payments_api.description
  display_name = local.apim_checkout_payments_api.display_name
  path         = local.apim_checkout_payments_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/checkout/checkout_payments/v1/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/checkout/checkout_payments/v1/_base_policy.xml.tpl", {
    origin = format("https://%s.%s/", var.dns_zone_checkout, var.external_domain)
  })
}

# Payment activation APIs (new)
resource "azurerm_api_management_api_version_set" "checkout_payment_activations_api" {
  count = var.pagopa_proxy_enabled ? 1 : 0

  name                = format("%s-checkout-payment-activations-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_checkout_payment_activations_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_payment_activations_api_v1" {
  count = var.pagopa_proxy_enabled ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.0.23"

  name                  = format("%s-checkout-payment-activations-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_product[0].product_id]
  subscription_required = local.apim_checkout_payment_activations_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_payment_activations_api[0].id
  api_version           = "v1"
  service_url           = local.apim_checkout_payment_activations_api.service_url

  description  = local.apim_checkout_payment_activations_api.description
  display_name = local.apim_checkout_payment_activations_api.display_name
  path         = local.apim_checkout_payment_activations_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/checkout/checkout_payment_activations/v1/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/checkout/checkout_payment_activations/v1/_base_policy.xml.tpl", {
    origin = format("https://%s.%s/", var.dns_zone_checkout, var.external_domain)
  })
}

# pagopa-proxy SOAP web service FespCdService
locals {
  apim_proxy_nodo_ws = {
    display_name          = "pagopa-proxy FespCdService"
    description           = "SOAP service used from Nodo to relay idPayment"
    path                  = "api/checkout/activations"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "proxy_nodo_ws" {
  count = var.pagopa_proxy_enabled ? 1 : 0

  name                = format("%s-proxy-nodo-ws", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_proxy_nodo_ws.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_proxy_nodo_ws_v1" {
  count = var.pagopa_proxy_enabled ? 1 : 0

  name                  = format("%s-proxy-nodo-ws", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_proxy_nodo_ws.subscription_required
  service_url           = local.apim_proxy_nodo_ws.service_url
  version_set_id        = azurerm_api_management_api_version_set.proxy_nodo_ws[0].id
  version               = "v1"
  revision              = "1"

  description  = local.apim_proxy_nodo_ws.description
  display_name = local.apim_proxy_nodo_ws.display_name
  path         = local.apim_proxy_nodo_ws.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl-link"
    content_value  = "https://raw.githubusercontent.com/pagopa/io-pagopa-proxy/v0.20.1-RELEASE/src/wsdl/CdPerNodo.wsdl"
  }
}

resource "azurerm_api_management_api_policy" "apim_proxy_nodo_ws_policy_v1" {
  count = var.pagopa_proxy_enabled ? 1 : 0

  api_name            = resource.azurerm_api_management_api.apim_proxy_nodo_ws_v1[0].name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/checkout/checkout_nodo_ws/v1/_base_policy.xml.tpl", {
    origin = format("https://%s.%s/", var.dns_zone_checkout, var.external_domain)
  })
}

resource "azurerm_api_management_product_api" "apim_proxy_nodo_ws_product_v1" {
  count = var.pagopa_proxy_enabled ? 1 : 0

  product_id          = module.apim_checkout_product[0].product_id
  api_name            = resource.azurerm_api_management_api.apim_proxy_nodo_ws_v1[0].name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
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
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_checkout_transactions_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_transactions_api_v1" {
  count = var.checkout_enabled ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-checkout-transactions-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/checkout/checkout_transactions/v1/_base_policy.xml.tpl", {
    origin = format("https://%s.%s/", var.dns_zone_checkout, var.external_domain)
  })
}
