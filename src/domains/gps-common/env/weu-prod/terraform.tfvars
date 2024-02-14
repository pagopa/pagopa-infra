prefix         = "pagopa"
env_short      = "p"
env            = "prod"
domain         = "gps"
location       = "westeurope"
location_short = "weu"
instance       = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/gps"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"
application_insights_name                   = "pagopa-p-appinsights"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

# CosmosDB GPS
cosmos_gps_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = []
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = true
  enable_free_tier                 = false

  private_endpoint_enabled      = true
  public_network_access_enabled = false
  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]

  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = true
}

# Postgres Flexible
# https://docs.microsoft.com/it-it/azure/postgresql/flexible-server/concepts-high-availability
# https://azure.microsoft.com/it-it/global-infrastructure/geographies/#choose-your-region
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server#geo_redundant_backup_enabled
pgres_flex_params = {

  private_endpoint_enabled = true
  sku_name                 = "GP_Standard_D4ds_v4"
  db_version               = "13"
  # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576,
  # 2097152, 4194304, 8388608, 16777216, and 33554432.
  # https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute-storage#storage
  storage_mb                      = 1048576 # 1Tib
  zone                            = 1
  backup_retention_days           = 7
  geo_redundant_backup_enabled    = true
  create_mode                     = "Default"
  high_availability_enabled       = true
  standby_availability_zone       = 2
  pgbouncer_enabled               = true
  alerts_enabled                  = true
  max_connections                 = 5000
  enable_private_dns_registration = true
}

cidr_subnet_gps_cosmosdb = ["10.1.149.0/24"]
cidr_subnet_pg_flex_dbms = ["10.1.141.0/24"]

# CosmosDb GPD payments
cosmos_gpd_payments_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = ["EnableTable"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = true
  enable_free_tier                 = false

  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]
  private_endpoint_enabled          = true
  public_network_access_enabled     = true
  is_virtual_network_filter_enabled = true

  backup_continuous_enabled = false

  payments_receipts_table = {
    autoscale  = true
    throughput = 3000
  }
}

cidr_subnet_gpd_payments_cosmosdb = ["10.1.149.0/24"]

enable_iac_pipeline                   = true
storage_account_replication_type      = "GZRS"
flow_storage_account_replication_type = "GZRS"
gpd_payments_versioning               = true
enable_gpd_payments_backup            = true
gpd_payments_sa_delete_retention_days = 31
gpd_payments_sa_backup_retention_days = 30


reporting_storage_account = {
  blob_versioning_enabled    = true
  advanced_threat_protection = true
  blob_delete_retention_days = 31
  backup_enabled             = true
  backup_retention           = 30
}

geo_replica_enabled                = true
location_replica                   = "northeurope"
location_replica_short             = "neu"
geo_replica_cidr_subnet_postgresql = ["10.2.141.0/24"]
postgresql_sku_name                = "GP_Gen5_2"

# GPD Storage Account SFTP
gpd_sftp_sa_replication_type                                   = "GZRS"
gpd_sftp_sa_access_tier                                        = "Hot"
gpd_sftp_cidr_subnet_gpd_storage_account                       = ["10.1.152.16/29"]
gpd_sftp_enable_private_endpoint                               = true
gpd_sftp_disable_network_rules                                 = false
gpd_sftp_sa_snet_private_link_service_network_policies_enabled = false
gpd_sftp_sa_public_network_access_enabled                      = true
gpd_sftp_sa_tier_to_cool                                       = 7
gpd_sftp_sa_tier_to_archive                                    = -1 # disabled because with GZRS is not supported
gpd_sftp_sa_delete                                             = 60

# GPD Archive account
gpd_archive_replication_type = "GZRS"
