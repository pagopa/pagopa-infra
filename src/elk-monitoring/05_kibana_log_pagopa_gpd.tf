#################################### [PAGOPA GPD] ####################################
locals {
  ## space
  gpd_space_name = "gpd"
  gpd_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/gpd/space.json", {
    name = "${local.gpd_space_name}"
  }), "\""), "\""), "'", "'\\''")

  pagopagpd_key = "pagopagpd"

  pagopagpd_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/pagopa/gpd/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  pagopagpd_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/gpd/ilm-policy.json", {
    name        = local.pagopagpd_key,
    managed     = false,
    policy_name = "gpd-nightly-snapshots"
  }), "\""), "\""), "'", "'\\''")
  pagopagpd_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/gpd/component@custom.json", {
    pipeline  = local.pagopagpd_key
    lifecycle = local.pagopagpd_key
  }), "\""), "\""), "'", "'\\''")
  pagopagpd_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/gpd/index-template.json", {
    name                      = "gpd"
    component_template_custom = "${local.pagopagpd_key}@custom"
  }), "\""), "\""), "'", "'\\''")

  pagopagpd_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/gpd/data-view.json", {
    key   = local.pagopagpd_key
    name  = "Dominio GPD"
    index = "gpd"
  }), "\""), "\""), "'", "'\\''")
}

## space
resource "null_resource" "gpd_kibana_space" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.gpd_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagogpd_ingest_pipeline" {
  depends_on = [null_resource.gpd_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.pagopagpd_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopagpd_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopagpd_ilm_policy" {
  depends_on = [null_resource.pagogpd_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.pagopagpd_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopagpd_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopagpd_component_template_custom" {
  depends_on = [null_resource.pagopagpd_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopagpd_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopagpd_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "pagopagpd_index_template" {
  depends_on = [null_resource.pagopagpd_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.pagopagpd_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopagpd_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopagpd_data_stream_rollover" {
  depends_on = [null_resource.pagopagpd_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.pagopagpd_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
resource "null_resource" "pagopapayments_data_stream_rollover" {
  depends_on = [null_resource.pagopagpd_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.pagopagpd_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopagpd_kibana_data_view" {
  depends_on = [null_resource.gpd_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.gpd_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopagpd_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
