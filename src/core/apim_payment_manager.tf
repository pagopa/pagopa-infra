##############
## Products ##
##############

module "apim_payment_manager_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "payment-manager"
  display_name = "Payment Manager pagoPA"
  description  = "Product for Payment Manager pagoPA"

  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/payment_manager_api/_base_policy.xml")
}


data "azurerm_key_vault_secret" "pm_restapi_ip" {
  name         = "pm-restapi-ip"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

#####################################
## API restapi                     ##
#####################################
locals {
  apim_pm_restapi_api = {
    # params for all api versions
    display_name          = "Payment Manager restapi API"
    description           = "API to support payment trasactions for Checkout and Wisp"
    path                  = "payment-manager/pp-restapi"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "pm_restapi_api" {

  name                = "${local.project}-pm-restapi-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_restapi_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_restapi_api_v4" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = "${local.project}-pm-restapi-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapi_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapi_api.id
  api_version           = "v4"
  service_url           = local.apim_pm_restapi_api.service_url

  description  = local.apim_pm_restapi_api.description
  display_name = local.apim_pm_restapi_api.display_name
  path         = local.apim_pm_restapi_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/restapi/v4/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/payment_manager_api/restapi/v4/_base_policy.xml.tpl", {
    origin = "https://${var.dns_zone_checkout}.${var.external_domain}/"
  })
}

#####################################
## API restapi old                 ##
#####################################
locals {
  apim_pm_restapi_old_api = {
    # params for all api versions
    display_name          = "Payment Manager restapi API old"
    description           = "API to support payment trasactions for Checkout and Wisp - old"
    path                  = "pp-restapi"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "pm_restapi_old_api" {

  name                = "${local.project}-pm-restapi-old-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_restapi_old_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_restapi_api_old_v4" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = "${local.project}-pm-restapi-old-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapi_old_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapi_old_api.id
  api_version           = "v4"
  service_url           = local.apim_pm_restapi_old_api.service_url

  description  = local.apim_pm_restapi_old_api.description
  display_name = local.apim_pm_restapi_old_api.display_name
  path         = local.apim_pm_restapi_old_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/restapi/v4/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/payment_manager_api/restapi/v4/_base_policy.xml.tpl", {
    origin = "https://${var.dns_zone_checkout}.${var.external_domain}/"
  })
}

##########################################
## API static resources for restapi-cd  ##
##########################################
locals {
  apim_pm_restapicd_assets_api = {
    display_name          = "Payment Manager - restapi-cd static resources"
    description           = "Static resources to support PM webviews"
    path                  = "pp-restapi-CD/assets"
    subscription_required = false
    service_url           = null
  }
}

module "apim_pm_restapi_cd_assets" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = "${local.project}-pm-cd-assets-restapi"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapicd_assets_api.subscription_required
  service_url           = local.apim_pm_restapicd_assets_api.service_url

  description  = local.apim_pm_restapicd_assets_api.description
  display_name = local.apim_pm_restapicd_assets_api.display_name
  path         = local.apim_pm_restapicd_assets_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/restapi-cd-assets/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/restapi-cd-assets/_base_policy.xml.tpl")
}

