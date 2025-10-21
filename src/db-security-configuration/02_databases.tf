

resource "restapi_object" "databases" {
  for_each = var.databases

  path = "/api/database/"

  data = jsonencode(merge(
    {
      name         = each.key
      is_on_demand = false
      engine       = local.database_properties[each.value.type].driver
      details = {
        ssl-use-client-auth         = false
        ssl                         = local.database_properties[each.value.type].ssl
        password                    = each.value.password_required ? data.azurerm_key_vault_secret.database_password[each.key].value : null
        destination-database        = false
        port                        = each.value.port
        advanced-options            = false
        schema-filter-type          = lookup(each.value, "schema", null) != null ? null : "all"
        dbname                      = each.value.db_name
        host                        = each.value.host
        tunnel-enabled              = false
        user                        = each.value.username
        ssl-mode                    = "require"
        schema                      = lookup(each.value, "schema", null)
        catalog                     = lookup(each.value, "catalog", null)
        let-user-control-scheduling = true
        advanced-options            = true
      }

      is_full_sync      = local.database_properties[each.value.type].full_sync
      connection_source = "admin"
      auto_run_queries  = false
      schedules = {
        metadata_sync = {
          schedule_day    = null
          schedule_frame  = null
          schedule_hour   = 1
          schedule_minute = 0
          schedule_type   = "daily"
        }
      }
    },
    local.database_properties[each.value.type]
  ))
}


