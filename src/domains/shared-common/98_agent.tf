module "loadtest_agent_snet" {
  count                = var.env_short != "p" ? 1 : 0
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.4.1"
  name                 = format("%s-loadtest-agent-snet", local.project)
  address_prefixes     = var.cidr_subnet_loadtest_agent
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

module "azdoa_loadtest_li" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent?ref=v6.4.1"
  count               = var.env_short != "p" ? 1 : 0
  name                = format("%s-azdoa-vmss-loadtest-li", local.project)
  resource_group_name = local.vnet_resource_group_name
  subnet_id           = module.loadtest_agent_snet[0].id
  subscription        = data.azurerm_subscription.current.display_name
  vm_sku              = "Standard_D8ds_v5"

  tags = var.tags
}
