locals {
  product             = "${var.prefix}-${var.env_short}"
  product_region      = "${var.prefix}-${var.env_short}-${var.location_short}"
  product_ita         = "${var.prefix}-${var.env_short}-${var.location_short_ita}"
  project             = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  project_ita         = "${var.prefix}-${var.env_short}-${var.location_short_ita}-${var.domain}"
  geo_replica_project = "${var.prefix}-${var.env_short}-${var.geo_replica_location_short}-${var.domain}-replica"

  monitor_appinsights_name        = "${local.product}-appinsights"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  ingress_hostname_prefix               = "${var.instance}.${var.domain}"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"

  data_resource_group_name = "${local.product}-data-rg"

  vnet_integration_name                = "${local.product}-vnet-integration"
  vnet_integration_resource_group_name = "${local.product}-vnet-rg"

  dns_forwarder_backup_name = "${local.product}-dns-forwarder-backup-vmss"

  soap_basepath_nodo_postgres_pagopa = "nodo"

  integration_appgateway_private_ip = ["10.230.10.200"]

  msg_resource_group_name = "${local.product}-msg-rg"

}
