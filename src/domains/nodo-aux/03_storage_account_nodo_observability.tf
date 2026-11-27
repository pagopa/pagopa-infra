resource "azurerm_resource_group" "nodo_observability_rg" {
  count    = var.nodo_observability_enabled ? 1 : 0
  name     = format("%s-nodo-observability-rg", local.product)
  location = var.location

  tags = module.tag_config.tags
}

module "nodo_observability_sa" {
  source = "./.terraform/modules/__v4__/storage_account"

  count    = var.nodo_observability_enabled ? 1 : 0
  depends_on = [
    azurerm_resource_group.nodo_observability_rg
  ]

  name                            = replace("${local.project}-obsv-sa", "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = var.nodo_observability_storage_account.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = var.nodo_observability_storage_account.blob_versioning_enabled
  resource_group_name             = azurerm_resource_group.nodo_observability_rg[0].name
  location                        = var.location
  advanced_threat_protection      = var.nodo_observability_storage_account.advanced_threat_protection
  allow_nested_items_to_be_public = false

  blob_delete_retention_days    = var.nodo_observability_storage_account.blob_delete_retention_days
  public_network_access_enabled = false

  index_document                = "index.html"
  error_404_document            = "error.html"

  tags = module.tag_config.tags
}

# blob $web
resource "azurerm_storage_container" "observability_web_storage" {
  count      = var.nodo_observability_enabled ? 1 : 0
  depends_on = [module.nodo_observability_sa]

  name                  = "$web"
  storage_account_id    = module.nodo_observability_sa[0].id # pagopa<env_short>weunodoobsvsa
  container_access_type = "private"
}

# blob checkpoint
resource "azurerm_storage_container" "observability_checkpoint_storage" {
  count      = var.nodo_observability_enabled ? 1 : 0
  depends_on = [module.nodo_observability_sa]

  name                  = "observability-checkpoint-storage"
  storage_account_id    = module.nodo_observability_sa[0].id # pagopa<env_short>weunodoobsvsa
  container_access_type = "private"
}

# private endopoint
resource "azurerm_private_endpoint" "observability_checkpoint_storage_blob_private_endpoint" {
  count      = var.nodo_observability_enabled ? 1 : 0
  depends_on = [module.nodo_observability_sa]

  name                = "${local.project}-observability-private-endpoint-blob"
  location            = var.location
  resource_group_name = azurerm_resource_group.nodo_observability_rg[0].name
  subnet_id           = data.azurerm_subnet.private_endpoint_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-observability-private-dns-zone-group-blob"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-observability-private-service-connection-blob"
    private_connection_resource_id = module.nodo_observability_sa[0].id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "observability_web_storage_web_private_endpoint" {
  count      = var.nodo_observability_enabled ? 1 : 0
  depends_on = [module.nodo_observability_sa]

  name                = "${local.project}-observability-private-endpoint-web"
  location            = var.location
  resource_group_name = azurerm_resource_group.nodo_observability_rg[0].name
  subnet_id           = data.azurerm_subnet.private_endpoint_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-observability-private-dns-zone-group-web"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_web_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-observability-private-service-connection-web"
    private_connection_resource_id = module.nodo_observability_sa[0].id
    is_manual_connection           = false
    subresource_names              = ["web"]
  }

  tags = module.tag_config.tags
}