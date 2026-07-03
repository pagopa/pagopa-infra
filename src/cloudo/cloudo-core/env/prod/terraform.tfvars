prefix               = "pagopa"
env_short            = "p"
env                  = "prod"
location_short_ita   = "itn"
location_short       = "weu"
cloudo_function_tier = "basic"
cloudo_ui_tier       = "basic"

### External resources
application_insisght_name                = "pagopa-p-appinsights"
application_insisght_resource_group_name = "pagopa-p-monitor-rg"

# ClouDO orchestrator parameters
cloudo_orchestrator = {
  image_name        = "pagopa/cloudo-orchestrator"
  image_tag         = "0.24.4"
  registry_url      = "https://ghcr.io"
  registry_username = "payments-cloud-bot"
}

# ClouDO UI parameters
cloudo_ui = {
  image_name        = "pagopa/cloudo-ui"
  image_tag         = "0.15.0"
  registry_url      = "https://ghcr.io"
  registry_username = "payments-cloud-bot"
}

# ClouDO worker parameters
cloudo_worker = {
  image_name        = "pagopa/cloudo-worker"
  image_tag         = "0.19.0"
  registry_url      = "https://ghcr.io"
  registry_username = "payments-cloud-bot"
}
