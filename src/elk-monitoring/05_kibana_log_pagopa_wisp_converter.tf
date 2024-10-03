#################################### [PAGOPA WISP] ####################################
locals {
  ## space
  wisp_space_name = "nodo"
  wisp_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/wisp/space.json", {
    name = "${local.wisp_space_name}"
  }), "\""), "\""), "'", "'\\''")

  pagopawisp_key     = "pagopawisp"
  log_index_pattern = "logs*wisp*"

  pagopawisp_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/pagopa/wisp/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  pagopawisp_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/wisp/ilm-policy.json", {
    name        = local.pagopawisp_key,
    managed     = false,
    policy_name = "wisp-nightly-snapshots"
  }), "\""), "\""), "'", "'\\''")
  pagopawisp_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/wisp/component@custom.json", {
    pipeline  = local.pagopawisp_key
    lifecycle = local.pagopawisp_key
  }), "\""), "\""), "'", "'\\''")
  pagopawisp_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/wisp/index-template.json", {
    name                      = "WISP"
    component_template_custom = "${local.pagopawisp_key}@custom"
    index                     = local.log_index_pattern
  }), "\""), "\""), "'", "'\\''")

  pagopawisp_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/wisp/data-view.json", {
    key   = local.pagopawisp_key
    name  = "Dominio WISP"
    index = local.log_index_pattern
  }), "\""), "\""), "'", "'\\''")
}

## space
resource "null_resource" "wisp_kibana_space" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.wisp_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagowisp_ingest_pipeline" {
  depends_on = [null_resource.wisp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.pagopawisp_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopawisp_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopawisp_ilm_policy" {
  depends_on = [null_resource.pagowisp_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.pagopawisp_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopawisp_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopawisp_component_template_custom" {
  depends_on = [null_resource.pagopawisp_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopawisp_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopawisp_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "pagopawisp_index_template" {
  depends_on = [null_resource.pagopawisp_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.pagopawisp_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopawisp_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopawisp_data_stream_rollover" {
  depends_on = [null_resource.pagopawisp_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.pagopawisp_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
resource "null_resource" "pagopawispconv_data_stream_rollover" {
  depends_on = [null_resource.pagopawisp_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.pagopawisp_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopawisp_kibana_data_view" {
  depends_on = [null_resource.wisp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.wisp_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopawisp_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}