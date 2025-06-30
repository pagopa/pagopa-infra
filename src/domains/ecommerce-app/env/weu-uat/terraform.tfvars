prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "ecommerce"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"


### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"
apim_dns_zone_prefix     = "uat.platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

ecommerce_xpay_psps_list = "CIPBITMM"
ecommerce_vpos_psps_list = "BNLIITRR,BCITITMM,UNCRITMM,BPPIITRRXXX,PPAYITR1XXX,BIC36019"

dns_zone_checkout = "uat.checkout"

io_backend_base_path         = "https://api-app.io.pagopa.it"
ecommerce_io_with_pm_enabled = false
pdv_api_base_path            = "https://api.uat.tokenizer.pdv.pagopa.it/tokenizer/v1"

enabled_payment_wallet_method_ids_pm = "f25399bf-c56f-4bd2-adc9-7aef87410609,0d1450f4-b993-4f89-af5a-1770a45f5d71,5bdc0d63-a5b8-4221-bbb1-3e8b45a1b40f"

pagopa_vpn = {
  ips = [
    "0.0.0.0",
    "0.0.0.0",
  ]
}

pagopa_vpn_dr = {
  ips = [
    "0.0.0.0",
    "0.0.0.0",
  ]
}

ecommerce_transactions_service_api_key_use_primary = true
ecommerce_notification_service_api_key_use_primary = true
ecommerce_user_stats_service_api_key_use_primary   = true
ecommerce_payment_requests_api_key_use_primary     = true