##############
## Groups ##
##############

resource "azurerm_api_management_group" "ecommerce-methods-full-read" {
  name                = "ecommerce-methods-full-read"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "Payment method full access to read all client"
}

##############
## Products ##
##############

module "apim_ecommerce_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

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

module "apim_ecommerce_payment_methods_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "ecommerce-payment-methods"
  display_name = "ecommerce pagoPA payment methods"
  description  = "Product for ecommerce pagoPA payment methods service"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

module "apim_ecommerce_helpdesk_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "ecommerce-helpdesk"
  display_name = "ecommerce pagoPA helpdesk service"
  description  = "Product for ecommerce pagoPA helpdesk service"

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
    subscription_required = true
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
  source = "./.terraform/modules/__v3__/api_management_api"

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

module "apim_ecommerce_transactions_service_api_v2" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-transactions-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_transactions_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_transactions_service_api.id
  api_version           = "v2"

  description  = local.apim_ecommerce_transactions_service_api.description
  display_name = local.apim_ecommerce_transactions_service_api.display_name
  path         = local.apim_ecommerce_transactions_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_transactions_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-transactions-service/v2/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-transactions-service/v2/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
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
  source = "./.terraform/modules/__v3__/api_management_api"

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

module "apim_ecommerce_transaction_auth_requests_service_api_v2" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-transaction-auth-requests-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_transaction_auth_requests_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_transaction_auth_requests_service_api.id
  api_version           = "v2"

  description  = local.apim_ecommerce_transaction_auth_requests_service_api.description
  display_name = local.apim_ecommerce_transaction_auth_requests_service_api.display_name
  path         = local.apim_ecommerce_transaction_auth_requests_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_transaction_auth_requests_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-transaction-auth-requests-service/v2/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-transaction-auth-requests-service/v2/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "auth_request_gateway_policy" {
  api_name            = module.apim_ecommerce_transaction_auth_requests_service_api_v1.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "updateTransactionAuthorization"

  xml_content = file("./api/ecommerce-transaction-auth-requests-service/v1/_auth_request_gateway_policy.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "auth_request_gateway_policy_v2" {
  api_name            = module.apim_ecommerce_transaction_auth_requests_service_api_v2.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "updateTransactionAuthorization"

  xml_content = file("./api/ecommerce-transaction-auth-requests-service/v2/_auth_request_gateway_policy.xml.tpl")
}

#####################################
## API transaction user receipts service ##
#####################################
locals {
  apim_ecommerce_transaction_user_receipts_service_api = {
    display_name          = "ecommerce pagoPA - transaction user receipts service API"
    description           = "API to support Nodo.sendPaymentResult"
    path                  = "ecommerce/transaction-user-receipts-service"
    subscription_required = true
    service_url           = null
  }
}

# Transaction user receipts service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_transaction_user_receipts_service_api" {
  name                = format("%s-transaction-user-receipts-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_transaction_user_receipts_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_transaction_user_receipts_service_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-transaction-user-receipts-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_transaction_user_receipts_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_transaction_user_receipts_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_transaction_user_receipts_service_api.description
  display_name = local.apim_ecommerce_transaction_user_receipts_service_api.display_name
  path         = local.apim_ecommerce_transaction_user_receipts_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_transaction_user_receipts_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-transaction-user-receipts-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-transaction-user-receipts-service/v1/_base_policy.xml.tpl", {
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
  source = "./.terraform/modules/__v3__/api_management_api"

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
## API payment methods service ##
#####################################
locals {
  apim_ecommerce_payment_methods_service_api = {
    display_name          = "ecommerce pagoPA - payment methods service API"
    description           = "API to support payment methods in ecommerce"
    path                  = "ecommerce/payment-methods-service"
    subscription_required = true
    service_url           = null
  }
}

# Payment methods service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_payment_methods_service_api" {
  name                = format("%s-payment-methods-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_payment_methods_service_api.display_name
  versioning_scheme   = "Segment"
}



module "apim_ecommerce_payment_methods_service_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-payment-methods-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id, module.apim_ecommerce_payment_methods_product.product_id]
  subscription_required = local.apim_ecommerce_payment_methods_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_payment_methods_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_payment_methods_service_api.description
  display_name = local.apim_ecommerce_payment_methods_service_api.display_name
  path         = local.apim_ecommerce_payment_methods_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_payment_methods_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-payment-methods-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-payment-methods-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

module "apim_ecommerce_payment_methods_service_api_v2" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-payment-methods-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id, module.apim_ecommerce_payment_methods_product.product_id]
  subscription_required = local.apim_ecommerce_payment_methods_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_payment_methods_service_api.id
  api_version           = "v2"

  description  = local.apim_ecommerce_payment_methods_service_api.description
  display_name = local.apim_ecommerce_payment_methods_service_api.display_name
  path         = local.apim_ecommerce_payment_methods_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_payment_methods_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-payment-methods-service/v2/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-payment-methods-service/v2/_base_policy.xml.tpl", {
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

data "azurerm_key_vault_secret" "ecommerce_notification_service_primary_api_key" {
  name         = "ecommerce-notification-service-primary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "ecommerce_notification_service_secondary_api_key" {
  name         = "ecommerce-notification-service-secondary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "ecommerce_notification_service_api_key_value" {
  name                = "ecommerce-notification-service-api-key-value"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ecommerce-notification-service-api-key-value"
  value               = var.ecommerce_notification_service_api_key_use_primary ? data.azurerm_key_vault_secret.ecommerce_notification_service_primary_api_key.value : data.azurerm_key_vault_secret.ecommerce_notification_service_secondary_api_key.value
  secret              = true
}

module "apim_pagopa_notifications_service_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

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

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-notifications-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-notifications-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

##############################
## API ecommerce helpdesk service ##
##############################
locals {
  apim_pagopa_ecommerce_helpdesk_service_api = {
    display_name          = "pagoPA ecommerce - helpdesk service API"
    description           = "API to support helpdesk service"
    path                  = "ecommerce/helpdesk-service"
    subscription_required = true
    service_url           = null
  }
}

# helpdesk service APIs
resource "azurerm_api_management_api_version_set" "pagopa_ecommerce_helpdesk_service_api" {
  name                = "${local.project}-helpdesk-service-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pagopa_ecommerce_helpdesk_service_api.display_name
  versioning_scheme   = "Segment"
}


#helpdesk api for ecommerce
module "apim_pagopa_ecommerce_helpdesk_service_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-helpdesk-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id, module.apim_ecommerce_helpdesk_product.product_id]
  subscription_required = local.apim_pagopa_ecommerce_helpdesk_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_ecommerce_helpdesk_service_api.id
  api_version           = "v1"

  description  = local.apim_pagopa_ecommerce_helpdesk_service_api.description
  display_name = local.apim_pagopa_ecommerce_helpdesk_service_api.display_name
  path         = local.apim_pagopa_ecommerce_helpdesk_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_ecommerce_helpdesk_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-helpdesk-api/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-helpdesk-api/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "helpdesk_pm_search_bulk" {
  api_name            = "${local.project}-helpdesk-service-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "pmSearchBulkTransaction"

  xml_content = file("./api/ecommerce-helpdesk-api/v1/_bulk_search.xml.tpl")
}

#helpdesk api V2 for ecommerce
module "apim_pagopa_ecommerce_helpdesk_service_api_v2" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-helpdesk-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id, module.apim_ecommerce_helpdesk_product.product_id]
  subscription_required = local.apim_pagopa_ecommerce_helpdesk_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_ecommerce_helpdesk_service_api.id
  api_version           = "v2"

  description  = local.apim_pagopa_ecommerce_helpdesk_service_api.description
  display_name = local.apim_pagopa_ecommerce_helpdesk_service_api.display_name
  path         = local.apim_pagopa_ecommerce_helpdesk_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_ecommerce_helpdesk_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-helpdesk-api/v2/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-helpdesk-api/v2/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "helpdesk_pgs_xpay" {
  api_name            = "${local.project}-helpdesk-service-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "pgsGetXpayAuthorization"

  xml_content = file("./api/ecommerce-helpdesk-api/v1/_pgs_search.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "helpdesk_pgs_vpos" {
  api_name            = "${local.project}-helpdesk-service-api-v1"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "pgsGetVposAuthorization"

  xml_content = file("./api/ecommerce-helpdesk-api/v1/_pgs_search.xml.tpl")
}

##############################
## API ecommerce technical helpdesk service ##
##############################
locals {
  apim_pagopa_ecommerce_technical_helpdesk_service_api = {
    display_name          = "pagoPA ecommerce - technical helpdesk service API"
    description           = "API to technical helpdesk support"
    path                  = "technical-support/ecommerce/helpdesk-service"
    subscription_required = true
    service_url           = null
  }
}

# ecommerce technical helpdesk service APIs
resource "azurerm_api_management_api_version_set" "pagopa_ecommerce_technical_helpdesk_service_api" {
  name                = "${local.project}-technical-helpdesk-service-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_pagopa_ecommerce_technical_helpdesk_service_api.display_name
  versioning_scheme   = "Segment"
}


#fetch technical support api product APIM product
data "azurerm_api_management_product" "technical_support_api_product" {
  product_id          = "technical_support_api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}


# technical helpdesk api for ecommerce
module "apim_pagopa_ecommerce_technical_helpdesk_service_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-technical-helpdesk-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [data.azurerm_api_management_product.technical_support_api_product.product_id]
  subscription_required = local.apim_pagopa_ecommerce_technical_helpdesk_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_ecommerce_technical_helpdesk_service_api.id
  api_version           = "v1"

  description  = local.apim_pagopa_ecommerce_technical_helpdesk_service_api.description
  display_name = local.apim_pagopa_ecommerce_technical_helpdesk_service_api.display_name
  path         = local.apim_pagopa_ecommerce_technical_helpdesk_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_ecommerce_technical_helpdesk_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-technical-helpdesk-api/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-technical-helpdesk-api/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}


module "apim_pagopa_ecommerce_technical_helpdesk_service_api_v2" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-technical-helpdesk-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [data.azurerm_api_management_product.technical_support_api_product.product_id]
  subscription_required = local.apim_pagopa_ecommerce_technical_helpdesk_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pagopa_ecommerce_technical_helpdesk_service_api.id
  api_version           = "v2"

  description  = local.apim_pagopa_ecommerce_technical_helpdesk_service_api.description
  display_name = local.apim_pagopa_ecommerce_technical_helpdesk_service_api.display_name
  path         = local.apim_pagopa_ecommerce_technical_helpdesk_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_pagopa_ecommerce_technical_helpdesk_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-technical-helpdesk-api/v2/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-technical-helpdesk-api/v2/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

##############################
## API user stats service  ##
##############################
locals {
  apim_ecommerce_user_stats_service_api = {
    display_name          = "ecommerce pagoPA - user stats API"
    description           = "API for handle user stats for transactions made on eCommerce"
    path                  = "ecommerce/user-stats-service"
    subscription_required = true
    service_url           = null
  }
}

# User stats APIs
resource "azurerm_api_management_api_version_set" "ecommerce_user_stats_service_api" {
  name                = format("%s-user-stats-service-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_user_stats_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_user_stats_service_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-user-stats-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_product.product_id]
  subscription_required = local.apim_ecommerce_user_stats_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_user_stats_service_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_user_stats_service_api.description
  display_name = local.apim_ecommerce_user_stats_service_api.display_name
  path         = local.apim_ecommerce_user_stats_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_user_stats_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-user-stats-service/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-user-stats-service/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

#################
## NAMED VALUE ##
#################
data "azurerm_key_vault_secret" "ecommerce_dev_sendpaymentresult_subscription_key" {
  count        = var.env_short == "u" ? 1 : 0
  name         = "ecommerce-dev-sendpaymentresult-subscription-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "ecommerce_dev_sendpaymentresult_subscription_key_named_value" {
  count               = var.env_short == "u" ? 1 : 0
  name                = "ecommerce-dev-sendpaymentresult-subscription-key-value"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ecommerce-dev-sendpaymentresult-subscription-key-value"
  value               = data.azurerm_key_vault_secret.ecommerce_dev_sendpaymentresult_subscription_key[0].value
  secret              = true
}

data "azurerm_key_vault_secret" "ecommerce_payment_requests_primary_api_key" {
  name         = "ecommerce-payment-requests-primary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "ecommerce_payment_requests_secondary_api_key" {
  name         = "ecommerce-payment-requests-secondary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "ecommerce_payment_requests_api_key_value" {
  name                = "ecommerce-payment-requests-api-key-value"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ecommerce-payment-requests-api-key-value"
  value               = var.ecommerce_payment_requests_api_key_use_primary ? data.azurerm_key_vault_secret.ecommerce_payment_requests_primary_api_key.value : data.azurerm_key_vault_secret.ecommerce_payment_requests_secondary_api_key.value
  secret              = true
}

data "azurerm_key_vault_secret" "ecommerce_user_stats_service_primary_api_key" {
  name         = "ecommerce-user-stats-service-primary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "ecommerce_user_stats_service_secondary_api_key" {
  name         = "ecommerce-user-stats-service-secondary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "ecommerce_user_stats_service_api_key_value" {
  name                = "ecommerce-user-stats-service-api-key-value"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ecommerce-user-stats-service-api-key-value"
  value               = var.ecommerce_user_stats_service_api_key_use_primary ? data.azurerm_key_vault_secret.ecommerce_user_stats_service_primary_api_key.value : data.azurerm_key_vault_secret.ecommerce_user_stats_service_secondary_api_key.value
  secret              = true
}
data "azurerm_key_vault_secret" "ecommerce_payment_methods_primary_api_key" {
  name         = "ecommerce-payment-methods-primary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "ecommerce_payment_methods_secondary_api_key" {
  name         = "ecommerce-payment-methods-secondary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "ecommerce_payment_methods_api_key_value" {
  name                = "ecommerce-payment-methods-api-key-value"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ecommerce-payment-methods-api-key-value"
  value               = var.ecommerce_payment_methods_api_key_use_primary ? data.azurerm_key_vault_secret.ecommerce_payment_methods_primary_api_key.value : data.azurerm_key_vault_secret.ecommerce_payment_methods_secondary_api_key.value
  secret              = true
}


data "azurerm_key_vault_secret" "ecommerce_transactions_service_primary_api_key" {
  name         = "ecommerce-transactions-service-primary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "ecommerce_transactions_service_secondary_api_key" {
  name         = "ecommerce-transactions-service-secondary-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "ecommerce_transactions_service_api_key_value" {
  name                = "ecommerce-transactions-service-api-key-value"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ecommerce-transactions-service-api-key-value"
  value               = var.ecommerce_transactions_service_api_key_use_primary ? data.azurerm_key_vault_secret.ecommerce_transactions_service_primary_api_key.value : data.azurerm_key_vault_secret.ecommerce_transactions_service_secondary_api_key.value
  secret              = true
}
