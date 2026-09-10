resource "random_password" "superset_random_key" {
  length  = 42
  special = false
}

resource "random_password" "superset_admin_user_psw" {
  length  = 42
  special = false
}

resource "random_password" "db_user_superset_psw" {
  length           = 42
  special          = true
  override_special = "!-_"
}

# DATABASE
resource "azurerm_postgresql_flexible_server_database" "superset" {
  name      = "superset"
  server_id = data.azurerm_postgresql_flexible_server.qa_postgresql.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

resource "postgresql_grant" "superset_user_grant" {
  database    = "superset"
  role        = postgresql_role.superset_user.name
  object_type = "schema"
  schema      = "public"
  privileges  = ["CREATE", "USAGE"]

  depends_on = [
    azurerm_postgresql_flexible_server_database.superset
  ]
}

# GRANT SUPERSET USER ON DATABASE SUPERSET
resource "postgresql_grant" "superset_user_grant_on_db" {
  database    = "superset"
  role        = postgresql_role.superset_user.name
  object_type = "database"
  privileges  = ["CREATE"]

  depends_on = [
    azurerm_postgresql_flexible_server_database.superset
  ]
}

# Permessi sulle tabelle esistenti nello schema public
resource "postgresql_grant" "superset_user_grant_on_tables" {
  database    = "superset"
  schema      = "public"
  role        = postgresql_role.superset_user.name
  object_type = "table"
  privileges  = ["SELECT", "INSERT", "UPDATE", "DELETE", "REFERENCES"]

  depends_on = [
    azurerm_postgresql_flexible_server_database.superset
  ]
}

# USER - Superset
resource "postgresql_role" "superset_user" {
  name     = "superset"
  login    = true
  password = random_password.db_user_superset_psw.result
}

resource "kubernetes_secret" "superset" {
  metadata {
    name      = "pagopa-superset-secret"
    namespace = kubernetes_namespace.namespace.metadata[0].name
    labels = {
      "app.kubernetes.io/name"       = "qa"
      "app.kubernetes.io/component"  = "superset"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  data = {
    SUPERSET_ADMIN_USER = "admin"
    SUPERSET_ADMIN_PSW  = random_password.superset_admin_user_psw.result
    SUPERSET_SECRET_KEY = random_password.superset_random_key.result
    DB_HOST             = data.azurerm_postgresql_flexible_server.qa_postgresql.fqdn
    DB_PORT             = "5432"
    DB_NAME             = "superset"
    DB_USER             = postgresql_role.superset_user.name
    DB_PASS             = postgresql_role.superset_user.password
    REDIS_CELERY_DB     = 0
    REDIS_DB            = 0
    REDIS_HOST          = data.azurerm_managed_redis.qa_redis.hostname
    REDIS_PORT          = "10000"
    REDIS_PROTO         = "rediss"
    REDIS_SSL_CERT_REQS = "none"
    REDIS_USER          = ""
    REDIS_PASSWORD      = data.azurerm_managed_redis.qa_redis.default_database[0].primary_access_key
  }

  type = "Opaque"
}