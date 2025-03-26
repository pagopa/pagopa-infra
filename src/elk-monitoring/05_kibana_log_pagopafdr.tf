#################################### [PAGOPA FDR] ####################################
locals {
  ## space
  fdr_space_name = "fdr"
  fdr_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/fdr/space.json", {
    name = "${local.fdr_space_name}"
  }), "\""), "\""), "'", "'\\''")

  pagopafdr_key         = "pagopafdr"
  log_fdr_index_pattern = "logs*fdr*" # all fdr log files

  pagopafdr_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/pagopa/fdr/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  pagopafdr_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/fdr/ilm-policy.json", {
    name        = local.pagopafdr_key,
    managed     = false,
    policy_name = "fdr-nightly-snapshots"
  }), "\""), "\""), "'", "'\\''")
  pagopafdr_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/fdr/component@custom.json", {
    pipeline  = local.pagopafdr_key
    lifecycle = local.pagopafdr_key
  }), "\""), "\""), "'", "'\\''")
  pagopafdr_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/fdr/index-template.json", {
    name                      = "fdr"
    component_template_custom = "${local.pagopafdr_key}@custom"
    index                     = local.log_fdr_index_pattern
  }), "\""), "\""), "'", "'\\''")

  # FDR
  pagopafdr_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/fdr/data-view.json", {
    key   = local.pagopafdr_key
    name  = "Dominio fdr"
    index = local.log_fdr_index_pattern
  }), "\""), "\""), "'", "'\\''")
}

## space
resource "null_resource" "fdr_kibana_space" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.fdr_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagofdr_ingest_pipeline" {
  depends_on = [null_resource.fdr_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.pagopafdr_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdr_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdr_ilm_policy" {
  depends_on = [null_resource.pagofdr_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.pagopafdr_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdr_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdr_component_template_custom" {
  depends_on = [null_resource.pagopafdr_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopafdr_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdr_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdr_index_template" {
  depends_on = [null_resource.pagopafdr_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.pagopafdr_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdr_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdr_data_stream_rollover" {
  depends_on = [null_resource.pagopafdr_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.pagopafdr_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdr_kibana_data_view" {
  depends_on = [null_resource.fdr_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.fdr_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdr_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
