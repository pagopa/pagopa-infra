resource "azurerm_resource_group" "qa_rg" {
  name     = "${local.project}-sa-rg"
  location = var.location

  tags = module.tag_config.tags
}

# Grant CD identity permission to upload files via az CLI --auth-mode login
resource "azurerm_role_assignment" "identity_cd_storage_file_contributor" {
  scope                = module.qa_sa_shared.id
  role_definition_name = "Storage File Data SMB Share Contributor"
  principal_id         = module.identity_cd_01.identity_principal_id
}

module "qa_sa_shared" {
  source            = "./.terraform/modules/__v4__/IDH/storage_account"
  env               = var.env
  idh_resource_tier = "basic"
  product_name      = local.prefix

  domain              = local.domain
  name                = replace("${local.project}-shared-sa", "-", "")
  resource_group_name = azurerm_resource_group.qa_rg.name
  location            = azurerm_resource_group.qa_rg.location
  embedded_subnet = {
    enabled      = true,
    vnet_name    = data.azurerm_virtual_network.spoke_data_vnet.name,
    vnet_rg_name = data.azurerm_virtual_network.spoke_data_vnet.resource_group_name,
  }

  private_dns_zone_blob_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]

  tags = module.tag_config.tags
}

# Storage shares for MCP catalog
resource "azurerm_storage_share" "mcp_catalog" {
  name                 = "mcp-catalog"
  storage_account_name = module.qa_sa_shared.name
  quota                = 1
}

# Storage share directories for MCP catalog
resource "azurerm_storage_share_directory" "mcp_catalog_manifests" {
  name             = "manifests"
  storage_share_id = azurerm_storage_share.mcp_catalog.id
}

resource "azurerm_storage_share_directory" "mcp_catalog_assets" {
  name             = "assets"
  storage_share_id = azurerm_storage_share.mcp_catalog.id
}

