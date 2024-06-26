prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "gps"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"

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

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
apim_dns_zone_prefix     = "platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}

# function_app docker
reporting_batch_image    = "pagopa/pagopa-gpd-reporting-batch"
reporting_service_image  = "pagopagpdreportingservice"
reporting_analysis_image = "pagopagpdreportinganalysis"

# gpd-reporting-functions
gpd_paa_id_intermediario = "15376371009"
gpd_paa_stazione_int     = "15376371009_07"

reporting_batch_function_always_on    = true
reporting_service_function_always_on  = true
reporting_analysis_function_always_on = true

cidr_subnet_reporting_functions = ["10.1.177.0/24"]
cidr_subnet_gpd                 = ["10.1.138.0/24"]

reporting_function = true
reporting_functions_app_sku = {
  kind     = "Linux"
  sku_tier = "PremiumV3"
  sku_size = "P1v3"
}

cname_record_name = "config"

# APIM
apim_logger_resource_id = "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim/loggers/pagopa-p-apim-logger"

# gpd database config for gpd-app-service
pgbouncer_enabled = true

# WISP-dismantling-cfg
create_wisp_converter = false

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
