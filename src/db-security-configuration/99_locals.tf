locals {
  product = "${var.prefix}-${var.env_short}"
  domain  = "dbsecconf"
  project = "${local.product}-${var.location_short}-${local.domain}"

  key_vault_itn_core_name    = "${local.product}-itn-core-kv"
  key_vault_itn_core_rg_name = "${local.product}-itn-core-sec-rg"

  metabase_uri = "https://pagopa-${var.env_short}-itn-dbsecurity-metabase-webapp.azurewebsites.net"


  database_properties = {
    postgres = {
      driver = "postgres"
      full_sync = true
    }
    mongodb = {
      driver = "trino"
      full_sync = true
    }
    redis = {
      driver = "trino"
      full_sync = true
    }
  }
}
