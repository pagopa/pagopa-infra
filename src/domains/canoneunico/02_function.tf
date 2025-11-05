## Function canone unico
module "canoneunico_function" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v6.15.2"

  resource_group_name                      = azurerm_resource_group.canoneunico_rg.name
  name                                     = "${local.project}-fn-canoneunico"
  location                                 = var.location
  health_check_path                        = "/api/info"
  subnet_id                                = module.canoneunico_function_snet.id
  runtime_version                          = var.canoneunico_runtime_version
  always_on                                = var.canoneunico_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  app_service_plan_id                      = azurerm_app_service_plan.canoneunico_service_plan.id

  docker = {
    image_name        = var.image_name
    image_tag         = "latest"
    registry_password = data.azurerm_container_registry.login_server.admin_password
    registry_url      = "https://${data.azurerm_container_registry.login_server.login_server}"
    registry_username = data.azurerm_container_registry.login_server.admin_username
  }

  storage_account_info = var.function_storage_account_info

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "java"

    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    # custom configuration
    CU_SA_CONNECTION_STRING    = module.canoneunico_sa.primary_connection_string
    DEBT_POSITIONS_TABLE       = azurerm_storage_table.cu_debtposition_table.name
    ORGANIZATIONS_CONFIG_TABLE = azurerm_storage_table.cu_ecconfig_table.name
    IUVS_TABLE                 = azurerm_storage_table.cu_iuvs_table.name
    DEBT_POSITIONS_QUEUE       = azurerm_storage_queue.cu_debtposition_queue.name
    CU_BLOB_EVENTS_QUEUE       = azurerm_storage_queue.cu_blob_event_queue.name
    # INPUT_CSV_BLOB             = azurerm_storage_container.in_csv_blob_container.name
    # OUTPUT_CSV_BLOB            = azurerm_storage_container.out_csv_blob_container.name
    # ERROR_CSV_BLOB             = azurerm_storage_container.err_csv_blob_container.name
    GPD_HOST             = "https://api.${var.dns_zone_prefix}.${var.external_domain}/gpd/api/v1"
    NCRON_SCHEDULE_BATCH = var.canoneunico_schedule_batch
    IUV_GENERATION_TYPE  = "seq"
    CU_SEGREGATION_CODE  = "47"
    CU_AUX_DIGIT         = "3"
    MAX_ATTEMPTS         = 3
    QUEUE_TIME_TO_LIVE   = 7200                                // 2h
    QUEUE_DELAY          = var.canoneunico_queue_message_delay // 2m
    CUP_YEAR             = "2024"
    PO_DUE_DATE          = "2025-04-30T23:59:59.999Z"

    BATCH_SIZE_DEBT_POS_QUEUE = var.canoneunico_batch_size_debt_pos_queue
    BATCH_SIZE_DEBT_POS_TABLE = var.canoneunico_batch_size_debt_pos_table

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true
  }

  allowed_subnets = [data.azurerm_subnet.apim_snet.id]

  allowed_ips = []

  tags = module.tag_config.tags

  depends_on = [
    azurerm_app_service_plan.canoneunico_service_plan
  ]
}

# autoscaling
resource "azurerm_monitor_autoscale_setting" "canoneunico_function" {
  name                = "${module.canoneunico_function.name}-autoscale"
  resource_group_name = azurerm_resource_group.canoneunico_rg.name
  location            = var.location
  target_resource_id  = azurerm_app_service_plan.canoneunico_service_plan.id

  profile {
    name = "default"

    capacity {
      default = var.canoneunico_function_autoscale_default
      minimum = var.canoneunico_function_autoscale_minimum
      maximum = var.canoneunico_function_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name        = "ApproximateMessageCount"
        metric_resource_id = join("/", ["${module.canoneunico_sa.id}", "services/queue/queues", "${azurerm_storage_queue.cu_debtposition_queue.name}"])
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT1M"
        time_aggregation   = "Average"
        operator           = "GreaterThanOrEqual"
        threshold          = 10
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }

    }

    rule {
      metric_trigger {
        metric_name        = "ApproximateMessageCount"
        metric_resource_id = join("/", ["${module.canoneunico_sa.id}", "services/queue/queues", "${azurerm_storage_queue.cu_debtposition_queue.name}"])
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT1M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 10
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }


    }

  }
}

##Alert
resource "azurerm_monitor_scheduled_query_rules_alert" "canoneunico_gpd_error" {
  count = var.env_short == "p" ? 1 : 0

  name                = "${module.canoneunico_function.name}-gpd-problem-alert"
  resource_group_name = azurerm_resource_group.canoneunico_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[CU] GPD Error"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "CU Problem with GPD"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "CuCreateDebtPositionFunction"
    | where message contains "Update entity with ERROR status"
  QUERY
    , module.canoneunico_function.name
  )
  severity    = 2
  frequency   = 30
  time_window = 30
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}


resource "azurerm_monitor_scheduled_query_rules_alert" "canoneunico_parsing_csv_error" {
  count = var.env_short == "p" ? 1 : 0

  name                = "${module.canoneunico_function.name}-cu-csv-parsing-alert"
  resource_group_name = azurerm_resource_group.canoneunico_rg.name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[CU] CSV Parsing Error"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "CU CSV parsing problem"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "[CuCsvParsingFunction Error] Validation Error"
  QUERY
    , module.canoneunico_function.name
  )
  severity    = 2
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}
