resource "azurerm_resource_group" "storage_ecommerce_rg" {
  name     = "${local.project}-storage-rg"
  location = var.location
  tags     = var.tags
}


module "ecommerce_storage_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.7.0"

  name                 = "${local.project}-storage-snet"
  address_prefixes     = var.cidr_subnet_storage_ecommerce
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Storage",
  ]
}

resource "azurerm_private_endpoint" "storage_private_endpoint" {
  count = var.env_short != "d" ? 1 : 0

  name                = "${local.project}-storage-private-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.storage_ecommerce_rg.name
  subnet_id           = module.ecommerce_storage_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-storage-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.storage.id]
  }

  private_service_connection {
    name                           = "${local.project}-storage-private-service-connection"
    private_connection_resource_id = module.ecommerce_storage.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  tags = var.tags
}


resource "azurerm_private_endpoint" "storage_transient_private_endpoint" {
  count = var.env_short != "d" ? 1 : 0

  name                = "${local.project}-tr-storage-private-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.storage_ecommerce_rg.name
  subnet_id           = module.ecommerce_storage_snet.id
  private_dns_zone_group {
    name                 = "${local.project}-storage-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.storage.id]
  }

  private_service_connection {
    name                           = "${local.project}-storage-private-service-connection"
    private_connection_resource_id = module.ecommerce_storage_transient.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  tags = var.tags
}

module "ecommerce_storage" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.7.0"


  name                            = replace("${local.project}-sa", "-", "")
  account_kind                    = var.ecommerce_storage_params.kind
  account_tier                    = var.ecommerce_storage_params.tier
  account_replication_type        = var.ecommerce_storage_params.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = true
  resource_group_name             = azurerm_resource_group.storage_ecommerce_rg.name
  location                        = var.location
  advanced_threat_protection      = var.ecommerce_storage_params.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.ecommerce_storage_params.public_network_access_enabled

  blob_delete_retention_days = var.ecommerce_storage_params.retention_days

  network_rules = var.env_short != "d" ? {
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = [module.ecommerce_storage_snet.id]
    bypass                     = ["AzureServices"]
  } : null

  tags = var.tags
}

module "ecommerce_storage_transient" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.7.0"


  name                            = replace("${local.project}-tr-sa", "-", "")
  account_kind                    = var.ecommerce_storage_transient_params.kind
  account_tier                    = var.ecommerce_storage_transient_params.tier
  account_replication_type        = var.ecommerce_storage_transient_params.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = true
  resource_group_name             = azurerm_resource_group.storage_ecommerce_rg.name
  location                        = var.location
  advanced_threat_protection      = var.ecommerce_storage_transient_params.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.ecommerce_storage_transient_params.public_network_access_enabled

  blob_delete_retention_days = var.ecommerce_storage_transient_params.retention_days

  network_rules = var.env_short != "d" ? {
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = [module.ecommerce_storage_snet.id]
    bypass                     = ["AzureServices"]
  } : null
  tags = var.tags
}

resource "azurerm_storage_queue" "notifications_service_retry_queue" {
  name                 = "${local.project}-notifications-service-retry-queue"
  storage_account_name = module.ecommerce_storage.name
}

resource "azurerm_storage_queue" "notifications_service_errors_queue" {
  name                 = "${local.project}-notifications-service-errors-queue"
  storage_account_name = module.ecommerce_storage.name
}

resource "azurerm_storage_queue" "transactions_expiration_queue" {
  name                 = "${local.project}-transactions-expiration-queue"
  storage_account_name = module.ecommerce_storage.name
}

resource "azurerm_storage_queue" "transactions_close_payment_queue" {
  name                 = "${local.project}-transactions-close-payment-queue"
  storage_account_name = module.ecommerce_storage.name
}

resource "azurerm_storage_queue" "transactions_close_payment_retry_queue" {
  name                 = "${local.project}-transactions-close-payment-retry-queue"
  storage_account_name = module.ecommerce_storage.name
}

resource "azurerm_storage_queue" "transactions_refund_retry_queue" {
  name                 = "${local.project}-transactions-refund-retry-queue"
  storage_account_name = module.ecommerce_storage.name
}

resource "azurerm_storage_queue" "transactions_refund_queue" {
  name                 = "${local.project}-transactions-refund-queue"
  storage_account_name = module.ecommerce_storage.name
}

resource "azurerm_storage_queue" "transactions_notifications_retry_queue" {
  name                 = "${local.project}-transaction-notifications-retry-queue"
  storage_account_name = module.ecommerce_storage.name
}

resource "azurerm_storage_queue" "transactions_notifications_queue" {
  name                 = "${local.project}-transaction-notifications-queue"
  storage_account_name = module.ecommerce_storage.name
}

resource "azurerm_storage_queue" "transactions_dead_letter_queue" {
  name                 = "${local.project}-transactions-dead-letter-queue"
  storage_account_name = module.ecommerce_storage.name
}

resource "azurerm_private_endpoint" "storage_deadletter_private_endpoint" {
  count = var.env_short != "d" ? 1 : 0

  name                = "${local.project}-dl-storage-private-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.storage_ecommerce_rg.name
  subnet_id           = module.ecommerce_storage_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-storage-private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.storage.id]
  }

  private_service_connection {
    name                           = "${local.project}-storage-private-service-connection"
    private_connection_resource_id = module.ecommerce_storage_deadletter.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  tags = var.tags
}

module "ecommerce_storage_deadletter" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v6.7.0"


  name                            = replace("${local.project}-dl-sa", "-", "")
  account_kind                    = var.ecommerce_storage_deadletter_params.kind
  account_tier                    = var.ecommerce_storage_deadletter_params.tier
  account_replication_type        = var.ecommerce_storage_deadletter_params.account_replication_type
  access_tier                     = "Hot"
  blob_versioning_enabled         = true
  resource_group_name             = azurerm_resource_group.storage_ecommerce_rg.name
  location                        = var.location
  advanced_threat_protection      = var.ecommerce_storage_deadletter_params.advanced_threat_protection
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = var.ecommerce_storage_deadletter_params.public_network_access_enabled

  blob_delete_retention_days = var.ecommerce_storage_deadletter_params.retention_days

  network_rules = var.env_short != "d" ? {
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = [module.ecommerce_storage_snet.id]
    bypass                     = ["AzureServices"]
  } : null

  tags = var.tags
}