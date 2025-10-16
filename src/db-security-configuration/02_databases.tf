

resource "restapi_object" "databases" {
  for_each = var.databases

  path = "/api/database/"

  data = jsonencode(merge(
    {
      name = each.key
      is_on_demand = false
      engine = local.database_properties[each.value.type].driver
      details = {
        ssl-use-client-auth = false
        ssl = local.database_properties[each.value.type].ssl
        password = each.value.password_required ? data.azurerm_key_vault_secret.database_password[each.key].value : null
        destination-database = false
        port = each.value.port
        advanced-options = false
        schema-filter-type = "all"
        dbname = each.value.schema_name
        host = each.value.host
        tunnel-enabled = false
        user = each.value.username
        ssl-mode = "require"
        catalog = lookup(each.value, "catalog", null)
      }

      is_full_sync = local.database_properties[each.value.type].full_sync
      connection_source = "admin"
      auto_run_queries = false
    },
    local.database_properties[each.value.type]
  ))



  # destroy_path = "/api/database/" #FIXME mettere l'id, se serve usando idattribute
  # id_attribute = "" #TODO
}


