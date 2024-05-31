data "azurerm_key_vault_secret" "pm_onprem_hostname" {
  name         = "pm-onprem-hostname"
  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "pgs_jwt_key" {
  name         = "pgs-jwt-key"
  value        = "<TO UPDATE MANUALLY ON PORTAL>"
  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

data "azurerm_key_vault_secret" "pgs_jwt_key" {
  name         = "pgs-jwt-key"
  key_vault_id = module.key_vault.id
}

##############
## Products ##
##############

module "apim_payment_transactions_gateway_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "payment-transactions-gateway"
  display_name = "Payment Transactions Gateway pagoPA"
  description  = "Product for Payment Transactions Gateway pagoPA"

  api_management_name = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].name : module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/payment_transactions_gateway_api/_base_policy.xml")
}

#######################################
## API payment-transactions-gateway  ##
#######################################
locals {
  apim_payment_transactions_gateway_update_api = {
    # params for all api versions
    display_name          = "Payment Transactions Gateway - payment authorization status update"
    description           = "RESTful APIs provided to enable payment authorization status update"
    path                  = "payment-transactions-gateway/updates"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "payment_transactions_gateway_update_api" {

  name                = format("%s-payment-transactions-gateway-update-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].name : module.apim[0].name
  display_name        = local.apim_payment_transactions_gateway_update_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_payment_transactions_gateway_update_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-payment-transactions-gateway-update-api", local.project)
  api_management_name   = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].name : module.apim[0].name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_transactions_gateway_product.product_id]
  subscription_required = local.apim_payment_transactions_gateway_update_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.payment_transactions_gateway_update_api.id
  api_version           = "v1"
  service_url           = local.apim_payment_transactions_gateway_update_api.service_url

  description  = local.apim_payment_transactions_gateway_update_api.description
  display_name = local.apim_payment_transactions_gateway_update_api.display_name
  path         = local.apim_payment_transactions_gateway_update_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_transactions_gateway_api/update/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_transactions_gateway_api/update/v1/_base_policy.xml.tpl")
}

################################################
## API payment-transactions-gateway-internal  ##
################################################
locals {
  apim_payment_transactions_gateway_internal_api = {
    # params for all api versions
    display_name          = "Payment Transactions Gateway - payment-transactions-gateway"
    description           = "RESTful APIs provided to support payments with payment gateways"
    path                  = "payment-transactions-gateway/internal"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "payment_transactions_gateway_internal_api" {

  name                = format("%s-payment-transactions-gateway-internal-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].name : module.apim[0].name
  display_name        = local.apim_payment_transactions_gateway_internal_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_payment_transactions_gateway_internal_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-payment-transactions-gateway-internal-api", local.project)
  api_management_name   = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].name : module.apim[0].name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_transactions_gateway_product.product_id]
  subscription_required = local.apim_payment_transactions_gateway_internal_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.payment_transactions_gateway_internal_api.id
  api_version           = "v1"
  service_url           = local.apim_payment_transactions_gateway_internal_api.service_url

  description  = local.apim_payment_transactions_gateway_internal_api.description
  display_name = local.apim_payment_transactions_gateway_internal_api.display_name
  path         = local.apim_payment_transactions_gateway_internal_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_transactions_gateway_api/internal/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_transactions_gateway_api/internal/v1/_base_policy.xml.tpl")
}

###############################################
## API payment-transactions-gateway-external ##
###############################################
locals {
  apim_payment_transactions_gateway_external_api = {
    # params for all api versions
    display_name          = "Payment Transactions Gateway - payment-transactions-gateway-external"
    description           = "RESTful APIs provided to support webview polling"
    path                  = "payment-transactions-gateway/external"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "payment_transactions_gateway_external_api" {

  name                = format("%s-payment-transactions-gateway-external-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].name : module.apim[0].name
  display_name        = local.apim_payment_transactions_gateway_external_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_payment_transactions_gateway_external_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-payment-transactions-gateway-external-api", local.project)
  api_management_name   = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].name : module.apim[0].name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_transactions_gateway_product.product_id]
  subscription_required = local.apim_payment_transactions_gateway_external_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.payment_transactions_gateway_external_api.id
  api_version           = "v1"
  service_url           = local.apim_payment_transactions_gateway_external_api.service_url

  description  = local.apim_payment_transactions_gateway_external_api.description
  display_name = local.apim_payment_transactions_gateway_external_api.display_name
  path         = local.apim_payment_transactions_gateway_external_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_transactions_gateway_api/external/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_transactions_gateway_api/external/v1/_base_policy.xml.tpl")
}


#############################################
## API payment-transactions-gateway-pgs-fe ##
#############################################
locals {
  apim_payment_transactions_gateway_pgsfe_api = {
    # params for all api versions
    display_name          = "Payment Transactions Gateway - payment-transactions-gateway-pgsfe"
    description           = "RESTful APIs provided to support webview polling for pgs frontend"
    path                  = "payment-transactions-gateway/web"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "payment_transactions_gateway_pgsfe_api" {

  name                = format("%s-payment-transactions-gateway-pgsfe-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].name : module.apim[0].name
  display_name        = local.apim_payment_transactions_gateway_pgsfe_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_payment_transactions_gateway_pgsfe_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-payment-transactions-gateway-pgsfe-api", local.project)
  api_management_name   = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].name : module.apim[0].name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_transactions_gateway_product.product_id]
  subscription_required = local.apim_payment_transactions_gateway_pgsfe_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.payment_transactions_gateway_pgsfe_api.id
  api_version           = "v1"
  service_url           = local.apim_payment_transactions_gateway_pgsfe_api.service_url

  description  = local.apim_payment_transactions_gateway_pgsfe_api.description
  display_name = local.apim_payment_transactions_gateway_pgsfe_api.display_name
  path         = local.apim_payment_transactions_gateway_pgsfe_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_transactions_gateway_api/pgs-fe/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/payment_transactions_gateway_api/pgs-fe/v1/_base_policy.xml.tpl", {
    origin = var.env_short == "d" ? "*" : "https://${var.dns_zone_checkout}.${var.external_domain}/"
  })
}

resource "azurerm_api_management_named_value" "payment_gateway_service_jwt_key" {
  name                = "payment-gateway-service-jwt-key"
  api_management_name = var.enabled_features.apim_migrated ? data.azurerm_api_management.apim_migrated[0].name : module.apim[0].name
  resource_group_name = azurerm_resource_group.rg_api.name
  display_name        = "payment-gateway-service-jwt-key"
  value               = data.azurerm_key_vault_secret.pgs_jwt_key.value
  secret              = true
}


