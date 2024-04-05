##############
## Products ##
##############

module "apim_node_forwarder_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.76.0"

  product_id   = "product-node-forwarder"
  display_name = "pagoPA Node Forwarder API"
  description  = "Product pagoPA Node Forwarder API"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/node_forwarder_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "node_forwarder_api" {

  name                = "${var.env_short}-node-forwarder-api"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "pagoPA Node Forwarder API"
  versioning_scheme   = "Segment"
}

module "apim_node_forwarder_api" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.76.0"

  name                  = "${var.env_short}-node-forwarder-api"
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_node_forwarder_product.product_id, local.apim_x_node_product_id]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.node_forwarder_api.id
  api_version    = "v1"

  description  = "API pagoPA Node Forwarder"
  display_name = "pagoPA Node Forwarder API"
  path         = "pagopa-node-forwarder/api"
  protocols    = ["https"]

  service_url = "https://${module.node_forwarder_app_service.default_site_hostname}"

  content_format = "openapi"
  content_value = templatefile("./api/node_forwarder_api/v1/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/node_forwarder_api/v1/_base_policy.xml", {
    node_forwarder_host_path = "https://${module.node_forwarder_app_service.default_site_hostname}"
  })

  depends_on = [
    module.node_forwarder_app_service
  ]

}
