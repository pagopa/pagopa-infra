
locals {
  users_map = { for user in var.users : user.name => user }

  grants = { for grant in flatten([for user in var.users : [for grant in user.grants :
    {
      database : grant.database
      username : user.name
      schema : grant.schema
      object_type : grant.object_type
      privileges : grant.privileges
  }]]) : "${grant.username}_${grant.database}_${grant.schema != null ? format("%s_", grant.schema) : "_"}${grant.object_type}" => grant }


  key_vault_name           = format("%s-kv", local.project)
  key_vault_resource_group = format("%s-sec-rg", local.project)
  key_vault_id             = "${data.azurerm_subscription.current.id}/resourceGroups/${local.key_vault_resource_group}/providers/Microsoft.KeyVault/vaults/${local.key_vault_name}"

  psql_username = var.psql_username != null ? var.psql_username : data.azurerm_key_vault_secret.db_administrator_login[0].value
  psql_password = var.psql_password != null ? var.psql_password : data.azurerm_key_vault_secret.db_administrator_login_password[0].value
}


resource "postgresql_role" "user" {
  for_each = local.users_map

  name            = each.key
  login           = true
  superuser       = false
  create_database = false
  create_role     = false
  inherit         = true
  replication     = false
  password        = data.azurerm_key_vault_secret.user_password[each.key].value
}

data "azurerm_key_vault_secret" "user_password" {
  for_each = local.users_map

  name         = "db-${lower(replace(each.key, "_", "-"))}-password"
  key_vault_id = local.key_vault_id
}

resource "postgresql_grant" "user_privileges" {
  for_each = local.grants

  database    = each.value.database
  schema      = each.value.schema
  role        = postgresql_role.user[each.value.username].name
  object_type = each.value.object_type
  privileges  = each.value.privileges
}
