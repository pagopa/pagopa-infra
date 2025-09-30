locals {
  prefix  = "pagopa"
  product = "${local.prefix}-${var.env_short}"
  domain  = "network"
  project = "${local.product}-${var.location_short}-${local.domain}"

  vnet_italy_name                = "${local.product}-itn-vnet"
  vnet_italy_resource_group_name = "${local.product}-itn-vnet-rg"
  vnet_core_resource_group_name  = "${local.product}-vnet-rg"
  vnet_core_name                 = "${local.product}-vnet"



  log_analytics_italy_workspace_name                = "${local.product}-itn-core-law"
  log_analytics_italy_workspace_resource_group_name = "${local.product}-itn-core-monitor-rg"

  log_analytics_weu_workspace_name                = "${local.product}-law"
  log_analytics_weu_workspace_resource_group_name = "${local.product}-monitor-rg"

  network_watcher_rg_name = "NetworkWatcherRG"

  flow_log_retention_days = 20


  nsg_network_regions = {
    westeurope = {
      short_name = "weu"
      vnets = [
        {
          name    = local.vnet_core_name
          rg_name = local.vnet_core_resource_group_name
        },
        {
          name    = local.vnet_italy_name
          rg_name = local.vnet_italy_resource_group_name
        }
      ]
      log_analytics_workspace_name = local.log_analytics_weu_workspace_name
      log_analytics_workspace_rg   = local.log_analytics_weu_workspace_resource_group_name
      nsg                          = local.westeurope_nsg
    }
    italynorth = {
      short_name = "itn"
      vnets = [
        {
          name    = local.vnet_italy_name
          rg_name = local.vnet_italy_resource_group_name
        },
        {
          name    = local.vnet_core_name
          rg_name = local.vnet_core_resource_group_name
        }
      ]
      log_analytics_workspace_name = local.log_analytics_italy_workspace_name
      log_analytics_workspace_rg   = local.log_analytics_italy_workspace_resource_group_name
      nsg                          = local.italynorth_nsg
    }
  }

database_adf_proxy_mapping = [
  {
    fqdn = "crusc8-db.${var.env_short}.internal.postgresql.pagopa.it"
    external_port = 5432
    destination_port = 5432
  },
  {
    fqdn = "gpd-db.${var.env_short}.internal.postgresql.pagopa.it"
    external_port = 5433
    destination_port = 5432
  },
  {
    fqdn = "nodo-db.${var.env_short}.internal.postgresql.pagopa.it"
    external_port = 5434
    destination_port = 5432
  },
  {
    fqdn = "fdr-db.${var.env_short}.internal.postgresql.pagopa.it"
    external_port = 5435
    destination_port = 5432
  }
  ,
  {
    fqdn = "nodo-storico-db.${var.env_short}.internal.postgresql.pagopa.it"
    external_port = 5436
    destination_port = 5432
  }
]

  dashboard_fqdn_port_map = flatten([
    for db in local.database_adf_proxy_mapping : {
      db_map           = "${db.fqdn};${db.external_port};${db.destination_port}"
    }
  ])

  dashboard_fqdn_map = flatten([
    for db in local.database_adf_proxy_mapping : {
      db_fqdn           = "${db.fqdn}"
    }
  ])

  base64_db_script = templatefile("${path.module}/network_proxy_forward.sh.tpl", {
    env = var.env_short
    db_map = join(",", local.dashboard_fqdn_port_map[*].db_map)}
  )

  base64_ipfwd_script = file("${path.module}/create_ip_fwd.sh")

  base64_script_merge = "${local.base64_ipfwd_script}${local.base64_db_script}"
  base64_script       = base64encode(local.base64_script_merge)
}
