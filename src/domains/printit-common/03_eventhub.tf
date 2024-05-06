module "eventhub_printit" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub_configuration?ref=v8.9.1"
  count  = var.is_feature_enabled.eventhub ? 1 : 0

  event_hub_namespace_name                = "${var.prefix}-${var.env_short}-${var.location_short}-core-evh-meucci"
  event_hub_namespace_resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-evenhub-rg"

  eventhubs = [
    {
      name              = "${var.prefix}-${var.domain}-evh"
      partitions        = 1
      message_retention = 1
      consumers = [
        "${local.project}-notice-evt-rx",
        "${local.project}-notice-complete-evt-tx",
        "${local.project}-notice-error-evt-tx"
      ]
      keys = [
        {
          name   = "${local.project}-notice-evt-rx"
          listen = false
          send   = true
          manage = false
        },
        {
          name   = "${local.project}-notice-complete-evt-tx"
          listen = true
          send   = false
          manage = false
        },
        {
          name   = "${local.project}-notice-error-evt-tx"
          listen = true
          send   = false
          manage = false
        },
      ]
    },
  ]
}

