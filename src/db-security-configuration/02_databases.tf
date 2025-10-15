

resource "restapi_object" "database" {
  for_each = var.databases

  path = "/api/database/"

  #"{ \"id\": \"55555\", \"first\": \"Foo\", \"last\": \"Bar\" }"
  data = jsonencode(merge(
    {
      name = each.key
      is_on_demand = false
      cache_ttl = 1 # FIXME?
      engine = local.database_properties[each.value.type].engine
      details = jsonencode({
        ssl-use-client-auth = false
        ssl = true
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

      }) #todo alcuni statici da mergiare con locals, altri dinamici - controllare quali valori servono per mongo e redis
      is_full_sync = local.database_properties[each.value.type].full_sync
      connection_source = "admin"
      auto_run_queries = false
    },
    local.database_properties[each.value.type]
  ))


  destroy_path = "/api/database/" #FIXME mettere l'id, se serve usando idattribute
  id_attribute = "" #TODO
}


