locals {
  project         = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  project_itn     = "${var.prefix}-${var.env_short}-${var.location_short_itn}-${var.domain}"
  project_legacy  = "${var.prefix}-${var.env_short}"
  product         = "${var.prefix}-${var.env_short}"
  product_network = "${var.prefix}-${var.env_short}-${var.location_short}-network"

  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"
  pagopa_apim_snet = "${local.product}-apim-snet"

  vnet_name                = "${local.product}-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"

  storage_blob_dns_zone_name       = "privatelink.blob.core.windows.net"
  storage_blob_resource_group_name = "${local.product}-vnet-rg"

  msg_resource_group_name      = "${local.product}-msg-rg"
  eventhub_resource_group_name = "${local.project_itn}-evh-rg"

  vnet_italy_name                = "${local.product}-itn-vnet"
  vnet_italy_resource_group_name = "${local.product}-itn-vnet-rg"

  linked_service_cruscotto_kv_name = "crusc8-${var.env_short}-key-vault"
  linked_service_nodo_kv_name      = "nodo-${var.env_short}-key-vault"

  kv_name_password_database        = "ls-cruscotto-password"
  kv_name_password_config_database = "db-cfg-password"

  df_integration_runtime_name = "AutoResolveIntegrationRuntime"
  crusc8_tables_list_datasets = [
    {
      dataset_name        = "CRUSC8_RECORDED_TIMEOUT"
      dataset_schema_file = "datafactory/datasets/crusc8/CRUSC8_RECORDED_TIMEOUT.json"
      table_name          = "pagopa_recorded_timeout"
      schema_name         = "cruscotto"
    },
    {
      dataset_name        = "CRUSC8_PAYMENT_RECEIPT"
      dataset_schema_file = "datafactory/datasets/crusc8/CRUSC8_PAYMENT_RECEIPT.json"
      table_name          = "pagopa_payment_receipt"
      schema_name         = "cruscotto"
    },
    {
      dataset_name        = "CRUSC8_TAXONOMY_AGGREGATE_POSITION"
      dataset_schema_file = "datafactory/datasets/crusc8/CRUSC8_TAXONOMY_AGGREGATE_POSITION.json"
      table_name          = "pagopa_taxonomy_aggregate_position"
      schema_name         = "cruscotto"
    }
  ]
}
