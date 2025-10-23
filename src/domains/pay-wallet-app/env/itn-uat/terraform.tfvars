prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "pay-wallet"
location        = "italynorth"
location_short  = "itn"
location_string = "Italy North"
instance        = "uat"


### External resources

monitor_italy_resource_group_name                 = "pagopa-u-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-u-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-u-itn-core-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"
dns_zone_prefix          = "uat.payment-wallet"
apim_dns_zone_prefix     = "uat.platform"

### Aks

ingress_load_balancer_ip = "10.3.2.250"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

pdv_api_base_path    = "https://api.uat.tokenizer.pdv.pagopa.it/tokenizer/v1"
io_backend_base_path = "https://api-app.io.pagopa.it"

payment_wallet_migrations_enabled         = false
enabled_payment_wallet_method_ids_pm      = "f25399bf-c56f-4bd2-adc9-7aef87410609,0d1450f4-b993-4f89-af5a-1770a45f5d71,5bdc0d63-a5b8-4221-bbb1-3e8b45a1b40f"
pay_wallet_jwt_issuer_api_key_use_primary = true

payment_wallet_service_api_key_use_primary = true
