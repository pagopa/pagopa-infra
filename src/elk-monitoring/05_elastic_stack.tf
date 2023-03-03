# module "elastic_stack" {
#   depends_on = [
#     azurerm_kubernetes_cluster_node_pool.elastic
#   ]
#   #  source = "git::https://github.com/pagopa/azurerm.git//elastic_stack?ref=v4.9.0"
#   source = "/Users/massimoscattarella/projects/pagopa/azurerm/elastic_stack"

#   namespace      = local.elk_namespace
#   nodeset_config = var.nodeset_config

#   kibana_external_domain = var.env_short == "p" ? "https://kibana.platform.pagopa.it/kibana" : "https://kibana.${var.env}.platform.pagopa.it/kibana"

#   secret_name   = var.env_short == "p" ? "${var.location_short}${var.env}-kibana-internal-platform-pagopa-it" : "${var.location_short}${var.env}-kibana-internal-${var.env}-platform-pagopa-it"
#   keyvault_name = module.key_vault.name

#   kibana_internal_hostname = var.env_short == "p" ? "${var.location_short}${var.env}.kibana.internal.platform.pagopa.it" : "${var.location_short}${var.env}.kibana.internal.${var.env}.platform.pagopa.it"
# }

# data "kubernetes_secret" "get_elastic_credential" {
#   depends_on = [
#     module.elastic_stack
#   ]

#   metadata {
#     name      = "quickstart-es-elastic-user"
#     namespace = local.elk_namespace
#   }
# }

# locals {
#   kibana_url             = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/kibana" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/kibana"
#   elastic_url            = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/elastic" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/elastic"
#   json_dashboards        = { for filename in fileset(path.module, "nodo/dashboard/*.ndjson") : filename => file("${path.module}/${filename}") }
#   replica_dashboard_path = var.env_short == "d" || var.env_short == "u" ? "nodo/dashboard-replica/*.ndjson" : "nodo/dashboard-replica/*.ndjson_trick_for_not_upload"
#   ingest_pipeline        = { for filename in fileset(path.module, "nodo/pipeline/ingest_*.json") : replace(replace(basename(filename), "ingest_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
#   ilm_policy             = { for filename in fileset(path.module, "nodo/pipeline/ilm_*.json") : replace(replace(basename(filename), "ilm_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
#   component_template     = { for filename in fileset(path.module, "nodo/pipeline/component_*.json") : replace(replace(basename(filename), "component_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
# }

# resource "null_resource" "ingest_pipeline" {
#   depends_on = [data.kubernetes_secret.get_elastic_credential]

#   for_each = local.ingest_pipeline

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${each.key}" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${each.value}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "ilm_policy" {
#   depends_on = [null_resource.ingest_pipeline]

#   for_each = local.ilm_policy

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${each.key}" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${each.value}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "component_template" {
#   depends_on = [null_resource.ilm_policy]

#   for_each = local.component_template

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${each.key}" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${each.value}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "rollover" {
#   depends_on = [null_resource.component_template]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X POST "${local.elastic_url}/logs-kubernetes.container_logs-default/_rollover/" -H 'kbn-xsrf: true'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "upload_dashboard" {
#   depends_on = [null_resource.rollover]

#   for_each = fileset(path.module, "nodo/dashboard/*.ndjson")

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "upload_dashboard_replica" {
#   depends_on = [null_resource.upload_dashboard]

#   for_each = fileset(path.module, local.replica_dashboard_path)

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }


