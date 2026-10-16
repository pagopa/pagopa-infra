module "qa_sa_dqf" {
  source            = "./.terraform/modules/__v4__/IDH/storage_account"
  env               = var.env
  idh_resource_tier = "basic"
  product_name      = local.prefix

  domain              = local.domain
  name                = replace("${local.project}-dqf-sa", "-", "")
  resource_group_name = azurerm_resource_group.qa_rg.name
  location            = azurerm_resource_group.qa_rg.location
  embedded_subnet = {
    enabled      = true,
    vnet_name    = data.azurerm_virtual_network.spoke_data_vnet.name,
    vnet_rg_name = data.azurerm_virtual_network.spoke_data_vnet.resource_group_name,
  }

  private_dns_zone_blob_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  private_dns_zone_file_ids = [data.azurerm_private_dns_zone.privatelink_file_core_windows_net.id]

  #   network_rules = {
  #     default_action             = "Deny"
  #     bypass                     = ["AzureServices"]
  #     ip_rules                   = ["<PUBLIC_IP_TO_WHITELIST>"]
  #     virtual_network_subnet_ids = []
  #   }

  tags = module.tag_config.tags
}

# Blob container for DQF data
resource "azurerm_storage_container" "dqf_data" {
  name                  = "dqf-data"
  storage_account_id    = module.qa_sa_dqf.id
  container_access_type = "private"
}

# Read/write SAS on dqf-data, expiry pinned far in the future (Azure requires an expiry, no "never" option)
data "azurerm_storage_account_blob_container_sas" "dqf_data" {
  connection_string = module.qa_sa_dqf.primary_connection_string
  container_name    = azurerm_storage_container.dqf_data.name

  start  = "2026-09-25T00:00:00Z"
  expiry = "2027-10-01T23:59:59Z"

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = false
    list   = true
  }
}

resource "azurerm_key_vault_secret" "dqf_data_sas_token" {
  name         = "dqf-data-sas-token"
  value        = data.azurerm_storage_account_blob_container_sas.dqf_data.sas
  key_vault_id = data.azurerm_key_vault.domain_kv.id
}
