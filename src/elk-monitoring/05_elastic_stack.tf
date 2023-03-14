module "elastic_stack" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.elastic
  ]

  source = "git::https://github.com/pagopa/azurerm.git//elastic_stack?ref=v4.11.0"

  namespace      = local.elk_namespace
  nodeset_config = var.nodeset_config

  eck_license = file("${path.module}/env/eck_license/pagopa-spa-non_production-37c2b1cf-8300-468b-aa62-ae266d02f76b-v5.json")

  env_short = var.env_short
  env = var.env

  kibana_external_domain = var.env_short == "p" ? "https://kibana.platform.pagopa.it/kibana" : "https://kibana.${var.env}.platform.pagopa.it/kibana"

  secret_name   = var.env_short == "p" ? "${var.location_short}${var.env}-kibana-internal-platform-pagopa-it" : "${var.location_short}${var.env}-kibana-internal-${var.env}-platform-pagopa-it"
  keyvault_name = module.key_vault.name

  kibana_internal_hostname = var.env_short == "p" ? "${var.location_short}${var.env}.kibana.internal.platform.pagopa.sSit" : "${var.location_short}${var.env}.kibana.internal.${var.env}.platform.pagopa.it"
}

data "kubernetes_secret" "get_elastic_credential" {
  depends_on = [
    module.elastic_stack
  ]

  metadata {
    name      = "quickstart-es-elastic-user"
    namespace = local.elk_namespace
  }
}

locals {
  kibana_url             = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/kibana" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/kibana"
  elastic_url            = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/elastic" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/elastic"
  replica_dashboard_path = var.env_short == "d" || var.env_short == "u" ? "nodo/dashboard-replica/*.ndjson" : "nodo/dashboard-replica/*.ndjson_trick_for_not_upload"
  replica_query_path     = var.env_short == "d" || var.env_short == "u" ? "nodo/query-replica/*.ndjson" : "nodo/query-replica/*.ndjson_trick_for_not_upload"
  ingest_pipeline        = { for filename in fileset(path.module, "nodo/pipeline/ingest_*.json") : replace(replace(basename(filename), "ingest_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  ilm_policy             = { for filename in fileset(path.module, "nodo/pipeline/ilm_*.json") : replace(replace(basename(filename), "ilm_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  component_template     = { for filename in fileset(path.module, "nodo/pipeline/component_*.json") : replace(replace(basename(filename), "component_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }

  fdr_ilm_policy             = { for filename in fileset(path.module, "fdr/ilm_policy_*.json") : replace(replace(basename(filename), "ilm_policy_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  fdr_component_template     = { for filename in fileset(path.module, "fdr/component_*.json") : replace(replace(basename(filename), "component_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  fdr_index_template         = { for filename in fileset(path.module, "fdr/index_template_*.json") : replace(replace(basename(filename), "index_template_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  fdr_kibana_space           = file("${path.module}/fdr/space.json")
  fdr_kibana_data_view       = file("${path.module}/fdr/data_view.json")
}

resource "null_resource" "ingest_pipeline" {
  depends_on = [data.kubernetes_secret.get_elastic_credential]

  for_each = local.ingest_pipeline

  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ilm_policy" {
  depends_on = [null_resource.ingest_pipeline]

  for_each = local.ilm_policy

  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "component_template" {
  depends_on = [null_resource.ilm_policy]

  for_each = local.component_template

  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "rollover" {
  depends_on = [null_resource.component_template]

  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-kubernetes.container_logs-default/_rollover/" -H 'kbn-xsrf: true'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "upload_query" {
  depends_on = [null_resource.rollover]

  for_each = fileset(path.module, "nodo/query/*.ndjson")

  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "upload_query_replica" {
  depends_on = [null_resource.upload_query]

  for_each = fileset(path.module, local.replica_query_path)

  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "upload_dashboard" {
  depends_on = [null_resource.upload_query_replica]

  for_each = fileset(path.module, "nodo/dashboard/*.ndjson")

  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "upload_dashboard_replica" {
  depends_on = [null_resource.upload_dashboard]

  for_each = fileset(path.module, local.replica_dashboard_path)

  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
#################################### [FDR] ####################################
resource "null_resource" "fdr_ilm_policy" {
  depends_on = [null_resource.upload_dashboard_replica]

  for_each = local.fdr_ilm_policy

  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "fdr_component_template" {
  depends_on = [null_resource.fdr_ilm_policy]

  for_each = local.fdr_component_template

  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "fdr_index_template" {
  depends_on = [null_resource.fdr_component_template]

  for_each = local.fdr_index_template

  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "fdr_kibana_space" {
  depends_on = [null_resource.fdr_index_template]

  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.fdr_kibana_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "fdr_kibana_data_view" {
  depends_on = [null_resource.fdr_kibana_space]

  # triggers = {
  #   always_run = "${timestamp()}"
  # }

  provisioner "local-exec" {
    command     = <<EOT
      data_view=$(curl -k -X POST "${local.kibana_url}/s/fdr/api/data_views/data_view" \
        -H 'kbn-xsrf: true' \
        -H 'Content-Type: application/json' \
        -d '${local.fdr_kibana_data_view}')
      
      data_view_id=$(echo $data_view | jq -r ".data_view.id")

      curl -k -X POST "${local.kibana_url}/s/fdr/api/data_views/default" \
        -H 'kbn-xsrf: true' \
        -H 'Content-Type: application/json' \
        -d '{
              "data_view_id": "'$data_view_id'",
              "force": true
            }'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}


resource "helm_release" "opentelemetry_operator_helm" {
  depends_on = [null_resource.fdr_kibana_data_view]

  provisioner "local-exec" {
    when        = destroy
    command     = "kubectl delete crd opentelemetrycollectors.opentelemetry.io"
    interpreter = ["/bin/bash", "-c"]
  }
  provisioner "local-exec" {
    when        = destroy
    command     = "kubectl delete crd instrumentations.opentelemetry.io"
    interpreter = ["/bin/bash", "-c"]
  }

  name       = "opentelemetry-operator"
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-operator"
  version    = var.opentelemetry_operator_helm.chart_version
  namespace  = local.elk_namespace

  values = [
    "${file("${var.opentelemetry_operator_helm.values_file}")}"
  ]

}

resource "kubectl_manifest" "otel_collector" {
  depends_on = [
    helm_release.opentelemetry_operator_helm
  ]
  yaml_body =  templatefile("${path.module}/env/opentelemetry_operator_helm/otel.yaml", {
    namespace = local.elk_namespace
  })

  force_conflicts = true
  wait            = true
}