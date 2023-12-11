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
ecommerce_npg_psps_list  = ""

dns_zone_checkout = "checkout"

pod_disruption_budgets = {
  "pagopaecommerceeventdispatcherservice" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaecommerceeventdispatcherservice"
    }
  },
  "pagopaecommercehelpdeskservice" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaecommercehelpdeskservice"
    }
  },
  "pagopaecommercepaymentmethodsservice" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaecommercepaymentmethodsservice"
    }
  },
  "pagopaecommercepaymentrequestsservice" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaecommercepaymentrequestsservice"
    }
  },
  "pagopaecommercetransactionsservice" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopaecommercetransactionsservice"
    }
  },
  "pagopanotificationsservice" = {
    minAvailable = 1
    matchLabels = {
      "app.kubernetes.io/instance" = "pagopanotificationsservice"
    }
  },
}

io_backend_base_path         = "https://disabled"
ecommerce_io_with_pm_enabled = false
pdv_api_base_path            = "https://disabled"
