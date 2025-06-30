prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "ecommerce"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"


### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
apim_dns_zone_prefix     = "dev.platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

ecommerce_xpay_psps_list = "XPAY,IDPSPFNZ,60000000001"
ecommerce_vpos_psps_list = "PSPtest1,CHARITY_AMEX,CHARITY_IDPSPFNZ,CHARITY_ISP,40000000001,DINERS,MARIOGAM,73473473473,PAYTITM1,POSTE1,ProvaCDI,50000000001,70000000001,10000000001,idPsp2,irraggiungibile_wisp,prova_ila_1,pspStress50,pspStress79,pspStress80,pspStress81"

dns_zone_checkout = "dev.checkout"

io_backend_base_path         = "http://{{aks-lb-nexi}}/pmmockservice/pmmockserviceapi"
ecommerce_io_with_pm_enabled = false
pdv_api_base_path            = "https://api.uat.tokenizer.pdv.pagopa.it/tokenizer/v1"

enabled_payment_wallet_method_ids_pm = "9d735400-9450-4f7e-9431-8c1e7fa2a339,148ff003-46a6-4790-9376-b0e057352e45,ab2c39be-91ad-4c87-944a-a08f30e92cad"

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

ecommerce_payment_requests_api_key_use_primary     = true
ecommerce_helpdesk_service_api_key_use_primary     = true
ecommerce_notification_service_api_key_use_primary = true
ecommerce_user_stats_service_api_key_use_primary   = true
