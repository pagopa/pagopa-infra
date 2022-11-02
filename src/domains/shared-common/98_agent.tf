module "iuvgenerator_loadtest_agent_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                 = format("%s-loadtest-agent-snet", local.project)
  address_prefixes     = var.cidr_subnet_loadtest_agent
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]
}

module "azdoa_loadtest_li" {
  source              = "git::https://github.com/pagopa/azurerm.git//azure_devops_agent?ref=v2.18.7"
  count               = var.env_short != "p" ? 1 : 0
  name                = format("%s-azdoa-vmss-loadtest-li", local.project)
  resource_group_name = local.vnet_resource_group_name
  subnet_id           = module.iuvgenerator_loadtest_agent_snet.id
  subscription        = data.azurerm_subscription.current.display_name
  vm_sku              = "Standard_D8ds_v5"

  tags = var.tags
}
