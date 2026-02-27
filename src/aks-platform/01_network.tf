module "aks_snet" {
  source = "./.terraform/modules/__v4__//subnet"

  name                 = "${local.project}-aks-snet"
  address_prefixes     = var.aks_cidr_subnet
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name

  service_endpoints = [
    "Microsoft.AzureCosmosDB",
    "Microsoft.EventHub",
    "Microsoft.Storage",
    "Microsoft.ServiceBus"
  ]

}

resource "azurerm_public_ip" "aks_outbound" {
  count = var.aks_num_outbound_ips

  name                = format("%s-aksoutbound-pip-%02d", local.project, count.index + 1)
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  sku                 = "Standard"
  allocation_method   = "Static"
  zones               = [1, 2, 3]

  tags = module.tag_config.tags
}
