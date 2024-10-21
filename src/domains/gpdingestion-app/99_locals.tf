locals {
  product       = "${var.prefix}-${var.env_short}"
  project_short = "${var.prefix}-${var.env_short}-${var.domain}"
  project       = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

  location_short_weu = "weu"
  project_short_weu  = "${var.prefix}-${var.env_short}-${local.location_short_weu}"

  project_core_itn = "${var.prefix}-${var.env_short}-${var.location_short}-core"


  monitor_action_group_slack_name    = "SlackPagoPA"
  monitor_action_group_email_name    = "PagoPA"
  monitor_action_group_opsgenie_name = "Opsgenie"
  monitor_appinsights_name           = "${local.product}-appinsights"
  monitor_appinsights_italy_name     = "${local.project_core_itn}-appinsights"

  vnet_name                = "${var.prefix}-${var.env_short}-${var.location_short}-vnet"
  vnet_resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-vnet-rg"

  aks_name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"

  ingress_hostname                      = "${var.domain}.itn"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  pagopa_apim_snet        = "${local.product}-apim-snet"
  pagopa_vnet_integration = "pagopa-${var.env_short}-vnet-integration"
  pagopa_vnet_rg          = "pagopa-${var.env_short}-vnet-rg"

  domain_hostname = "${var.dns_zone_prefix}.${local.internal_dns_zone_name}"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"

  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  hostname      = var.env == "prod" ? "${var.domain}.itn.internal.platform.pagopa.it" : "${var.domain}.itn.internal.${var.env}.platform.pagopa.it"


  evt_hub_location = "${local.location_short_weu}-core"

}
