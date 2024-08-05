prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "ecommerce"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/ecommerce-app"
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

# PSP for xpay
# - CIPBITMM  (NEXI)
ecommerce_xpay_psps_list = "CIPBITMM"
# PSP for vpos
# - BNLIITRR (WORLDLINE)
# - BCITITMM (INTESA)
# - UNCRITMM (UNICREDIT)
# - BPPIITRRXXX (POSTE)
# - PPAYITR1XXX (POSTEPAY)
# - BIC36019 (AMEX)
ecommerce_vpos_psps_list = "BNLIITRR,BCITITMM,UNCRITMM,BPPIITRRXXX,PPAYITR1XXX,BIC36019"

dns_zone_checkout = "checkout"

pod_disruption_budgets = {
  "pagopaecommerceeventdispatcherservice" = {
    minAvailable = 3
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaecommerceeventdispatcherservice"
    }
  },
  "pagopaecommercehelpdeskservice" = {
    minAvailable = 3
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaecommercehelpdeskservice"
    }
  },
  "pagopaecommercepaymentmethodsservice" = {
    minAvailable = 3
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaecommercepaymentmethodsservice"
    }
  },
  "pagopaecommercepaymentrequestsservice" = {
    minAvailable = 3
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaecommercepaymentrequestsservice"
    }
  },
  "pagopaecommercetransactionsservice" = {
    minAvailable = 3
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaecommercetransactionsservice"
    }
  },
  "pagopanotificationsservice" = {
    minAvailable = 3
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopanotificationsservice"
    }
  },
}

io_backend_base_path         = "https://disabled"
ecommerce_io_with_pm_enabled = false
pdv_api_base_path            = "https://api.tokenizer.pdv.pagopa.it/tokenizer/v1"

enabled_payment_wallet_method_ids_pm = "6920b555-c972-4e2b-980c-b0e0037a111a,0ff153c2-4c5e-49a5-8720-788b6f190264,b63dbc2b-0b89-4431-a196-a5d73ff7ce9c"

pagopa_vpn = {
  ips = [
    "0.0.0.0",
    "0.0.0.0",
  ]
}

pagopa_vpn_dr = {
  ips = [
    "93.63.219.230", # PagoPA on prem VPN
    "93.63.219.234", # PagoPA on prem VPN DR
  ]
}