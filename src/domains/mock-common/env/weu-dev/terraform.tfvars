prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "mock"
location       = "westeurope"
location_short = "weu"
instance       = "dev"


### External resources
monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"
application_insights_name                   = "pagopa-d-appinsights"

ingress_load_balancer_ip = "10.1.100.250"

cidr_subnet_mock_ec              = ["10.1.137.0/29"]
cidr_subnet_mock_payment_gateway = ["10.1.137.8/29"]
cidr_subnet_dbms                 = ["10.1.180.0/24"]
cidr_subnet_mocker_cosmosdb      = ["10.1.192.0/24"]

external_domain          = "pagopa.it"
dns_zone_prefix          = "dev.platform"
dns_zone_internal_prefix = "internal.dev.platform"

mock_ec_enabled                    = true
mock_ec_secondary_enabled          = true
mock_payment_gateway_enabled       = true
mock_psp_service_enabled           = true
mock_psp_secondary_service_enabled = true

enable_iac_pipeline = false


# CosmosDB for Mocker
mocker_cosmosdb_params = {
  kind         = "MongoDB"
  capabilities = ["EnableMongo", "EnableServerless"]
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

  container_default_ttl = 2629800 # 1 month in second
}

# CosmosDb MongoDb
cosmosdb_mongodb_extra_capabilities = ["EnableServerless"]

pagopa_proxy_ip_restriction_default_action = "Allow"
