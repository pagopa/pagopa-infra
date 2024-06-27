module "eventhub_printit" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//eventhub_configuration?ref=v8.22.0"
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
      ]
      keys = [
        {
          name   = "${local.project}-notice-evt-rx"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
    {
      name              = "${var.prefix}-${var.domain}-complete-evh"
      partitions        = 1
      message_retention = 1
      consumers = [
        "${local.project}-notice-evt-complete-rx",
      ]
      keys = [
        {
          name   = "${local.project}-notice-evt-complete-rx"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
    {
      name              = "${var.prefix}-${var.domain}-errors-evh"
      partitions        = 1
      message_retention = 1
      consumers = [
        "${local.project}-notice-evt-errors-rx",
      ]
      keys = [
        {
          name   = "${local.project}-notice-evt-errors-rx"
          listen = true
          send   = true
          manage = false
        }
      ]
    },
  ]
}

