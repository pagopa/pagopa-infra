resource "azurerm_container_app" "zabbix_server" {
  name                         = "${local.project}-server-capp"
  container_app_environment_id = data.azurerm_container_app_environment.tools_cae.id
  resource_group_name          = data.azurerm_container_app_environment.tools_cae.resource_group_name
  revision_mode                = "Single"

  secret {
    name  = "secret-postgres-password"
    value = random_password.zabbix_pg_admin_password.result
  }

  template {
    min_replicas = 1
    max_replicas = 1

    container {
      name   = "zabbix-server"
      image  = "zabbix/zabbix-server-pgsql:ubuntu-6.4.10"
      cpu    = 1.0
      memory = "2Gi"

      env {
        name  = "ZBX_STARTJAVAPOLLERS"
        value = 10
      }
      env {
        name  = "ZBX_SERVICEMANAGERSYNCFREQUENCY"
        value = 15
      }
      #
      # DB
      #
      env {
        name  = "DB_SERVER_HOST"
        value = "pagopa-${var.env_short}-weu-zabbix-pgflex.postgres.database.azure.com"
      }
      env {
        name  = "POSTGRES_DB"
        value = "zabbix"
      }
      env {
        name  = "POSTGRES_USER"
        value = "postgres"
      }
      env {
        name        = "POSTGRES_PASSWORD"
        secret_name = "secret-postgres-password"
      }

      liveness_probe {
        failure_count_threshold = 10
        interval_seconds        = 10
        initial_delay           = 10

        port      = 10051
        transport = "TCP"
      }

      readiness_probe {
        failure_count_threshold = 10
        interval_seconds        = 10
        port                    = 10051
        transport               = "TCP"
      }
    }

  }

  ingress {
    external_enabled = false
    target_port      = 10051
    exposed_port     = 10051
    transport        = "tcp"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

}

resource "azurerm_container_app" "zabbix_frontend" {
  name                         = "${local.project}-web-capp"
  container_app_environment_id = data.azurerm_container_app_environment.tools_cae.id
  resource_group_name          = data.azurerm_container_app_environment.tools_cae.resource_group_name
  revision_mode                = "Single"

  secret {
    name  = "secret-postgres-password"
    value = random_password.zabbix_pg_admin_password.result
  }

  template {
    min_replicas = 1
    max_replicas = 1

    container {
      name   = "zabbix-web-nginx-pgsql"
      image  = "zabbix/zabbix-web-nginx-pgsql:ubuntu-6.4.10"
      cpu    = 0.25
      memory = "0.5Gi"

      env {
        name  = "ZBX_SERVER_HOST"
        value = azurerm_container_app.zabbix_server.name
      }
      env {
        name  = "PHP_TZ"
        value = "Europe/Rome"
      }
      #
      # DB
      #
      env {
        name  = "DB_SERVER_HOST"
        value = "pagopa-${var.env_short}-weu-zabbix-pgflex.postgres.database.azure.com"
      }
      env {
        name  = "POSTGRES_DB"
        value = "zabbix"
      }
      env {
        name  = "POSTGRES_USER"
        value = "postgres"
      }
      env {
        name        = "POSTGRES_PASSWORD"
        secret_name = "secret-postgres-password"
      }

      liveness_probe {
        failure_count_threshold = 10
        initial_delay           = 10
        interval_seconds        = 10
        path                    = "/"
        port                    = 8080
        transport               = "HTTP"
      }

      readiness_probe {
        failure_count_threshold = 10
        interval_seconds        = 10
        path                    = "/"
        port                    = 8080
        transport               = "HTTP"
      }
    }

  }

  ingress {
    external_enabled = true
    target_port      = 8080
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

}

resource "azurerm_container_app" "zabbix_agent" {
  name                         = "${local.project}-agent-capp"
  container_app_environment_id = data.azurerm_container_app_environment.tools_cae.id
  resource_group_name          = data.azurerm_container_app_environment.tools_cae.resource_group_name
  revision_mode                = "Single"

  secret {
    name  = "secret-postgres-password"
    value = random_password.zabbix_pg_admin_password.result
  }

  template {
    min_replicas = 1
    max_replicas = 1

    container {
      name   = "zabbix-agent"
      image  = "zabbix/zabbix-agent2:ubuntu-6.4.10"
      cpu    = 0.25
      memory = "0.5Gi"

      env {
        name  = "ZBX_PASSIVESERVERS"
        value = "0.0.0.0/0"
      }
      env {
        name  = "ZBX_STARTAGENTS"
        value = 1
      }
      env {
        name  = "ZBX_PASSIVE_ALLOW"
        value = true
      }
      env {
        name  = "ZBX_ACTIVE_ALLOW"
        value = true
      }

      liveness_probe {
        failure_count_threshold = 10
        interval_seconds        = 10
        initial_delay           = 10

        port      = 10050
        transport = "TCP"
      }

      readiness_probe {
        failure_count_threshold = 10
        interval_seconds        = 10
        port                    = 10050
        transport               = "TCP"
      }
    }
  }

  ingress {
    external_enabled = false
    target_port      = 10050
    exposed_port     = 10050
    transport        = "tcp"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

}
