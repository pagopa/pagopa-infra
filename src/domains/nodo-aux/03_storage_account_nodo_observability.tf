# Use the existing storage account used for cdn

# blob checkpoint
resource "azurerm_storage_container" "observability_checkpoint_storage" {
  count      = var.nodo_observability_enabled ? 1 : 0
  depends_on = [module.nodo_observability_cdn]

  name                  = "observability-checkpoint-storage"
  storage_account_id    = module.nodo_observability_cdn[0].storage_id # pagopa<env>observabilitysa
  container_access_type = "private"
}

resource "azurerm_private_endpoint" "observability_checkpoint_storage_blob_private_endpoint" {
  count      = var.nodo_observability_enabled ? 1 : 0
  depends_on = [module.nodo_observability_cdn]

  name                = "${local.project}-observability-private-endpoint-blob"
  location            = var.location
  resource_group_name = module.nodo_observability_cdn[0].storage_resource_group_name
  subnet_id           = data.azurerm_subnet.private_endpoint_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-observability-private-dns-zone-group-blob"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_azure_com.id]
  }

  private_service_connection {
    name                           = "${local.project}-observability-private-service-connection-blob"
    private_connection_resource_id = module.nodo_observability_cdn[0].storage_id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  tags = module.tag_config.tags
}