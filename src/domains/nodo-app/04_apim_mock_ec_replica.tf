######################
## Products REPLICA ##
######################

module "apim_mock_ec_product_replica" {
  source       = "./.terraform/modules/__v3__/api_management_product"
  count        = var.env_short == "p" ? 0 : 1
  product_id   = "mock_ec_replica"
  display_name = "Mock EC for REPLICA NDP"
  description  = "Mock EC for REPLICA NDP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 0

  policy_xml = file("./api_product/mock-ec-service-replica/_base_policy.xml")
}

###############################
##    Mock EC  NDP  REPLICA  ##
###############################
locals {
  apim_mock_ec_service_api_replica = {
    display_name          = "Mock EC for REPLICA NDP"
    description           = "API Mock EC for REPLICA NDP"
    path                  = "mock-ec-replica-ndp/service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_mock_ec_api_replica" {
  count               = var.env_short == "p" ? 0 : 1
  name                = format("%s-mock-ec-service-api-replica", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_mock_ec_service_api_replica.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_mock_ec_api_replica_v1" {
  source                = "./.terraform/modules/__v3__/api_management_api"
  count                 = var.env_short == "p" ? 0 : 1
  name                  = format("%s-mock-ec-service-api-replica", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_mock_ec_product_replica[0].product_id, module.apim_apim_for_node_product.product_id]
  subscription_required = local.apim_mock_ec_service_api_replica.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_mock_ec_api_replica[0].id
  api_version           = "v1"

  description  = local.apim_mock_ec_service_api_replica.description
  display_name = local.apim_mock_ec_service_api_replica.display_name
  path         = local.apim_mock_ec_service_api_replica.path
  protocols    = ["https"]
  service_url  = local.apim_mock_ec_service_api_replica.service_url

  content_format = "openapi"
  content_value = templatefile("./api/mock-ec-service-replica/v1/_mock-ec.openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/mock-ec-service-replica/v1/_base_policy.xml", {
    hostname = local.nodo_hostname
  })
}
