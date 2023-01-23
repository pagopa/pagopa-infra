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

data "azurerm_key_vault_secret" "sessions-jwt-secret" {
  name         = "sessions-jwt-secret"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "transaction_jwt_signing_key" {
  name                = "transaction-jwt-signing-key"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "transaction-jwt-signing-key"
  value               = data.azurerm_key_vault_secret.sessions-jwt-secret.value
  secret              = true
}

resource "azurerm_api_management_api_operation_policy" "transaction_validate_jwt_get_transaction_info" {
  api_name            = "${local.project}-checkout-ecommerce-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "getTransactionInfo"

  xml_content = file("./api/ecommerce-transactions-service/v1/_validate_transactions_jwt_token.tpl")
}

###########################################
## API transaction auth requests service ##
###########################################
locals {
  apim_ecommerce_transaction_auth_requests_service_api = {
    display_name          = "ecommerce pagoPA - transaction auth requests service API"
    description           = "API to support transaction auth requests service"
    path                  = "ecommerce/transaction-auth-requests-service"
    subscription_required = true
    service_url           = null
  }
}

# Transaction auth request service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_transaction_auth_requests_service_api" {
  name                = format("%s-transaction-auth-requests-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_transaction_auth_requests_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_transaction_auth_requests_service_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-transaction-auth-requests-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_transaction_auth_requests_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_transaction_auth_requests_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_transaction_auth_requests_service_api.description
  display_name = local.apim_ecommerce_transaction_auth_requests_service_api.display_name
  path         = local.apim_ecommerce_transaction_auth_requests_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_transaction_auth_requests_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-transaction-auth-requests-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-transaction-auth-requests-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

#####################################
## API transaction results service ##
#####################################
locals {
  apim_ecommerce_transaction_results_service_api = {
    display_name          = "ecommerce pagoPA - transaction results service API"
    description           = "API to support Nodo.sendPaymentResult"
    path                  = "ecommerce/transaction-results-service"
    subscription_required = true
    service_url           = null
  }
}

# Transaction results service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_transaction_results_service_api" {
  name                = format("%s-transaction-results-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_transaction_results_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_transaction_results_service_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-transaction-results-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_transaction_results_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_transaction_results_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_transaction_results_service_api.description
  display_name = local.apim_ecommerce_transaction_results_service_api.display_name
  path         = local.apim_ecommerce_transaction_results_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_transaction_results_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-transaction-results-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-transaction-results-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

#################################################
## API payment request service                 ##
#################################################
locals {
  apim_ecommerce_payment_requests_service_api = {
    display_name          = "ecommerce pagoPA - payment requests API"
    description           = "API to support payment requests service"
    path                  = "ecommerce/payment-requests-service"
    subscription_required = true
    service_url           = null
  }
}

# Payment requests service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_payment_requests_service_api" {
  name                = format("%s-payment-requests-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_payment_requests_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_payment_requests_service_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-payment-requests-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_payment_requests_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_payment_requests_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_payment_requests_service_api.description
  display_name = local.apim_ecommerce_payment_requests_service_api.display_name
  path         = local.apim_ecommerce_payment_requests_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_payment_requests_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-payment-requests-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-payment-requests-service/v1/_base_policy.xml.tpl", {
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
    path                  = "ecommerce/sessions-service"
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

##############################
## API notifications service ##
##############################
locals {
  apim_pagopa_notifications_service_api = {
    display_name          = "pagoPA ecommerce - notifications service API"
    description           = "API to support notifications service"
    path                  = "ecommerce/notifications-service"
    subscription_required = true
    service_url           = null
  }
}

# Notifications service APIs
resource "azurerm_api_management_api_version_set" "pagopa_notifications_service_api" {
  name                = format("%s-notifications-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pagopa_notifications_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pagopa_notifications_service_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-notifications-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_pagopa_notifications_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_notifications_service_api.id
  api_version           = "v1"

  description  = local.apim_pagopa_notifications_service_api.description
  display_name = local.apim_pagopa_notifications_service_api.display_name
  path         = local.apim_pagopa_notifications_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_notifications_service_api.service_url

  content_format = "swagger-json"
  content_value = templatefile("./api/ecommerce-notifications-service/v1/_swagger.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-notifications-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}