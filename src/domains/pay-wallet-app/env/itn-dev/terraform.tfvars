prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "pay-wallet"
location        = "italynorth"
location_short  = "itn"
location_string = "Italy North"
instance        = "dev"


### External resources

monitor_italy_resource_group_name                 = "pagopa-d-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-d-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-d-itn-core-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
dns_zone_prefix          = "dev.payment-wallet"
apim_dns_zone_prefix     = "dev.platform"

# checkout
dns_zone_checkout = "dev.checkout"

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
io_backend_base_path = "http://{{aks-lb-nexi}}/pmmockservice/pmmockserviceapi"

enabled_payment_wallet_method_ids_pm      = "9d735400-9450-4f7e-9431-8c1e7fa2a339,148ff003-46a6-4790-9376-b0e057352e45,ab2c39be-91ad-4c87-944a-a08f30e92cad"
pay_wallet_jwt_issuer_api_key_use_primary = true

payment_wallet_service_api_key_use_primary = true
