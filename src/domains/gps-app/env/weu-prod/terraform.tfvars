prefix                 = "pagopa"
env_short              = "p"
env                    = "prod"
domain                 = "gps"
location               = "westeurope"
location_short         = "weu"
location_string        = "West Europe"
instance               = "prod"
gh_runner_job_location = "italynorth"


### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
apim_dns_zone_prefix     = "platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
reporting_function_autoscale_default = 5

# gpd-reporting-functions
reporting_analysis_function_always_on = true

cidr_subnet_reporting_functions = ["10.1.177.0/24"]
reporting_function              = true
reporting_functions_app_sku = {
  kind     = "Linux"
  sku_tier = "PremiumV3"
  sku_size = "P1v3"
}
reporting_function_autoscale_minimum = 3

cname_record_name = "config"

# APIM
create_wisp_converter = true

pod_disruption_budgets = {
  "gpd-core" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "gpd-core"
    }
  },
  "pagopagpdpayments" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopagpdpayments"
    }
  },

  "pagopagpsdonationservice" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopagpsdonationservice"
    }
  },

  "pagopareportingorgsenrollment" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopareportingorgsenrollment"
    }
  },

  "pagopaspontaneouspayments" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaspontaneouspayments"
    }
  },
}


fn_app_storage_account_info = {
  account_replication_type          = "GZRS"
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = true
}


### debezium kafka conn
replicas           = 1 # set 2 in PROD iif want a new istance replicate
request_cpu        = 0.5
limits_cpu         = 2
request_memory     = "512Mi"
limits_memory      = "3072Mi"
postgres_db_name   = "apd"
tasks_max          = "1"
container_registry = "pagopapcommonacr.azurecr.io"
max_threads        = 10
gpd_cdc_enabled    = true
