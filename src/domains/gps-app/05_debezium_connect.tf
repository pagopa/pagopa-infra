# https://debezium.io/documentation/reference/stable/operations/kubernetes.html#_creating_a_debezium_connector
data "azurerm_key_vault_secret" "pgres_gpd_cdc_login" {
  # name         = "db-apd-user-name"
  name         = "cdc-logical-replication-apd-user"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "pgres_gpd_cdc_pwd" {
  # name         = "db-apd-user-password"
  name         = "cdc-logical-replication-apd-pwd"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_eventhub_namespace_authorization_rule" "cdc_connection_string" {
  name                = "cdc-gpd-connection-string"
  namespace_name      = "pagopa-${var.env_short}-itn-observ-gpd-evh"
  resource_group_name = "pagopa-${var.env_short}-itn-observ-evh-rg"
}

# https://github.com/strimzi/strimzi-kafka-operator/tree/main/helm-charts/helm3/strimzi-kafka-operator
resource "helm_release" "strimzi-kafka-operator" {
  name       = "strimzi-kafka-operator"
  chart      = "strimzi-kafka-operator"
  repository = "oci://quay.io/strimzi-helm"
  version    = "0.43.0"
  namespace  = "gps" # kubernetes_namespace.namespace.metadata[0].name
}

locals {

  debezium_role_yaml = templatefile("${path.module}/yaml/debezium-role.yaml", {
    namespace = "gps" # kubernetes_namespace.namespace.metadata[0].name
  })

  debezium_rbac_yaml = templatefile("${path.module}/yaml/debezium-rbac.yaml", {
    namespace = "gps" # kubernetes_namespace.namespace.metadata[0].name
  })

  debezium_secrets_yaml = templatefile("${path.module}/yaml/debezium-secrets.yaml", {
    namespace         = "gps" # kubernetes_namespace.namespace.metadata[0].name
    username          = base64encode(data.azurerm_key_vault_secret.pgres_gpd_cdc_login.value)
    password          = base64encode(data.azurerm_key_vault_secret.pgres_gpd_cdc_pwd.value)
    connection_string = base64encode(data.azurerm_eventhub_namespace_authorization_rule.cdc_connection_string.primary_connection_string)
  })

  # zookeeper_yaml = templatefile("${path.module}/yaml/zookeeper.yaml", {
  #   namespace                = "gps" # kubernetes_namespace.namespace.metadata[0].name
  #   zookeeper_replicas       = var.zookeeper_replicas
  #   zookeeper_request_memory = var.zookeeper_request_memory
  #   zookeeper_request_cpu    = var.zookeeper_request_cpu
  #   zookeeper_limits_memory  = var.zookeeper_limits_memory
  #   zookeeper_limits_cpu     = var.zookeeper_limits_cpu
  #   zookeeper_jvm_xms        = var.zookeeper_jvm_xms
  #   zookeeper_jvm_xmx        = var.zookeeper_jvm_xmx
  #   zookeeper_storage_size   = var.zookeeper_storage_size
  # })

  # Az config
  # https://learn.microsoft.com/it-it/azure/event-hubs/event-hubs-kafka-connect-debezium#configure-kafka-connect-for-event-hubs

  kafka_connect_yaml = templatefile("${path.module}/yaml/kafka-connect.yaml", {
    namespace          = "gps" # kubernetes_namespace.namespace.metadata[0].name
    replicas           = var.replicas
    request_memory     = var.request_memory
    request_cpu        = var.request_cpu
    limits_memory      = var.limits_memory
    limits_cpu         = var.limits_cpu
    bootstrap_servers  = "pagopa-${var.env_short}-itn-observ-gpd-evh.servicebus.windows.net:9093"
    container_registry = var.container_registry
  })

  postgres_connector_yaml = templatefile("${path.module}/yaml/postgres-connector.yaml", {
    namespace         = "gps" # kubernetes_namespace.namespace.metadata[0].name
    postgres_hostname = "pagopa-${var.env_short}-gpd-pgflex.postgres.database.azure.com"

    postgres_port         = 5432
    postgres_db_name      = var.postgres_db_name
    postgres_topic_prefix = "azcligpd"
    postgres_username     = data.azurerm_key_vault_secret.pgres_gpd_cdc_login.value
    postgres_password     = data.azurerm_key_vault_secret.pgres_gpd_cdc_pwd.value
    tasks_max             = var.tasks_max
  })

}

resource "kubectl_manifest" "debezium_role" {
  force_conflicts = true
  yaml_body       = local.debezium_role_yaml
}

resource "kubectl_manifest" "debezium_secrets" {
  force_conflicts = true
  yaml_body       = local.debezium_secrets_yaml
}

resource "kubectl_manifest" "debezoum_rbac" {
  # depends_on      = [kubectl_manifest.debezium_role, kubectl_manifest.debezium_secrets]
  depends_on      = [kubectl_manifest.debezium_role]
  force_conflicts = true
  yaml_body       = local.debezium_rbac_yaml
}

# resource "kubectl_manifest" "zookeper_manifest" {
#   depends_on = [
#     helm_release.strimzi-kafka-operator
#   ]
#   force_conflicts = true
#   yaml_body       = local.zookeeper_yaml
# }

# resource "null_resource" "wait_zookeeper" {
#   depends_on = [
#     kubectl_manifest.zookeper_manifest
#   ]
#   provisioner "local-exec" {
#     command     = "while [ true ]; do STATUS=`kubectl -n gps get Kafka -ojsonpath='{range .items[*]}{.status.health}'`; if [ \"$STATUS\" = \"green\" ]; then echo \"Zookeper SUCCEEDED\" ; break ; else echo \"Zookeeper INPROGRESS\"; sleep 3; fi ; done"
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

resource "kubectl_manifest" "kafka_connect" {
  depends_on = [
    helm_release.strimzi-kafka-operator
  ]
  force_conflicts = true
  yaml_body       = local.kafka_connect_yaml
}

resource "null_resource" "wait_kafka_connect" {
  depends_on = [
    kubectl_manifest.kafka_connect
  ]
  provisioner "local-exec" {
    command     = "while [ true ]; do STATUS=`kubectl -n gps get KafkaConnect -o json | jq -r '.items[] | select(.status).status | .conditions | any(.[]; .type == \"Ready\")' | uniq`; if [ \"$STATUS\" = \"true\" ]; then echo \"Kafka Connect SUCCEEDED\" ; break ; else echo \"Kafka Connect INPROGRESS\"; sleep 3; fi ; done"
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "kubectl_manifest" "postgres_connector" {
  depends_on = [
    helm_release.strimzi-kafka-operator
  ]
  force_conflicts = true
  yaml_body       = local.postgres_connector_yaml
}

resource "null_resource" "wait_postgres_connector" {
  depends_on = [
    kubectl_manifest.kafka_connect
  ]
  provisioner "local-exec" {
    command     = "while [ true ]; do STATUS=`kubectl -n gps get KafkaConnector -o json | jq -r '.items[] | select(.status).status | .conditions | any(.[]; .type == \"Ready\")' | uniq`; if [ \"$STATUS\" = \"true\" ]; then echo \"Postgres Connector SUCCEEDED\" ; break ; else echo \"Postgres Connector INPROGRESS\"; sleep 3; fi ; done"
    interpreter = ["/bin/bash", "-c"]
  }
}
