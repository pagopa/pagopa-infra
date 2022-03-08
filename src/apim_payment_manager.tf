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

data "azurerm_key_vault_secret" "pm_gtw_hostname" {
  name         = "pm-gtw-hostname"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "pm_restapi_ip" {
  name         = "pm-restapi-ip"
  key_vault_id = module.key_vault.id
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
    path                  = "payment-manager/pp-restapi"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "pm_restapi_api" {

  name                = format("%s-pm-restapi-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_restapi_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_restapi_api_v4" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-restapi-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_manager_api/restapi/v4/_base_policy.xml.tpl")
}

#####################################
## API restapi CD                  ##
#####################################
locals {
  apim_pm_restapicd_api = {
    # params for all api versions
    display_name          = "Payment Manager restapi CD API"
    description           = "API to support payment trasactions for app IO"
    path                  = "pp-restapi-CD"
    subscription_required = false
    service_url           = null
  }
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
  content_value = templatefile("./api/payment_manager_api/restapi-cd/v1/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_manager_api/restapi-cd/v1/_base_policy.xml.tpl")
}

module "apim_pm_restapicd_api_v2" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-restapicd-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapicd_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapicd_api.id
  api_version           = "v2"
  service_url           = local.apim_pm_restapicd_api.service_url

  description  = local.apim_pm_restapicd_api.description
  display_name = local.apim_pm_restapicd_api.display_name
  path         = local.apim_pm_restapicd_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/restapi-cd/v2/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_manager_api/restapi-cd/v2/_base_policy.xml.tpl")
}

module "apim_pm_restapicd_api_v3" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-restapicd-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapicd_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapicd_api.id
  api_version           = "v3"
  service_url           = local.apim_pm_restapicd_api.service_url

  description  = local.apim_pm_restapicd_api.description
  display_name = local.apim_pm_restapicd_api.display_name
  path         = local.apim_pm_restapicd_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/restapi-cd/v3/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_manager_api/restapi-cd/v3/_base_policy.xml.tpl")
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

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-restapi-cd-assets", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapicd_assets_api.subscription_required
  service_url           = local.apim_pm_restapicd_assets_api.service_url

  description  = local.apim_pm_restapicd_assets_api.description
  display_name = local.apim_pm_restapicd_assets_api.display_name
  path         = local.apim_pm_restapicd_assets_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/restapi-cd-assets/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_manager_api/restapi-cd-assets/_base_policy.xml.tpl")
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

  name                = format("%s-pm-restapi-server-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_restapi_server_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_restapi_server_api_v4" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-restapi-server-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_restapi_server_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapi_server_api.id
  api_version           = "v4"
  service_url           = local.apim_pm_restapi_server_api.service_url

  description  = local.apim_pm_restapi_server_api.description
  display_name = local.apim_pm_restapi_server_api.display_name
  path         = local.apim_pm_restapi_server_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/restapi-server/v4/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
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

data "azurerm_key_vault_secret" "pm_restapirtd_ip" {
  name         = "pm-restapirtd-ip"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_api_version_set" "pm_restapirtd_api" {

  name                = format("%s-pm-restapirtd-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_restapirtd_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_restapirtd_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-restapirtd-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_manager_api/restapi-rtd/v1/_base_policy.xml.tpl")
}

module "apim_pm_restapirtd_api_v2" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-restapirtd-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_manager_api/restapi-rtd/v2/_base_policy.xml.tpl")
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
  key_vault_id = module.key_vault.id
}

module "apim_pm_logging_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-logging-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_logging_api.subscription_required
  service_url           = local.apim_pm_logging_api.service_url

  description  = local.apim_pm_logging_api.description
  display_name = local.apim_pm_logging_api.display_name
  path         = local.apim_pm_logging_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/logging/v1/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
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
  service_url           = local.apim_pm_adminpanel_api.service_url

  description  = local.apim_pm_adminpanel_api.description
  display_name = local.apim_pm_adminpanel_api.display_name
  path         = local.apim_pm_adminpanel_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/admin-panel/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/payment_manager_api/admin-panel/_base_policy.xml.tpl", {
    origin = format("https://api.%s.%s", var.dns_zone_prefix, var.external_domain)
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
  key_vault_id = module.key_vault.id
}

module "apim_pm_wisp_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-wisp-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_wisp_api.subscription_required
  service_url           = local.apim_pm_wisp_api.service_url

  description  = local.apim_pm_wisp_api.description
  display_name = local.apim_pm_wisp_api.display_name
  path         = local.apim_pm_wisp_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/payment_manager_api/wisp/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_manager_api/wisp/_base_policy.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "get_spid_metadata_api" {
  api_name            = format("%s-pm-wisp-api", local.project)
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = "GETSpidMetadata"

  xml_content = templatefile("./api/payment_manager_api/wisp/_spid_metadata_policy.xml.tpl", { metadata = data.azurerm_key_vault_secret.pm_wisp_metadata.value })
}


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

  name                = format("%s-pm-ptg-api", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_ptg_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_ptg_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-ptg-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_payment_manager_product.product_id]
  subscription_required = local.apim_pm_ptg_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.pm_restapirtd_api.id
  api_version           = "v1"
  service_url           = local.apim_pm_ptg_api.service_url

  description  = local.apim_pm_ptg_api.description
  display_name = local.apim_pm_ptg_api.display_name
  path         = local.apim_pm_ptg_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/payment-transactions-gateway/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/payment_manager_api/payment-transactions-gateway/v1/_base_policy.xml.tpl")
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
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pmclient_iobpd_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pmclient_iobpd_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pmclient-iobpd-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
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
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_paypalpsp_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_paypalpsp_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-paypalpsp-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
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
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_xpay_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_xpay_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-xpay-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
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
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_bpd_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_bpd_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-bpd-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
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
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_cobadge_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_cobadge_api_v4" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-cobadge-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
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
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_satispay_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_satispay_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-satispay-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
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
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_pm_fesp_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_pm_fesp_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-pm-fesp-api", local.project)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
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
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/payment_manager_api/clients/fesp/_base_policy.xml.tpl", {
    endpoint = format("https://%s", var.fesp_hostname)
  })
}
