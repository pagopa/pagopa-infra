data "azurerm_key_vault_secret" "pgres_admin_login" {
  name         = "db-apd-user-name"
  key_vault_id = "pagopa-${var.env_short}-gps-kv"
}

data "azurerm_key_vault_secret" "pgres_admin_pwd" {
  name         = "db-apd-user-password"
  key_vault_id = "pagopa-${var.env_short}-gps-kv"
}

resource "helm_release" "strimzi-kafka-operator" {
  name       = "strimzi-kafka-operator"
  repository = "https://strimzi.io/charts/strimzi-kafka-operator"
  chart      = "strimzi-kafka-operator"
  version    = "0.8.2"

  namespace  = kubernetes_namespace.namespace.metadata[0].name
}

locals {

  debezium_role_yaml = templatefile("${path.module}/yaml/debezium-role.yaml", {
    namespace = kubernetes_namespace.namespace.metadata[0].name
  })

  debezium_rbac_yaml = templatefile("${path.module}/yaml/debezium-rbac.yaml", {
    namespace = kubernetes_namespace.namespace.metadata[0].name
  })

  debezium_secrets_yaml = templatefile("${path.module}/yaml/debezium-secretes.yaml", {
    namespace = kubernetes_namespace.namespace.metadata[0].name
    username  = data.azurerm_key_vault_secret.pgres_admin_login.value
    password  = data.azurerm_key_vault_secret.pgres_admin_pwd.value
  })

  zookeeper_yaml = templatefile("${path.module}/yaml/zookeper.yaml", {
    namespace                =  kubernetes_namespace.namespace.metadata[0].name
    zookeeper_replicas       =  var.zookeeper_replicas
    zookeeper_request_memory =  var.zookeeper_request_memory
    zookeeper_request_cpu    =  var.zookeeper_request_cpu
    zookeeper_limits_memory  =  var.zookeeper_limits_memory
    zookeeper_limits_cpu     =  var.zookeeper_limits_cpu
    zookeeper_jvm_xms        =  var.zookeeper_jvm_xms
    zookeeper_jvm_xmx        =  var.zookeeper_jvm_xmx
    zookeeper_storage_size   =  var.zookeeper_storage_size
  })

  kafka_connect_yaml = templatefile("${path.module}/yaml/kafka-connect.yaml", {
    namespace             =  kubernetes_namespace.namespace.metadata[0].name
    replicas              =  var.replicas
    request_memory        =  var.request_memory
    request_cpu           =  var.request_cpu
    limits_memory         =  var.limits_memory
    limits_cpu            =  var.limits_cpu
    bootstrap_servers     =  "pagopa-${var.env_short}-${var.location_short}-${local.project}-evh.servicebus.windows.net:9092"
    eh_connection_string  =  "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"$ConnectionString\" password=\"${data.azurerm_eventhub_namespace_authorization_rule.cdc_connection_string.primary_connection_string}\";"
    container_registry    =  var.container_registry
  })

  postgres_connector_yaml = templatefile("${path.module}/yaml/postgres-connector.yaml", {
    namespace             =  kubernetes_namespace.namespace.metadata[0].name
    postgres_hostname     =  "pagopa-${var.env_short}-gpd-postgresql.postgres.database.azure.com"
    postgres_port         =  6432
    postgres_db_name      =  var.postgres_db_name
    postgres_topic_prefix = "gpd"
    tasks_max             =  var.tasks_max
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
  depends_on = [kubectl_manifest.debezium_role, kubectl_manifest.debezium_secrets]
  force_conflicts = true
  yaml_body       = local.debezium_rbac_yaml
}

resource "kubectl_manifest" "zookeper_manifest" {
  depends_on = [
    helm_release.strimzi-kafka-operator
  ]
  force_conflicts = true
  yaml_body       = local.zookeeper_yaml
}

resource "null_resource" "wait_zookeeper" {
  depends_on = [
    kubectl_manifest.zookeper_manifest
  ]
  provisioner "local-exec" {
    command     = "while [ true ]; do STATUS=`kubectl -n ${kubernetes_namespace.namespace.metadata[0].name} get Kafka -ojsonpath='{range .items[*]}{.status.health}'`; if [ \"$STATUS\" = \"green\" ]; then echo \"Zookeper SUCCEEDED\" ; break ; else echo \"Zookeeper INPROGRESS\"; sleep 3; fi ; done"
    interpreter = ["/bin/bash", "-c"]
  }
}

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
    command     = "while [ true ]; do STATUS=`kubectl -n ${kubernetes_namespace.namespace.metadata[0].name} get KafkaConnect -ojsonpath='{range .items[*]}{.status.health}'`; if [ \"$STATUS\" = \"green\" ]; then echo \"Kafka Connect SUCCEEDED\" ; break ; else echo \"Kafka Connect INPROGRESS\"; sleep 3; fi ; done"
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
    command     = "while [ true ]; do STATUS=`kubectl -n ${kubernetes_namespace.namespace.metadata[0].name} get KafkaConnector -ojsonpath='{range .items[*]}{.status.health}'`; if [ \"$STATUS\" = \"green\" ]; then echo \"Postgres Connector SUCCEEDED\" ; break ; else echo \"Postgres Connector INPROGRESS\"; sleep 3; fi ; done"
    interpreter = ["/bin/bash", "-c"]
  }
}
