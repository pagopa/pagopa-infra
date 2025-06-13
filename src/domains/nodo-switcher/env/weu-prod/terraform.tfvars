prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "nodo"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"



nodo_switcher = {
  pagopa_nodo_url                  = "https://httpbin.org/status/200"
  trigger_max_age_minutes          = 1
  enable_switch_approval           = true
  force_execution_for_old_triggers = false
  apim_variables = [
    {
      name  = "default-nodo-backend"
      value = "https://10.79.20.34"
    }
  ]
}
