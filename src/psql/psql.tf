
provider "postgresql" {
  host             = azurerm_postgresql_server.this.fqdn
  port             = 5432
  username         = "${var.db_username}@mock-db"
  password         = var.db_password
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
  name              = var.db_name
  owner             = azurerm_postgresql_server.this.administrator_login
  template          = var.db_template
  lc_collate        = var.db_collate
  connection_limit  = var.db_connection_limit
  allow_connections = var.db_allow_connections
}

/**
* USER
*/
resource "postgresql_role" "this" {
  name     = var.db_username
  login    = true
  password = var.db_password
}

/*
* Schema
*/
resource "postgresql_schema" "this" {
  name  = var.db_schema
  owner = postgresql_role.this.name
}

/*
* GRANT
*/
resource "postgresql_grant" "revoke_public" {
  database    = var.db_name
  role        = var.db_username
  schema      = var.db_schema
  object_type = "schema"
  privileges  = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES", "TRIGGER", "CREATE", "CONNECT", "TEMPORARY", "EXECUTE", "USAGE"]
}
