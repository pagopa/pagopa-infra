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
