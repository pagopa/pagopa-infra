##############
## Products ##
##############
module "apim_cfg_for_node_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "cfg-for-node"
  display_name = "CFG for Node"
  description  = "Internal APIs regarding Node configuration"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/cfg-for-node/_base_policy.xml")
}

resource "azurerm_api_management_product_group" "access_control_developers_for_cfg_for_node" {
  product_id          = module.apim_cfg_for_node_product.product_id
  group_name          = data.azurerm_api_management_group.group_developers.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}


############################
## API defined in repository
############################


###############################
## APIM CACHE MANAGEMENT API ##
##  -> INTERNAL              ##
###############################
locals {
  apim_apim_cache = file("./api/internal-service/v1/apim_cache_base_policy.xml")
  getCache_v1_policy = file("./api/internal-service/v1/get_cache_v1_policy.xml")
  deleteCache_v1_policy = file("./api/internal-service/v1/delete_cache_v1_policy.xml")
  setCache_v1_policy = file("./api/internal-service/v1/set_cache_v1_policy.xml")
}

resource "azurerm_api_management_api_version_set" "apim_cache_v1" {
  name                = "${var.env_short}-apim-cache"
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  api_management_name = data.azurerm_api_management.apim.name
  description         = "API to manage the cache used by the APIM"
  display_name        = "APIM Cache [internal]"
  versioning_scheme   = "Segment"
}

resource "terraform_data" "sha256_apim_cache_v1" {
  input = sha256(local.apim_apim_cache)
}
module "apim_cache_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                = azurerm_api_management_api_version_set.apim_cache_v1.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  product_ids = [module.apim_cfg_for_node_product.product_id]

  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.apim_cache_v1.id
  api_version    = "v1"
  service_url    = null

  description  = azurerm_api_management_api_version_set.apim_cache_v1.description
  display_name = azurerm_api_management_api_version_set.apim_cache_v1.display_name
  path         = "apim-cache"
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = file("./api/internal-service/v1/apim_cache_openapi.json")

  xml_content = local.apim_apim_cache

  # api_operation_policies = [
  #   {
  #     operation_id = "getCache"
  #     xml_content  = local.getCache_v1_policy
  #   },
  #   {
  #     operation_id = "deleteCache"
  #     xml_content  = local.deleteCache_v1_policy
  #   },
  #   {
  #     operation_id = "setCache"
  #     xml_content  = local.setCache_v1_policy
  #   }
  # ]
}
