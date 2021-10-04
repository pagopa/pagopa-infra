data "azurerm_key_vault_secret" "db_mock_psp_user_login" {
  count        = var.mock_psp_enabled ? 1 : 0
  name         = "db-mock-psp-user-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "db_mock_psp_user_login_password" {
  count        = var.mock_psp_enabled ? 1 : 0
  name         = "db-mock-psp-user-login-password"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "db_administrator_login" {
  count        = var.prostgresql_enabled ? 1 : 0
  name         = "db-administrator-login"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "db_administrator_login_password" {
  count        = var.prostgresql_enabled ? 1 : 0
  name         = "db-administrator-login-password"
  key_vault_id = module.key_vault.id
}

provider "postgresql" {
  host             = "pagopa-d-postgresql.postgres.database.azure.com"
  port             = 5432
  username         = "${data.azurerm_key_vault_secret.db_administrator_login[0].value}@mock-db"
  password         = data.azurerm_key_vault_secret.db_administrator_password[0].value
  sslmode          = "require"
  expected_version = "10"
  superuser        = false
  connect_timeout  = 15
}

# fixme require cyrilgdn/postgresql
/*
* Database
*/
resource "postgresql_database" "this" {
  name              = var.postgresql_name
  owner             = azurerm_postgresql_server.this.administrator_login
  template          = "template0"
  lc_collate        = "C"
  connection_limit  = var.postgresql_connection_limit
  allow_connections = true
}

/**
* USER
*/
resource "postgresql_role" "this" {
  name     = data.azurerm_key_vault_secret.db_mock_psp_user_login[0].value
  login    = true
  password = data.azurerm_key_vault_secret.db_mock_psp_user_login_password[0].value
}

/*
* Schema
*/
resource "postgresql_schema" "this" {
  name  = var.postgresql_schema
  owner = postgresql_role.this.name
}

/*
* GRANT
*/
resource "postgresql_grant" "revoke_public" {
  database    = var.postgresql_name
  role        = var.prostgresql_db_username
  schema      = var.postgresql_schema
  object_type = "schema"
  privileges  = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER", "CREATE", "CONNECT", "TEMPORARY", "EXECUTE", "USAGE"]
}
