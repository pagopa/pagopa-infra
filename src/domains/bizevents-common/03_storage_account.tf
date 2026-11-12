module "bizevents_sa" {
  source = "./.terraform/modules/__v4__/IDH/storage_account"

  name = replace(format("%s-sa", local.project), "-", "")

  product_name        = var.prefix
  env                 = var.env
  idh_resource_tier   = var.bizevents_sa_idh_resource_tier
  domain              = var.domain
  location            = var.location
  resource_group_name = azurerm_resource_group.bizevents_rg.name
  tags                = module.tag_config.tags

  embedded_subnet = {
    enabled      = var.env_short != "d"
    vnet_name    = data.azurerm_virtual_network.vnet.name
    vnet_rg_name = data.azurerm_virtual_network.vnet.resource_group_name
  }

  private_dns_zone_blob_ids  = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  private_dns_zone_queue_ids = [data.azurerm_private_dns_zone.privatelink_queue_azure_com.id]
  private_dns_zone_table_ids = [data.azurerm_private_dns_zone.privatelink_table_azure_com.id]
}
