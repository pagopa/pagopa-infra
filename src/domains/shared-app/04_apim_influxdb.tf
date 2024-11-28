##############
## Products ##
##############

module "apim_influxdb_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "influxdb"
  display_name = "Influxdb"
  description  = "Prodotto Influxdb"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_influxdb_policy.xml")
}

###########
##  API  ##
###########
locals {
  apim_influxdb_service_api = {
    display_name          = "Influxdb - API"
    description           = "API to influxdb"
    path                  = "shared/influxdb"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_influxdb_api" {

  name                = format("%s-influxdb-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_influxdb_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_influxdb_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-influxdb-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_influxdb_product.product_id]
  subscription_required = local.apim_influxdb_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_influxdb_api.id
  api_version           = "v1"

  description  = local.apim_influxdb_service_api.description
  display_name = local.apim_influxdb_service_api.display_name
  path         = local.apim_influxdb_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_influxdb_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/influxdb/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/influxdb/v1/_base_policy.xml", {
    hostname = local.shared_hostname
  })
}

##############
##  API v2  ##
##############
locals {
  apim_influxdb2_service_api = {
    display_name          = "Influxdb2 - API"
    description           = "API to influxdb v2"
    path                  = "shared/influxdb"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_influxdb2_api" {

  name                = format("%s-influxdb2-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_influxdb2_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_influxdb_api_v2" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-influxdb-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_influxdb_product.product_id]
  subscription_required = local.apim_influxdb_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_influxdb_api.id
  api_version           = "v2"

  description  = local.apim_influxdb_service_api.description
  display_name = local.apim_influxdb_service_api.display_name
  path         = local.apim_influxdb_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_influxdb_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/influxdb/v2/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/influxdb/v2/_base_policy.xml", {
    hostname = local.shared_hostname
  })
}
