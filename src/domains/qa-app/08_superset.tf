resource "random_password" "superset_random_key" {
  count = var.enabled_superset ? 1 : 0

  length  = 42
  special = false
}

resource "random_password" "superset_admin_user_psw" {
  count   = var.enabled_superset ? 1 : 0
  length  = 42
  special = false
}

resource "random_password" "db_user_superset_psw" {
  count            = var.enabled_superset ? 1 : 0
  length           = 42
  special          = true
  override_special = "!-_"
}

# DATABASE
resource "azurerm_postgresql_flexible_server_database" "superset" {
  count = var.enabled_superset ? 1 : 0

  name      = "superset"
  server_id = data.azurerm_postgresql_flexible_server.qa_postgresql.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

resource "postgresql_grant" "superset_user_grant" {
  count = var.enabled_superset ? 1 : 0

  database    = "superset"
  role        = postgresql_role.superset_user[0].name
  object_type = "schema"
  schema      = "public"
  privileges  = ["CREATE", "USAGE"]

  depends_on = [
    azurerm_postgresql_flexible_server_database.superset[0]
  ]
}

# GRANT SUPERSET USER ON DATABASE SUPERSET
resource "postgresql_grant" "superset_user_grant_on_db" {
  count = var.enabled_superset ? 1 : 0

  database    = "superset"
  role        = postgresql_role.superset_user[0].name
  object_type = "database"
  privileges  = ["CREATE"]

  depends_on = [
    azurerm_postgresql_flexible_server_database.superset[0]
  ]
}

# Permessi sulle tabelle esistenti nello schema public
resource "postgresql_grant" "superset_user_grant_on_tables" {
  count = var.enabled_superset ? 1 : 0

  database    = "superset"
  schema      = "public"
  role        = postgresql_role.superset_user[0].name
  object_type = "table"
  privileges  = ["SELECT", "INSERT", "UPDATE", "DELETE", "REFERENCES"]

  depends_on = [
    azurerm_postgresql_flexible_server_database.superset[0]
  ]
}

# USER - Superset
resource "postgresql_role" "superset_user" {
  count = var.enabled_superset ? 1 : 0

  name     = "superset"
  login    = true
  password = random_password.db_user_superset_psw[0].result
}

resource "kubernetes_secret" "superset" {
  count = var.enabled_superset ? 1 : 0
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
    SUPERSET_ADMIN_PSW  = random_password.superset_admin_user_psw[0].result
    SUPERSET_SECRET_KEY = random_password.superset_random_key[0].result
    DB_HOST             = data.azurerm_postgresql_flexible_server.qa_postgresql.fqdn
    DB_PORT             = "5432"
    DB_NAME             = "superset"
    DB_USER             = postgresql_role.superset_user[0].name
    DB_PASS             = postgresql_role.superset_user[0].password
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

# Superset - Dedicated DNS Record - Private dns record Ingress
resource "azurerm_private_dns_a_record" "ingress_superset" {
  name                = "qa-superset.${var.location_short}"
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = data.azurerm_private_dns_zone.internal.resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}