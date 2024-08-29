prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "nodo"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/nodo-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}


nodo_switcher = {
  pagopa_nodo_url                  = "https://httpbin.org/status/200"
  trigger_max_age_minutes          = 1
  enable_switch_approval           = true
  force_execution_for_old_triggers = false
  apim_variables = [
    {
      name  = "default-nodo-backend"
      value = "http://10.70.74.200/nodo-uat"
    }
  ]
}

