# resource "azurerm_resource_group" "cruscotto_rg" {
#   name     = "${local.project}-sa-rg"
#   location = var.location

#   tags = module.tag_config.tags
# }

module "crusc8_sa_report" {
  source            = "./.terraform/modules/__v4__/IDH/storage_account"
  env               = var.env
  idh_resource_tier = "basic"
  product_name      = var.prefix

  domain              = var.domain
  name                = replace("${local.project}-be-sa", "-", "")
  resource_group_name = azurerm_resource_group.cruscotto_rg.name
  location            = azurerm_resource_group.cruscotto_rg.location
  embedded_subnet = {
    enabled      = true,
    vnet_name    = data.azurerm_virtual_network.spoke_data_vnet.name,
    vnet_rg_name = data.azurerm_virtual_network.spoke_data_vnet.resource_group_name,
  }

  private_dns_zone_blob_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]

  tags = module.tag_config.tags
}

## Blob containers
resource "azurerm_storage_container" "crusc8_report_blob" {
  name               = "report"
  storage_account_id = module.crusc8_sa_report.id
}