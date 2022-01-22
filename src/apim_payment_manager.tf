##############
## Products ##
##############

module "apim_payment_manager_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "payment-manager"
  display_name = "Payment Manager pagoPA"
  description  = "Product for Payment Manager pagoPA"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/payment_manager_api/_base_policy.xml")
}

#####################################
## API buyerbanks                  ##
#####################################
locals {
  apim_buyerbanks_api = {
    # params for all api versions
    display_name          = "pagoPA buyerbanks API"
    description           = "API to support buyerbanks list update"
    path                  = "payment-manager/buyerbanks"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "buyerbanks_api" {

  name                = format("%s-buyerbanks-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_buyerbanks_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_buyerbanks_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-buyerbanks-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_buyerbanks_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.buyerbanks_api.id
  api_version           = "v1"
  service_url           = local.apim_buyerbanks_api.service_url

  description  = local.apim_buyerbanks_api.description
  display_name = local.apim_buyerbanks_api.display_name
  path         = local.apim_buyerbanks_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/buyerbanks/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_manager_api/buyerbanks/_base_policy.xml.tpl")
}

#####################################
## API restapi                     ##
#####################################
locals {
  apim_pm_restapi_api = {
    # params for all api versions
    display_name          = "Payment Manager restapi API"
    description           = "API to support payment trasactions for Checkout and Wisp"
    path                  = "payment-manager/restapi"
    subscription_required = false
    service_url           = null
  }
}

data "azurerm_key_vault_secret" "pm_restapi_ip" {
  name         = "pm-restapi-ip"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_api_version_set" "pm_restapi_api" {

  name                = format("%s-pm-restapi-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_restapi_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_restapi_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-restapi-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapi_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapi_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_restapi_api.service_url

  description  = local.apim_pm_restapi_api.description
  display_name = local.apim_pm_restapi_api.display_name
  path         = local.apim_pm_restapi_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/restapi/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/payment_manager_api/restapi/_base_policy.xml.tpl", {
    endpoint = format("https://%s:1443/pp-restapi", data.azurerm_key_vault_secret.pm_restapi_ip.value)
  })
}

#####################################
## API restapi CD                  ##
#####################################
locals {
  apim_pm_restapicd_api = {
    # params for all api versions
    display_name          = "Payment Manager restapi CD API"
    description           = "API to support payment trasactions for app IO"
    path                  = "payment-manager/restapi-cd"
    subscription_required = false
    service_url           = null
  }
}

data "azurerm_key_vault_secret" "pm_restapicd_ip" {
  name         = "pm-restapicd-ip"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_api_version_set" "pm_restapicd_api" {

  name                = format("%s-pm-restapicd-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_restapicd_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_restapicd_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-restapicd-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapicd_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapicd_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_restapicd_api.service_url

  description  = local.apim_pm_restapicd_api.description
  display_name = local.apim_pm_restapicd_api.display_name
  path         = local.apim_pm_restapicd_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/restapi-cd/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/payment_manager_api/restapi-cd/_base_policy.xml.tpl", {
    endpoint = format("https://%s:1443/pp-restapi-CD", data.azurerm_key_vault_secret.pm_restapicd_ip.value)
  })
}

#####################################
## API logging                  ##
#####################################
locals {
  apim_pm_logging_api = {
    display_name          = "Payment Manager logging CD API"
    description           = "API to support PM logging"
    path                  = "payment-manager/logging"
    subscription_required = false
    service_url           = null
  }
}

data "azurerm_key_vault_secret" "pm_logging_ip" {
  name         = "pm-logging-ip"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_api_version_set" "pm_logging_api" {

  name                = format("%s-pm-logging-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_logging_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_logging_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-logging-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_logging_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_logging_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_logging_api.service_url

  description  = local.apim_pm_logging_api.description
  display_name = local.apim_pm_logging_api.display_name
  path         = local.apim_pm_logging_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/logging/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/payment_manager_api/logging/_base_policy.xml.tpl", {
    endpoint = format("https://%s:1443/db_logging", data.azurerm_key_vault_secret.pm_logging_ip.value)
  })
}

############################
## API webview-cd         ##
############################
locals {
  apim_pm_webview_api = {
    display_name          = "Payment Manager CD webview"
    description           = "Webview to support app IO payments"
    path                  = "payment-manager/webview-cd"
    subscription_required = false
    service_url           = null
  }
}

data "azurerm_key_vault_secret" "pm_webview_ip" {
  name         = "pm-webview-ip"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_api_version_set" "pm_webview_api" {

  name                = format("%s-pm-webview-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_webview_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_webview_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-webview-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_webview_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_webview_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_webview_api.service_url

  description  = local.apim_pm_webview_api.description
  display_name = local.apim_pm_webview_api.display_name
  path         = local.apim_pm_webview_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/webview-cd/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/payment_manager_api/webview-cd/_base_policy.xml.tpl",{
    endpoint = format("https://%s:1443/pp-restapi-CD", data.azurerm_key_vault_secret.pm_webview_ip.value)
  })
}

############################
## API admin panel        ##
############################
locals {
  apim_pm_adminpanel_api = {
    display_name          = "Payment Manager admin panel frontend"
    description           = "Frontend to support PM operations"
    path                  = "payment-manager/admin-panel"
    subscription_required = false
    service_url           = null
  }
}

data "azurerm_key_vault_secret" "pm_adminpanel_ip" {
  name         = "pm-adminpanel-ip"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_api_version_set" "pm_adminpanel_api" {

  name                = format("%s-pm-adminpanel-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_adminpanel_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_adminpanel_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-adminpanel-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_adminpanel_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_adminpanel_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_adminpanel_api.service_url

  description  = local.apim_pm_adminpanel_api.description
  display_name = local.apim_pm_adminpanel_api.display_name
  path         = local.apim_pm_adminpanel_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/admin-panel/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_manager_api/admin-panel/_base_policy.xml.tpl", {
    endpoint = format("https://%s:1443/pp-admin-panel", data.azurerm_key_vault_secret.pm_adminpanel_ip.value)
  })
}

#####################
## API wisp        ##
#####################
locals {
  apim_pm_wisp_api = {
    display_name          = "Payment Manager Wisp"
    description           = "Frontend to support payments"
    path                  = "payment-manager/wisp"
    subscription_required = false
    service_url           = null
  }
}

data "azurerm_key_vault_secret" "wisp_ip" {
  name         = "wisp-ip"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_api_version_set" "pm_wisp_api" {

  name                = format("%s-pm-wisp-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_wisp_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_wisp_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-wisp-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_wisp_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_wisp_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_wisp_api.service_url

  description  = local.apim_pm_wisp_api.description
  display_name = local.apim_pm_wisp_api.display_name
  path         = local.apim_pm_wisp_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/wisp/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/payment_manager_api/wisp/_base_policy.xml.tpl",{
    endpoint = format("https://%s:1443/wallet", data.azurerm_key_vault_secret.wisp_ip.value)
  })
}
