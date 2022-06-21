##############
## Products ##
##############

module "apim_ecommerce_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "ecommerce"
  display_name = "ecommerce pagoPA"
  description  = "Product for ecommerce pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

##############################
## API transactions service ##
##############################
locals {
  apim_ecommerce_transactions_service_api = {
    display_name          = "ecommerce pagoPA - transactions service API"
    description           = "API to support transactions service"
    path                  = "ecommerce/transactions-service"
    subscription_required = false
    service_url           = null
  }
}

# Transactions service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_transactions_service_api" {
  name                = format("%s-transactions-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_transactions_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_transactions_service_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-transactions-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_transactions_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_transactions_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_transactions_service_api.description
  display_name = local.apim_ecommerce_transactions_service_api.display_name
  path         = local.apim_ecommerce_transactions_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_transactions_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-transactions-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-transactions-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

#####################################
## API payment instruments service ##
#####################################
locals {
  apim_ecommerce_payment_instruments_service_api = {
    display_name          = "ecommerce pagoPA - payment instruments service API"
    description           = "API to support payment instruments in ecommerce"
    path                  = "ecommerce/payment-instruments-service"
    subscription_required = false
    service_url           = null
  }
}

# Payment instruments service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_payment_instruments_service_api" {
  name                = format("%s-payment-instruments-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_payment_instruments_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_payment_instruments_service_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-payment-instruments-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_payment_instruments_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_payment_instruments_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_payment_instruments_service_api.description
  display_name = local.apim_ecommerce_payment_instruments_service_api.display_name
  path         = local.apim_ecommerce_payment_instruments_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_payment_instruments_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-payment-instruments-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-payment-instruments-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

##########################
## API sessions service ##
##########################
locals {
  apim_ecommerce_sessions_service_api = {
    display_name          = "ecommerce pagoPA - sessions service API"
    description           = "API to support sessions in ecommerce"
    path                  = "ecommerce/payment-sessions-service"
    subscription_required = false
    service_url           = null
  }
}

# Sessions service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_sessions_service_api" {
  name                = format("%s-sessions-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_sessions_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_sessions_service_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-sessions-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_sessions_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_sessions_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_sessions_service_api.description
  display_name = local.apim_ecommerce_sessions_service_api.display_name
  path         = local.apim_ecommerce_sessions_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_sessions_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-sessions-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-sessions-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}