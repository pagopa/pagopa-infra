# named-values

resource "azurerm_api_management_named_value" "afm_marketplace_sub_key_internal" {
  name                = "afm-marketplace-sub-key-internal"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "afm-marketplace-sub-key-internal"
  value               = "<TO_UPDATE_MANUALLY_BY_PORTAL>"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#############################
## Product AFM Marketplace ##
#############################
locals {
  apim_afm_marketplace_service_api = {
    display_name          = "AFM Marketplace pagoPA - marketplace of advanced fees management service API"
    description           = "Marketplace API to support advanced fees management service"
    path                  = "afm/marketplace-service"
    subscription_required = true
    service_url           = null
  }

  apim_afm_utils_api = {
    display_name          = "AFM Utils pagoPA - utilities of advanced fees management service API"
    description           = "Utility API to support advanced fees management service"
    path                  = "afm/utils"
    subscription_required = true
    service_url           = null
  }
}
module "apim_afm_marketplace_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "afm-marketplace"
  display_name = local.apim_afm_marketplace_service_api.display_name
  description  = local.apim_afm_marketplace_service_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apim_afm_marketplace_service_api.subscription_required
  approval_required     = false

  policy_xml = file("./api_product/marketplace/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "api_afm_marketplace_api" {

  name                = format("%s-afm-marketplace-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_afm_marketplace_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_afm_marketplace_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-afm-marketplace-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_afm_marketplace_product.product_id]
  subscription_required = local.apim_afm_marketplace_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_afm_marketplace_api.id
  api_version           = "v1"

  description  = local.apim_afm_marketplace_service_api.description
  display_name = local.apim_afm_marketplace_service_api.display_name
  path         = local.apim_afm_marketplace_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_afm_marketplace_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/marketplace-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/marketplace-service/v1/_base_policy.xml", {
    hostname = local.afm_hostname
  })
}


##################################
##  API AFM Utils ##
##################################

resource "azurerm_api_management_api_version_set" "api_afm_utils_api" {
  name                = format("%s-afm-utils-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_afm_utils_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_afm_utils_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-afm-utils-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_afm_marketplace_product.product_id]
  subscription_required = local.apim_afm_utils_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_afm_utils_api.id
  api_version           = "v1"

  description  = local.apim_afm_utils_api.description
  display_name = local.apim_afm_utils_api.display_name
  path         = local.apim_afm_utils_api.path
  protocols    = ["https"]
  service_url  = local.apim_afm_utils_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/marketplace-service/utils/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/marketplace-service/utils/_base_policy.xml", {
    hostname = local.afm_hostname
  })
}
