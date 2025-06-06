prefix                 = "pagopa"
env_short              = "p"
env                    = "prod"
domain                 = "afm"
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
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

pod_disruption_budgets = {
  "pagopaafmutils" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaafmutils"
    }
  },
  "pagopaafmmarketplacebe" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaafmmarketplacebe"
    }
  },
  "pagopaafmcalculator" = {
    minAvailable = 5
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaafmcalculator"
    }
  },
}
