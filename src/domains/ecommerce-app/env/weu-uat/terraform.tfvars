prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "ecommerce"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/ecommerce-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

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
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}

ecommerce_xpay_psps_list = "CHARITY_NEXI,CIPBITMM"
ecommerce_vpos_psps_list = "ATPIITM1,ABI36080,NIPSITR1,BIC36019,CHARITY_AMEX,CRGEITGG,BCEPITMM,BMLUIT3L,ABI03048,ABI03211,POCAIT3C,BPBAIT3B,SELBIT2B,ABI03268,ABI08899,ABI08327,BPMOIT22,CRACIT33,ABI03266,ABI01030,PASCITMM,PASBITGG,SENVITT1,BPPNIT2PXXX,BPPUIT33,ABI05033,BEPOIT21,BAPPIT21,POSOIT22XXX,ABI02008,ABI08913,BCABIT21,SARDIT31,CRBIIT2B,CHARITY_MPS,CHARITY_UNCR,CASRIT22,CRFIIT2SXXX,CRPPIT2PXXX,MICSITM1,CIPYIT31,RSANIT3P,BPCVIT2S,ABI14156,ABI19164,ABI03110,ABI36925,ABI36772,IFSPIT21,ABI03395,ABI03069,BCITITMM,BIC32698,SIGPITM1XXX,MOETIT31,ABI36092,idPsp1,AGID_02,PAYTITM1,BPPIITRRXXX,PPAYITR1XXX,RZSBIT2B,LB000484,SEPFIT31XXX,PIRLITM1XXX,SATYLUL1,SATYGB21,ABI36052,ABI36068,UNPLIT22,BLOPIT22,UNCRITMM,BNLIITRR,ABI18164,ABI03667,UNGCIT21"
ecommerce_npg_psps_list  = ""

dns_zone_checkout = "uat.checkout"

io_backend_base_path         = "https://api.dev.platform.pagopa.it/pmmockserviceapi"
ecommerce_io_with_pm_enabled = false
pdv_api_base_path            = "https://api.uat.tokenizer.pdv.pagopa.it/tokenizer/v1"
