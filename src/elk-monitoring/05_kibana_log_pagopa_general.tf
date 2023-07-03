#################################### [PAGOPA] ####################################
locals {
  pagopa_key    = "pagopa"
  pipeline_name = "json_parser"

  pagopa_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/${local.pagopa_key}/space.json", {
    name = "${local.pagopa_key}"
  }), "\""), "\""), "'", "'\\''")

  pagopa_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/${local.pagopa_key}/data-view.json", {
    name = local.pagopa_key
  }), "\""), "\""), "'", "'\\''")

  pagopa_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/${local.pagopa_key}/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")

  snapshot_key        = "pagopa_snapshot_backup"
  snapshot_policy_key = "pagopa-nightly-snapshots"
  snapshot_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/${local.pagopa_key}/snapshot_policy.json", {
    repository_name = local.snapshot_key
  }), "\""), "\""), "'", "'\\''")


  pagopa_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/${local.pagopa_key}/ilm-policy.json", {
    policy_name = local.snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")

  pagopa_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/${local.pagopa_key}/logs-kubernetes.container_logs@custom.json", {
    name = local.pipeline_name
  }), "\""), "\""), "'", "'\\''")
}

## space
resource "null_resource" "pagopa_kibana_space" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopa_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopa_ingest_pipeline" {
  depends_on = [null_resource.pagopa_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.pipeline_name}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopa_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopa_ilm_policy" {
  depends_on = [null_resource.pagopa_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.pagopa_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopa_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopa_component_template_custom" {
  depends_on = [null_resource.pagopa_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/logs-kubernetes.container_logs@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopa_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "pagopa_data_stream_rollover" {
  depends_on = [null_resource.pagopa_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-kubernetes.container_logs-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopa_kibana_data_view" {
  depends_on = [null_resource.pagopa_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.pagopa_key}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopa_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
