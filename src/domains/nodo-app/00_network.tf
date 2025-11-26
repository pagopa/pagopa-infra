data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group_name
}
data "azurerm_subnet" "aks_snet" {
  name                 = local.aks_subnet_name
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group_name
}

module "nodo_re_to_datastore_function_snet" {
  count                                     = var.enable_nodo_re ? 1 : 0
  source                                    = "./.terraform/modules/__v3__/subnet"
  name                                      = "${local.project}-nodo-re-to-datastore-fn-snet"
  address_prefixes                          = var.nodo_re_to_datastore_function_subnet
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = var.nodo_re_to_datastore_network_policies_enabled

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

module "nodo_re_to_tablestorage_function_snet" {
  count                                     = var.enable_nodo_re ? 1 : 0
  source                                    = "./.terraform/modules/__v3__/subnet"
  name                                      = "${local.project}-nodo-re-to-tablestorage-fn-snet"
  address_prefixes                          = var.nodo_re_to_tablestorage_function_subnet
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = var.nodo_re_to_tablestorage_network_policies_enabled

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "nodo_verifyko_to_datastore_function_snet" {
  source                                    = "./.terraform/modules/__v3__/subnet"
  name                                      = "${local.project}-nodo-verifyko-to-datastore-fn-snet"
  address_prefixes                          = var.nodo_verifyko_to_datastore_function_subnet
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = var.nodo_verifyko_to_datastore_network_policies_enabled

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

module "nodo_verifyko_to_tablestorage_function_snet" {
  source                                    = "./.terraform/modules/__v3__/subnet"
  name                                      = "${local.project}-nodo-verifyko-to-tablestorage-fn-snet"
  address_prefixes                          = var.nodo_verifyko_to_tablestorage_function_subnet
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = var.nodo_verifyko_to_tablestorage_network_policies_enabled

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
