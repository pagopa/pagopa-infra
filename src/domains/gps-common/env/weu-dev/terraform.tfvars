prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "gps"
location       = "westeurope"
location_short = "weu"
instance       = "dev"


### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"
application_insights_name                   = "pagopa-d-appinsights"

### Aks

ingress_load_balancer_ip = "10.1.100.250"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"

# CosmosDB GPS
cosmos_gps_db_params = {
  kind         = "GlobalDocumentDB"
  capabilities = ["EnableServerless"]
  offer_type   = "Standard"
  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  server_version                   = "4.0"
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  private_endpoint_enabled      = false
  public_network_access_enabled = true

  additional_geo_locations = []

  is_virtual_network_filter_enabled = false

  backup_continuous_enabled = false
}

gpd_upload_status_ttl = 604800 // 7 days

# Postgres Flexible
pgres_flex_params = {

  private_endpoint_enabled = false
  sku_name                 = "GP_Standard_D2ds_v4"
  db_version               = "15"
  # Possible values are 32768, 65536, 131072, 262144, 524288, 1048576,
  # 2097152, 4194304, 8388608, 16777216, and 33554432.
  # https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute-storage#storage
  storage_mb                                       = 32768
  zone                                             = 1
  backup_retention_days                            = 7
  geo_redundant_backup_enabled                     = false
  create_mode                                      = "Default"
  high_availability_enabled                        = false
  standby_availability_zone                        = 2
  pgbouncer_enabled                                = true
  alerts_enabled                                   = false
  max_connections                                  = 1000
  enable_private_dns_registration                  = true
  enable_private_dns_registration_virtual_endpoint = false
  max_worker_process                               = 16
  wal_level                                        = "logical"
  shared_preoload_libraries                        = "pglogical"
  public_network_access_enabled                    = true
}

cidr_subnet_gps_cosmosdb = ["10.1.149.0/24"]
cidr_subnet_pg_flex_dbms = ["10.1.141.0/24"]
#cidr_subnet_pg_singleser = ["10.1.141.0/27"]  # ["10.1.141.0/24"]

postgresql_network_rules = {
  ip_rules = [
    "0.0.0.0/0"
  ]
  # dblink
  allow_access_to_azure_services = false
}

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
  main_geo_location_zone_redundant = false
  enable_free_tier                 = false

  additional_geo_locations          = []
  private_endpoint_enabled          = false
  public_network_access_enabled     = true
  is_virtual_network_filter_enabled = false

  backup_continuous_enabled = false

  payments_receipts_table = {
    autoscale  = true
    throughput = 1000
  }

  payments_pp_table = {
    autoscale  = true
    throughput = 1000
  }
}

cidr_subnet_gpd_payments_cosmosdb = ["10.1.149.0/24"]

enable_iac_pipeline                   = true
gpd_payments_sa_delete_retention_days = 0

# GPD Storage Account SFTP
gpd_sftp_sa_replication_type                                   = "LRS"
gpd_sftp_sa_access_tier                                        = "Hot"
gpd_sftp_cidr_subnet_gpd_storage_account                       = ["10.1.152.16/29"]
gpd_sftp_enable_private_endpoint                               = false
gpd_sftp_disable_network_rules                                 = true
gpd_sftp_sa_snet_private_link_service_network_policies_enabled = false
gpd_sftp_sa_public_network_access_enabled                      = true
gpd_sftp_sa_tier_to_cool                                       = 1
gpd_sftp_sa_tier_to_archive                                    = 1
gpd_sftp_sa_delete                                             = 2

# GPD Archive account
gpd_archive_replication_type = "LRS"
gpd_cdc_enabled              = true

### EventHub

# RTP EventHub
eventhubs_rtp = [
  {
    name              = "rtp-events"
    partitions        = 1 # in PROD shall be changed
    message_retention = 1 # in PROD shall be changed
    consumers         = ["rtp-events-processor", "gpd-rtp-integration-test-consumer-group"]
    keys = [
      {
        name   = "rtp-events-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "rtp-events-rx"
        listen = true
        send   = true
        manage = false
      },
      {
        name   = "rtp-events-integration-test-rx"
        listen = true
        send   = false
        manage = false
      }
    ]
  }
]

eventhub_namespace_rtp = {
  auto_inflate_enabled     = false
  sku_name                 = "Standard"
  capacity                 = null // optional
  maximum_throughput_units = null // necessary if auto_inflate_enabled
  public_network_access    = true
  private_endpoint_created = true
  metric_alerts_create     = false
  metric_alerts            = {}
}

redis_ha_enabled = false

rtp_storage_account = {
  account_kind                       = "StorageV2"
  account_tier                       = "Standard"
  account_replication_type           = "LRS"
  blob_versioning_enabled            = false
  advanced_threat_protection         = false
  advanced_threat_protection_enabled = false
  public_network_access_enabled      = true
  blob_delete_retention_days         = 30
  enable_low_availability_alert      = false
}
