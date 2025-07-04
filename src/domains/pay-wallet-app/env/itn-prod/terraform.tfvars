prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "pay-wallet"
location        = "italynorth"
location_short  = "itn"
location_string = "Italy North"
instance        = "prod"


### External resources

monitor_italy_resource_group_name                 = "pagopa-p-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-p-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-p-itn-core-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
dns_zone_prefix          = "payment-wallet"
apim_dns_zone_prefix     = "platform"

### Aks

ingress_load_balancer_ip = "10.3.2.250"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

pdv_api_base_path    = "https://api.tokenizer.pdv.pagopa.it/tokenizer/v1"
io_backend_base_path = "https://api-app.io.pagopa.it"

payment_wallet_with_pm_enabled = true

payment_wallet_migrations_enabled    = true
enabled_payment_wallet_method_ids_pm = "6920b555-c972-4e2b-980c-b0e0037a111a,0ff153c2-4c5e-49a5-8720-788b6f190264,b63dbc2b-0b89-4431-a196-a5d73ff7ce9c"

### PDB

pod_disruption_budgets = {
  "pagopapaymentwalleteventdispatcherservice" = {
    minAvailable = 2
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopapaymentwalleteventdispatcherservice"
    }
  },
  "pagopawalletservice" = {
    minAvailable = 4
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopawalletservice"
    }
  },
  "pagopapaymentwalletcdcservice" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopapaymentwalletcdcservice"
    }
  },
}
pay_wallet_jwt_issuer_api_key_use_primary = true

payment_wallet_service_api_key_use_primary = true
