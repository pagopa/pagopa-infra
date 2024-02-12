locals {
  apim_nododatamigration_api = {
    display_name          = "Nodo Data Migration - API"
    description           = "API for handle the migration of the data from Nexi's OracleDB to PagoPA's PostgreSQL"
    path                  = "nodo/datamigration"
    subscription_required = true
    service_url           = null
  }
}
##############
## Products ##
##############
module "apim_nododatamigration_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.6.0"

  product_id   = "nodo-data-migration"
  display_name = local.apim_nododatamigration_api.display_name
  description  = local.apim_nododatamigration_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apim_nododatamigration_api.subscription_required
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "api_datamigration_api" {

  name                = format("%s-nodo-datamigration-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_nododatamigration_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_nododatamigration_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = format("%s-nodo-datamigration-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_nododatamigration_product.product_id]
  subscription_required = local.apim_nododatamigration_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_datamigration_api.id
  api_version           = "v1"

  description  = local.apim_nododatamigration_api.description
  display_name = local.apim_nododatamigration_api.display_name
  path         = local.apim_nododatamigration_api.path
  protocols    = ["https"]
  service_url  = local.apim_nododatamigration_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/nodo-datamigration/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/nodo-datamigration/v1/_base_policy.xml", {
    hostname = local.nodo_datamigration_hostname
  })
}
