module "afm_storage" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.18.10"

  name                       = replace("${var.prefix}-${var.env_short}-afm-sa", "-", "")
  account_kind               = var.afm_storage_params.kind
  account_tier               = var.afm_storage_params.tier
  account_replication_type   = var.afm_storage_params.account_replication_type
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = true
  resource_group_name        = azurerm_resource_group.afm_rg.name
  location                   = var.location
  advanced_threat_protection = var.afm_storage_params.advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.afm_storage_params.retention_days

  network_rules = var.storage_private_endpoint_enabled ? {
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = [module.afm_storage_snet.id]
    bypass                     = ["AzureServices"]
  } : null

  tags = var.tags
}

module "afm_storage_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.18.10"
  name                 = "${local.project}-storage-snet"
  address_prefixes     = var.cidr_subnet_afm_storage
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Storage",
  ]
}

resource "azurerm_storage_container" "afm_data_volume" {
  name                  = "${local.project}-data-volume"
  storage_account_name  = module.afm_storage.name
  container_access_type = "private"
}

resource "azurerm_private_endpoint" "storage_private_endpoint" {
  count = var.storage_private_endpoint_enabled ? 1 : 0

  name                = "${local.project}-storage-private-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.afm_rg.name
  subnet_id           = module.afm_storage_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-storage-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.storage[0].id]
  }

  private_service_connection {
    name                           = "${local.project}-storage-private-service-connection"
    private_connection_resource_id = module.afm_storage.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  tags = var.tags
}
