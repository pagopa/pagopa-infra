module "gpd_audit_sa" {
  count             = var.env_short == "p" ? 1 : 0
  source            = "./.terraform/modules/__v4__/IDH/storage_account"
  env               = var.env
  idh_resource_tier = "basic"
  product_name      = var.prefix

  domain              = var.domain
  name                = replace("${local.project}-audit-sa", "-", "")
  resource_group_name = azurerm_resource_group.gpd_rg.name
  location            = azurerm_resource_group.gpd_rg.location
  embedded_subnet = {
    enabled      = true,
    vnet_name    = data.azurerm_virtual_network.spoke_data_vnet.name,
    vnet_rg_name = data.azurerm_virtual_network.spoke_data_vnet.resource_group_name,
  }

  private_dns_zone_blob_ids = [data.azurerm_private_dns_zone.storage.id]

  tags = module.tag_config.tags
}

## rtp audit blob container
resource "azurerm_storage_container" "rtp_audit_blob_file" {
  count                 = var.env_short == "p" ? 1 : 0
  name                  = "rtp-audit"
  storage_account_id    = module.gpd_audit_sa[0].id
  container_access_type = "private"
}
