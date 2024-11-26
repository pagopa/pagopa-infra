data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}

data "azurerm_subnet" "apim_vnet" {
  name                 = local.pagopa_apim_snet
  resource_group_name  = local.pagopa_vnet_rg
  virtual_network_name = local.pagopa_vnet_integration
}

data "azurerm_dns_zone" "public" {
  name = join(".", [var.apim_dns_zone_prefix, var.external_domain])
}

module "taxonomy_function_snet" {
  source                                    = "./.terraform/modules/__v3__/subnet"
  name                                      = "${local.project}-txnm-fn-snet"
  address_prefixes                          = var.taxonomy_function_subnet
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = var.taxonomy_function_network_policies_enabled

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.Storage"
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "shared_pdf_engine_app_service_snet" {
  source = "./.terraform/modules/__v3__/subnet"

  name                                      = format("%s-pdf-engine-snet", local.project)
  address_prefixes                          = var.cidr_subnet_pdf_engine_app_service
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = local.vnet_name
  private_endpoint_network_policies_enabled = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
