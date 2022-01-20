##############
## Products ##
##############

module "apim_checkout_product" {
  count  = var.checkout_enabled ? 1 : 0
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
    display_name          = "Checkout 2.0 payment activations API"
    description           = "API to support payment activations"
    path                  = "checkout/payments"
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
  name                = format("%s-checkout-payment-activations-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_checkout_payment_activations_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_payment_activations_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.0.23"

  name                  = format("%s-checkout-payment-activations-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/checkout/checkout_payment_activations/v1/_base_policy.xml.tpl", {
    origin = format("https://%s.%s/", var.dns_zone_checkout, var.external_domain)
  })
}

resource "azurerm_api_management_api_operation_policy" "get_payment_info_api" {
  api_name            = format("%s-checkout-payment-activations-api-v1", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = "getPaymentInfo"

  xml_content = file("./api/checkout/checkout_payment_activations/v1/_recaptcha_check.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "get_activation_status_api" {
  api_name            = format("%s-checkout-payment-activations-api-v1", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = "getActivationStatus"

  xml_content = file("./api/checkout/checkout_payment_activations/v1/_idpayment_check.xml.tpl")
}

# pagopa-proxy SOAP web service FespCdService
locals {
  apim_cd_info_wisp = {
    display_name          = "Checkout CdInfoWisp"
    description           = "SOAP service used from Nodo to relay idPayment"
    path                  = "api/checkout/CdInfoWisp"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "cd_info_wisp" {
  name                = format("%s-cd-info-wisp", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_cd_info_wisp.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_cd_info_wisp_v1" {
  name                  = format("%s-cd-info-wisp", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/checkout/checkout_nodo_ws/v1/_base_policy.xml.tpl", {
    Nodo-Ip-Filter = var.nodo_ip_filter
  })
}

resource "azurerm_api_management_product_api" "apim_cd_info_wisp_product_v1" {
  product_id          = module.apim_checkout_product[0].product_id
  api_name            = resource.azurerm_api_management_api.apim_cd_info_wisp_v1.name
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
