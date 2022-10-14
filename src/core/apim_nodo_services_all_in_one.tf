#####################################################################################################
# The followig section define 2 products to define ALL-IN-ONE path to nodo onCloud NEXI SIT and DEV #
#####################################################################################################

################################
## Nodo on CLoud AllInOne SIT ##
################################

module "apim_nodo_oncloud_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-nodo-oncloud"
  display_name = "product-nodo-oncloud"
  description  = "product-nodo-oncloud"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = var.nodo_pagamenti_subkey_required
  approval_required     = false

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_oncloud_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-nodo-oncloud-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Nodo OnCloud SIT"
  versioning_scheme   = "Segment"
}

module "apim_nodo_oncloud_api" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-oncloud-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_oncloud_product[0].product_id]
  subscription_required = var.nodo_pagamenti_subkey_required

  version_set_id = azurerm_api_management_api_version_set.nodo_oncloud_api[0].id
  api_version    = "v1"

  description  = "NodeDeiPagamenti (oncloud)"
  display_name = "NodeDeiPagamenti (oncloud)"
  path         = "nodo-pagamenti/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/nodopagamenti_api/nodoServices/v1/_base_policy.xml")

}


################################
## Nodo on CLoud AllInOne DEV ##
################################

module "apim_nodo_oncloud_dev_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-nodo-oncloud-dev"
  display_name = "product-nodo-oncloud-dev"
  description  = "product-nodo-oncloud-dev"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = var.nodo_pagamenti_subkey_required
  approval_required     = false

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_oncloud_dev_api" {
  count               = var.env_short == "d" ? 1 : 0
  name                = format("%s-nodo-oncloud-dev-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Nodo OnCloud DEV"
  versioning_scheme   = "Segment"
}

module "apim_nodo_oncloud_dev_api" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-oncloud-dev-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_oncloud_dev_product[0].product_id]
  subscription_required = var.nodo_pagamenti_subkey_required

  version_set_id = azurerm_api_management_api_version_set.nodo_oncloud_dev_api[0].id
  api_version    = "v1"

  description  = "NodeDeiPagamenti (oncloud) DEV"
  display_name = "NodeDeiPagamenti (oncloud) DEV"
  path         = "nodo-pagamenti-dev/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/nodopagamenti_api/nodoServices/v1/_base_policy_dev.xml")

}

####################################
## Nodo on CLoud AllInOne UAT/PRF ##
####################################

module "apim_nodo_oncloud_uat_product" {
  count  = var.env_short == "u" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-nodo-oncloud-uat"
  display_name = "product-nodo-oncloud-uat"
  description  = "product-nodo-oncloud-uat"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = var.nodo_pagamenti_subkey_required
  approval_required     = false

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_oncloud_uat_api" {
  count               = var.env_short == "u" ? 1 : 0
  name                = format("%s-nodo-oncloud-uat-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Nodo OnCloud UAT"
  versioning_scheme   = "Segment"
}

module "apim_nodo_oncloud_uat_api" {
  count  = var.env_short == "u" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-oncloud-uat-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_oncloud_uat_product[0].product_id]
  subscription_required = var.nodo_pagamenti_subkey_required

  version_set_id = azurerm_api_management_api_version_set.nodo_oncloud_uat_api[0].id
  api_version    = "v1"

  description  = "NodeDeiPagamenti (oncloud) UAT"
  display_name = "NodeDeiPagamenti (oncloud) UAT"
  path         = "nodo-pagamenti-uat-prf/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/nodopagamenti_api/nodoServices/v1/_base_policy_uat_prf.xml")

}

