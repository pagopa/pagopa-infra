#################################### [PAGOPA PAYMENT OPTIONS] ####################################
locals {
  ## space
  paymentoptions_space_name = "paymentoptions"
  paymentoptions_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/paymentoptions/space.json", {
    name = "${local.paymentoptions_space_name}"
  }), "\""), "\""), "'", "'\\''")

  ## pagopapaymentoptions
  pagopapaymentoptions_key = "pagopapaymentoptions"

  pagopapaymentoptions_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/pagopa/paymentoptions/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  pagopapaymentoptions_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/paymentoptions/ilm-policy.json", {
    name        = local.pagopapaymentoptions_key,
    managed     = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  pagopapaymentoptions_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/paymentoptions/component@custom.json", {
    pipeline  = local.pagopapaymentoptions_key
    lifecycle = local.pagopapaymentoptions_key
  }), "\""), "\""), "'", "'\\''")
  pagopapaymentoptions_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/paymentoptions/index-template.json", {
    name                      = "payment-options"
    component_template_custom = "${local.pagopapaymentoptions_key}@custom"
  }), "\""), "\""), "'", "'\\''")

  pagopapaymentoptions_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/paymentoptions/data-view.json", {
    key   = local.pagopapaymentoptions_key
    name  = "Opzioni di Pagamento"
    index = "paymentoptions"
  }), "\""), "\""), "'", "'\\''")
}

## space
resource "null_resource" "paymentoptions_kibana_space" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.paymentoptions_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopaymentoptions_ingest_pipeline" {
  depends_on = [null_resource.paymentoptions_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.pagopapaymentoptions_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapaymentoptions_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapaymentoptions_ilm_policy" {
  depends_on = [null_resource.pagopaymentoptions_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.pagopapaymentoptions_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapaymentoptions_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapaymentoptions_component_template_custom" {
  depends_on = [null_resource.pagopapaymentoptions_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopapaymentoptions_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapaymentoptions_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "pagopapaymentoptions_index_template" {
  depends_on = [null_resource.pagopapaymentoptions_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.pagopapaymentoptions_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapaymentoptions_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapaymentoptions_data_stream_rollover" {
  depends_on = [null_resource.pagopapaymentoptions_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.pagopapaymentoptions_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapaymentoptions_kibana_data_view" {
  depends_on = [null_resource.paymentoptions_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.paymentoptions_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapaymentoptions_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