#####################################
## API restapi CD internal         ##
#####################################
locals {
  apim_pm_restapicd_internal_api = {
    # params for all api versions
    display_name          = "Payment Manager internal restapi CD API"
    description           = "API to support internal api exposed for payment transacions gateway"
    path                  = "payment-manager/internal/pp-restapi-cd"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "pm_restapicd_internal_api" {

  name                = "${local.project}-pm-restapicd-internal-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_restapicd_internal_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_restapicd_internal_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = "${local.project}-pm-restapicd-internal-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapicd_internal_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapicd_internal_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_restapicd_internal_api.service_url

  description  = local.apim_pm_restapicd_internal_api.description
  display_name = local.apim_pm_restapicd_internal_api.display_name
  path         = local.apim_pm_restapicd_internal_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/restapi-cd-internal/v1/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/restapi-cd-internal/v1/_base_policy.xml.tpl")
}

module "apim_pm_restapicd_internal_api_v2" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = "${local.project}-pm-restapicd-internal-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapicd_internal_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapicd_internal_api.id
  api_version           = "v2"
  service_url           = local.apim_pm_restapicd_internal_api.service_url

  description  = local.apim_pm_restapicd_internal_api.description
  display_name = local.apim_pm_restapicd_internal_api.display_name
  path         = local.apim_pm_restapicd_internal_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/restapi-cd-internal/v2/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/restapi-cd-internal/v2/_base_policy.xml.tpl")
}

############################
## API restapi-server     ##
############################
locals {
  apim_pm_restapi_server_api = {
    # params for all api versions
    display_name          = "Payment Manager restapi server API"
    description           = "API to support payment trasactions monitoring"
    path                  = "payment-manager/pp-restapi-server"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "pm_restapi_server_api" {

  name                = "${local.project}-pm-restapi-server-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_restapi_server_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_restapi_server_api_v4" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = "${local.project}-pm-restapi-server-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapi_server_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapi_server_api.id
  api_version           = "v4"
  service_url           = local.apim_pm_restapi_server_api.service_url

  description  = local.apim_pm_restapi_server_api.description
  display_name = local.apim_pm_restapi_server_api.display_name
  path         = local.apim_pm_restapi_server_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/restapi-server/v4/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/restapi-server/v4/_base_policy.xml.tpl")
}

#####################################
## API restapi RTD                  ##
#####################################
locals {
  apim_pm_restapirtd_api = {
    # params for all api versions
    display_name          = "Payment Manager restapi RTD API"
    description           = "API to support 'Registro Transazioni Digitali'"
    path                  = "payment-manager/pp-restapi-rtd"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "pm_restapirtd_api" {

  name                = "${local.project}-pm-restapirtd-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_restapirtd_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_restapirtd_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = "${local.project}-pm-restapirtd-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapirtd_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapirtd_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_restapirtd_api.service_url

  description  = local.apim_pm_restapirtd_api.description
  display_name = local.apim_pm_restapirtd_api.display_name
  path         = local.apim_pm_restapirtd_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/restapi-rtd/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/restapi-rtd/v1/_base_policy.xml.tpl")
}

module "apim_pm_restapirtd_api_v2" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = "${local.project}-pm-restapirtd-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapirtd_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapirtd_api.id
  api_version           = "v2"
  service_url           = local.apim_pm_restapirtd_api.service_url

  description  = local.apim_pm_restapirtd_api.description
  display_name = local.apim_pm_restapirtd_api.display_name
  path         = local.apim_pm_restapirtd_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/restapi-rtd/v2/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/restapi-rtd/v2/_base_policy.xml.tpl")
}

#####################################
## API auth RTD                  ##
#####################################
locals {
  apim_pm_auth_rtd_api = {
    # params for all api versions
    display_name          = "Payment Manager restapi RTD API with subscription key"
    description           = "API to support 'Registro Transazioni Digitali' with subscription key"
    path                  = "payment-manager/auth-rtd"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "pm_auth_rtd_api" {
  name                = "${local.project}-pm-auth-rtd-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_auth_rtd_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_auth_rtd_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = "${local.project}-pm-auth-rtd-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_auth_rtd_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_auth_rtd_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_auth_rtd_api.service_url

  description  = local.apim_pm_auth_rtd_api.description
  display_name = local.apim_pm_auth_rtd_api.display_name
  path         = local.apim_pm_auth_rtd_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/auth-rtd/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/auth-rtd/v1/_base_policy.xml.tpl")
}

module "apim_pm_auth_rtd_api_v2" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = "${local.project}-pm-auth-rtd-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_auth_rtd_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_auth_rtd_api.id
  api_version           = "v2"
  service_url           = local.apim_pm_auth_rtd_api.service_url

  description  = local.apim_pm_auth_rtd_api.description
  display_name = local.apim_pm_auth_rtd_api.display_name
  path         = local.apim_pm_auth_rtd_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/auth-rtd/v2/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/auth-rtd/v2/_base_policy.xml.tpl")
}

#####################################
## API logging                  ##
#####################################
locals {
  apim_pm_logging_api = {
    display_name          = "Payment Manager logging API"
    description           = "API to support PM logging"
    path                  = "payment-manager/db-logging"
    subscription_required = false
    service_url           = null
  }
}

data "azurerm_key_vault_secret" "pm_logging_ip" {
  name         = "pm-logging-ip"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

module "apim_pm_logging_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = "${local.project}-pm-logging-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_logging_api.subscription_required
  service_url           = local.apim_pm_logging_api.service_url

  description  = local.apim_pm_logging_api.description
  display_name = local.apim_pm_logging_api.display_name
  path         = local.apim_pm_logging_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/logging/v1/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/logging/v1/_base_policy.xml.tpl")
}

############################
## API admin panel        ##
############################
locals {
  apim_pm_adminpanel_api = {
    display_name          = "Payment Manager - Admin pPnel "
    description           = "Frontend to support PM operations"
    path                  = "pp-admin-panel"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "pm_adminpanel_api" {

  name                = "${local.project}-pm-adminpanel-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_adminpanel_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_adminpanel_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = "${local.project}-pm-adminpanel-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_adminpanel_api.subscription_required
  service_url           = local.apim_pm_adminpanel_api.service_url

  description  = local.apim_pm_adminpanel_api.description
  display_name = local.apim_pm_adminpanel_api.display_name
  path         = local.apim_pm_adminpanel_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/admin-panel/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/payment_manager_api/admin-panel/_base_policy.xml.tpl", {
    allowed_ip_1  = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[0]  # PagoPA on prem VPN
    allowed_ip_2  = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[1]  # PagoPA on prem VPN DR
    allowed_ip_3  = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[2]  # CSTAR
    allowed_ip_4  = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[3]  # Softlab L1 Pagamenti VPN
    allowed_ip_5  = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[4]  # Softlab L1 Pagamenti VPN
    allowed_ip_6  = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[5]  # Softlab L1 Pagamenti VPN
    allowed_ip_7  = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[6]  # Softlab L1 Pagamenti VPN
    allowed_ip_8  = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[7]  # Softlab L1 Pagamenti VPN
    allowed_ip_9  = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[8]  # NEXI VPN
    allowed_ip_10 = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[9]  # NEXI VPN
    allowed_ip_11 = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[11] # Softlab L1 Pagamenti VPN backup
  })
}

#####################
## API wisp        ##
#####################
locals {
  apim_pm_wisp_api = {
    display_name          = "Payment Manager Wisp"
    description           = "Frontend to support payments"
    path                  = "wallet"
    subscription_required = false
    service_url           = null
  }
}

data "azurerm_key_vault_secret" "pm_wisp_metadata" {
  name         = "pm-wisp-metadata"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

module "apim_pm_wisp_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = "${local.project}-pm-wisp-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_wisp_api.subscription_required
  service_url           = local.apim_pm_wisp_api.service_url

  description  = local.apim_pm_wisp_api.description
  display_name = local.apim_pm_wisp_api.display_name
  path         = local.apim_pm_wisp_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/wisp/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/wisp/_base_policy.xml.tpl")
}

# resource "azurerm_api_management_api_operation_policy" "get_spid_metadata_api" {
#   api_name            = "${local.project}-pm-wisp-api"
#   api_management_name = module.apim[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   operation_id        = "GETSpidMetadata"

#   xml_content = templatefile("./api/payment_manager_api/wisp/_spid_metadata_policy.xml.tpl", { metadata = data.azurerm_key_vault_secret.pm_wisp_metadata.value })
# }

##############################################
## API pagopa-payment-transactions-gateway  ##
##############################################
locals {
  apim_pm_ptg_api = {
    # params for all api versions
    display_name          = "Payment Manager - payment transactions gateway API"
    description           = "API to support payment transactions gateway"
    path                  = "payment-manager/payment-gateway"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "pm_ptg_api" {

  name                = "${local.project}-pm-ptg-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_ptg_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_ptg_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = "${local.project}-pm-ptg-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_ptg_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_ptg_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_ptg_api.service_url

  description  = local.apim_pm_ptg_api.description
  display_name = local.apim_pm_ptg_api.display_name
  path         = local.apim_pm_ptg_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/payment-transactions-gateway/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/payment-transactions-gateway/v1/_base_policy.xml.tpl")
}

######################
## API PM per Nodo  ##
######################
locals {
  apim_pm_per_nodo_api = {
    # params for all api versions
    display_name             = "Payment Manager - PM per Nodo API"
    description              = "API PM for Nodo"
    path                     = "payment-manager/pm-per-nodo"
    subscription_required_v1 = true
    subscription_required_v2 = true
    service_url              = null
  }
}

resource "azurerm_api_management_api_version_set" "pm_per_nodo_api" {

  name                = "${local.project}-pm-per-nodo-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_per_nodo_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_per_nodo_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = "${local.project}-pm-per-nodo-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id, local.apim_x_node_product_id]
  subscription_required = local.apim_pm_per_nodo_api.subscription_required_v1
  version_set_id        = azurerm_api_management_api_version_set.pm_per_nodo_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_per_nodo_api.service_url

  description  = local.apim_pm_per_nodo_api.description
  display_name = local.apim_pm_per_nodo_api.display_name
  path         = local.apim_pm_per_nodo_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/pm-per-nodo/v1/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/pm-per-nodo/v1/_base_policy.xml.tpl")
}

######################
## API PM events  ##
######################
locals {
  apim_pm_events_api = {
    # params for all api versions
    display_name          = "Payment Manager - PM events API"
    description           = "API PM events"
    path                  = "payment-manager/events"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "pm_events_api" {

  name                = "${local.project}-pm-events-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_events_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_events_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = "${local.project}-pm-events-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_events_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_events_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_events_api.service_url

  description  = local.apim_pm_events_api.description
  display_name = local.apim_pm_events_api.display_name
  path         = local.apim_pm_events_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/payment-events/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/payment-events/v1/_base_policy.xml.tpl")
}

module "apim_pm_per_nodo_v2" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = "${local.project}-pm-per-nodo-api"
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id, local.apim_x_node_product_id]
  subscription_required = local.apim_pm_per_nodo_api.subscription_required_v2
  version_set_id        = azurerm_api_management_api_version_set.pm_per_nodo_api.id
  api_version           = "v2"
  service_url           = local.apim_pm_per_nodo_api.service_url

  description  = local.apim_pm_per_nodo_api.description
  display_name = local.apim_pm_per_nodo_api.display_name
  path         = local.apim_pm_per_nodo_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/pm-per-nodo/v2/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/pm-per-nodo/v2/_base_policy.xml")
}

# Payment Manager - PM per Nodo API
#
# v1 -> src/core/api/payment_manager_api/pm-per-nodo/v1/_swagger.json.tpl - NOT used into WISP dismantling
#   "/payments/send-payment-result" - "operationId": "sendPaymentResult"
#
# v2 -> src/core/api/payment_manager_api/pm-per-nodo/v2/_openapi.json.tpl
#   "/transactions/{transactionId}/user-receipts" - "operationId": "addUserReceipt"
#
# WISP sendPaymentResultV2
resource "azurerm_api_management_api_operation_policy" "send_payment_result_api_v2_wisp_policy" { # aka addUserReceipt
  count               = var.create_wisp_converter ? 1 : 0
  api_name            = "${local.project}-pm-per-nodo-api-v2"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  operation_id        = "addUserReceipt"
  xml_content = templatefile(var.env_short == "u" ? "./api/payment_manager_api/pm-per-nodo/v2/wisp-sendpaymentresult-uat.xml.tpl" : "./api/payment_manager_api/pm-per-nodo/v2/wisp-sendpaymentresult.xml.tpl", {
    host                       = local.api_domain,
    ecommerce_ingress_hostname = var.ecommerce_ingress_hostname
  })
}

resource "terraform_data" "sha256_send_payment_result_api_v2_wisp_policy" {
  input = sha256(file("./api/payment_manager_api/pm-per-nodo/v2/wisp-sendpaymentresult.xml.tpl"))
}


########################
## client IO bpd API  ##
########################
locals {
  apim_pmclient_iobpd_api = {
    display_name          = "Payment Manager - IO BPD client"
    description           = "API to support BPD for Payment Manager"
    path                  = "payment-manager/clients/io-bpd"
    subscription_required = false
    service_url           = null
    io_bpd_hostname       = var.io_bpd_hostname
  }
}

resource "azurerm_api_management_api_version_set" "pmclient_iobpd_api" {

  name                = format("%s-pmclient-iobpd-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pmclient_iobpd_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pmclient_iobpd_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-pmclient-iobpd-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pmclient_iobpd_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pmclient_iobpd_api.id
  api_version           = "v1"
  service_url           = local.apim_pmclient_iobpd_api.service_url

  description  = local.apim_pmclient_iobpd_api.description
  display_name = local.apim_pmclient_iobpd_api.display_name
  path         = local.apim_pmclient_iobpd_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/clients/io-bpd/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/payment_manager_api/clients/io-bpd/_base_policy.xml.tpl", {
    endpoint = format("https://%s/pagopa/api/v1", local.apim_pmclient_iobpd_api.io_bpd_hostname)
  })
}

#####################################
## API paypal psp                  ##
#####################################
locals {
  apim_pm_paypalpsp_api = {
    display_name          = "Payment Manager paypal PSP API"
    description           = "API to support payment and onboarding paypal"
    path                  = "payment-manager/clients/paypal-psp"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_pm_paypalpsp_api" {

  name                = format("%s-pm-paypalpsp-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_paypalpsp_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_paypalpsp_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-pm-paypalpsp-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_paypalpsp_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_pm_paypalpsp_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_paypalpsp_api.service_url

  description  = local.apim_pm_paypalpsp_api.description
  display_name = local.apim_pm_paypalpsp_api.display_name
  path         = local.apim_pm_paypalpsp_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/clients/paypal-psp/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/payment_manager_api/clients/paypal-psp/v1/_base_policy.xml.tpl", {
    endpoint = format("https://%s", var.paytipper_hostname)
  })
}

##############################
## API xpay                 ##
##############################
locals {
  apim_pm_xpay_api = {
    display_name          = "Payment Manager xpay API"
    description           = "API to support xpay payments"
    path                  = "payment-manager/clients/xpay"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_pm_xpay_api" {

  name                = format("%s-pm-xpay-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_xpay_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_xpay_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-pm-xpay-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_xpay_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_pm_xpay_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_xpay_api.service_url

  description  = local.apim_pm_xpay_api.description
  display_name = local.apim_pm_xpay_api.display_name
  path         = local.apim_pm_xpay_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/clients/xpay/v1/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/payment_manager_api/clients/xpay/v1/_base_policy.xml.tpl", {
    endpoint = format("https://%s", var.xpay_hostname)
  })
}

########################
## API bpd           ##
########################
locals {
  apim_pm_bpd_api = {
    display_name          = "Payment Manager BPD API"
    description           = "API to support bpd payments"
    path                  = "payment-manager/clients/bpd"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_pm_bpd_api" {

  name                = format("%s-pm-bpd-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_bpd_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_bpd_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-pm-bpd-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_bpd_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_pm_bpd_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_bpd_api.service_url

  description  = local.apim_pm_bpd_api.description
  display_name = local.apim_pm_bpd_api.display_name
  path         = local.apim_pm_bpd_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/clients/bpd/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/payment_manager_api/clients/bpd/v1/_base_policy.xml.tpl", {
    endpoint = format("https://%s", var.bpd_hostname)
  })
}

############################
## API COBAdGE            ##
############################
locals {
  apim_pm_cobadge_api = {
    display_name          = "Payment Manager cobadge API"
    description           = "API to support cobadge payments"
    path                  = "payment-manager/clients/cobadge"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_pm_cobadge_api" {

  name                = format("%s-pm-cobadge-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_cobadge_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_cobadge_api_v4" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-pm-cobadge-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_cobadge_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_pm_cobadge_api.id
  api_version           = "v4"
  service_url           = local.apim_pm_cobadge_api.service_url

  description  = local.apim_pm_cobadge_api.description
  display_name = local.apim_pm_cobadge_api.display_name
  path         = local.apim_pm_cobadge_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/clients/cobadge/v4/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/payment_manager_api/clients/cobadge/v4/_base_policy.xml.tpl", {
    endpoint = format("https://%s/cobadge/api/pagopa/banking/v4.0", var.cobadge_hostname)
  })
}

###########################
## API SATISPAY          ##
###########################
locals {
  apim_pm_satispay_api = {
    display_name          = "Payment Manager - satispay API"
    description           = "API to support satispay payments"
    path                  = "payment-manager/clients/satispay"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_pm_satispay_api" {

  name                = format("%s-pm-satispay-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_satispay_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_satispay_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-pm-satispay-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_satispay_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_pm_satispay_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_satispay_api.service_url

  description  = local.apim_pm_satispay_api.description
  display_name = local.apim_pm_satispay_api.display_name
  path         = local.apim_pm_satispay_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/clients/satispay/v1/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/payment_manager_api/clients/satispay/v1/_base_policy.xml.tpl", {
    endpoint = format("https://%s/satispay/v1", var.satispay_hostname)
  })
}

#########################
## API FESP            ##
#########################
locals {
  apim_pm_fesp_api = {
    display_name          = "Payment Manager fesp redirect API"
    description           = "API to support fesp redirect"
    path                  = "payment-manager/clients/fesp"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_pm_fesp_api" {

  name                = format("%s-pm-fesp-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_fesp_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_fesp_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-pm-fesp-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_fesp_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_pm_fesp_api.id
  api_version           = "v4"
  service_url           = local.apim_pm_fesp_api.service_url

  description  = local.apim_pm_fesp_api.description
  display_name = local.apim_pm_fesp_api.display_name
  path         = local.apim_pm_fesp_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/clients/fesp/_swagger.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/payment_manager_api/clients/fesp/_base_policy.xml.tpl", {
    endpoint = format("https://%s", var.fesp_hostname)
  })
}


#########################
## Mock - services     ##
#########################
locals {
  apim_pm_mock_services_fe_api = {
    display_name          = "Payment Manager - mock-services FE"
    description           = "Frontend for mock-services"
    path                  = "pmmockserviceapi"
    subscription_required = false
    service_url           = null
  }
}

module "apim_pm_mock_services_fe" {
  count  = var.env_short != "p" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-pm-mock-services-fe-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_mock_services_fe_api.subscription_required
  service_url           = local.apim_pm_mock_services_fe_api.service_url

  description  = local.apim_pm_mock_services_fe_api.description
  display_name = local.apim_pm_mock_services_fe_api.display_name
  path         = local.apim_pm_mock_services_fe_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/mock-services-fe/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/mock-services-fe/v1/_base_policy.xml.tpl")
}

#########################
## API Mock services   ##
#########################
locals {
  apim_pm_mock_services_api = {
    display_name          = "Payment Manager mock-services API"
    description           = "API to support mock-services redirect"
    path                  = "payment-manager/mock-services"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_pm_mock_services_api" {
  count = var.env_short != "p" ? 1 : 0

  name                = format("%s-pm-mock-services-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_mock_services_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_mock_services_api_v1" {

  count = var.env_short != "p" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-pm-mock-services-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_mock_services_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_pm_mock_services_api[0].id
  api_version           = "v1"
  service_url           = local.apim_pm_mock_services_api.service_url

  description  = local.apim_pm_mock_services_api.description
  display_name = local.apim_pm_mock_services_api.display_name
  path         = local.apim_pm_mock_services_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/mock-services-api/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/mock-services-api/v1/_base_policy.xml.tpl")
}

#########################
## API test utility   ##
#########################
locals {
  apim_pm_test_utility_api = {
    display_name          = "Payment Manager test utility  API"
    description           = "API to support testing"
    path                  = "payment-manager/test-utility"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_pm_test_utility_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-pm-test-utility-api", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_pm_test_utility_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_test_utility_api_v1" {

  count = var.env_short == "d" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-pm-test-utility-api", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_test_utility_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_pm_test_utility_api[0].id
  api_version           = "v1"
  service_url           = local.apim_pm_test_utility_api.service_url

  description  = local.apim_pm_test_utility_api.description
  display_name = local.apim_pm_test_utility_api.display_name
  path         = local.apim_pm_test_utility_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/test-utility/v1/_openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = file("./api/payment_manager_api/test-utility/v1/_base_policy.xml.tpl")
}
