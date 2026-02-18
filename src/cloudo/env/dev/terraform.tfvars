prefix             = "pagopa"
env_short          = "d"
env                = "dev"
domain             = "core"
location           = "westeurope"
location_short     = "weu"
location_string    = "West Europe"
location_ita       = "italynorth"
location_short_ita = "itn"
instance           = "dev"

cloudo_function_tier = "basic_private"
cloudo_ui_tier       = "basic"

### External resources

monitor_resource_group_name              = "pagopa-d-monitor-rg"
application_insisght_name                = "pagopa-d-appinsights"
application_insisght_resource_group_name = "pagopa-d-monitor-rg"

# ClouDO orchestrator parameters
cloudo_orchestrator = {
  image_name        = "pagopa/cloudo-orchestrator"
  image_tag         = "0.0.0"
  registry_url      = "https://ghcr.io"
  registry_username = "payments-cloud-bot"
}

# ClouDO UI parameters
cloudo_ui = {
  image_name        = "pagopa/cloudo-ui"
  image_tag         = "0.0.0"
  registry_url      = "https://ghcr.io"
  registry_username = "payments-cloud-bot"
}

# ClouDO worker parameters
cloudo_worker = {
  image_name        = "pagopa/cloudo-worker"
  image_tag         = "0.0.0"
  registry_url      = "https://ghcr.io"
  registry_username = "payments-cloud-bot"
}