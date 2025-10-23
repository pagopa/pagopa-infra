locals {
  product = "${var.prefix}-${var.env_short}"
  domain  = "dbsecconf"

  key_vault_itn_core_name    = "${local.product}-itn-core-kv"
  key_vault_itn_core_rg_name = "${local.product}-itn-core-sec-rg"

  metabase_uri = "https://pagopa-${var.env_short}-itn-dbsecurity-metabase-webapp.azurewebsites.net"


  database_properties = {
    postgresql = {
      driver    = "postgres"
      full_sync = true
      ssl       = true
    }
    nexi = {
      driver    = "starburst"
      full_sync = false
      ssl       = false
    }
    mongodb = {
      driver    = "starburst"
      full_sync = false
      ssl       = false
    }
    redis = {
      driver    = "starburst"
      full_sync = false
      ssl       = true
    }
  }
}
