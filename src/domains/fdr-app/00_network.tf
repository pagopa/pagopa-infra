data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_subnet" "apim_vnet" {
  name                 = local.apim_snet
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_integration_name
}

data "azurerm_dns_zone" "public" {
  name = join(".", [var.apim_dns_zone_prefix, var.external_domain])
}

module "fdr_xml_to_json_function_snet" {
  source                                    = "./.terraform/modules/__v3__/subnet"
  name                                      = "${local.project}-xml-to-json-fn-snet"
  address_prefixes                          = var.fdr_xml_to_json_function_subnet
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = var.fdr_xml_to_json_function_network_policies_enabled

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

