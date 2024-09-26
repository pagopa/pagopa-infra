#################################### [PRINTIT] ####################################
locals {
  ## space
  payopt_space_name = "payopt"
  payopt_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/payopt/space.json", {
    name = "${local.payopt_space_name}"
  }), "\""), "\""), "'", "'\\''")

  ## payopt
  pagopapayopt_key = "pagopapayopt"

  pagopapayopt_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/pagopa/payopt/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  pagopapayopt_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/payopt/ilm-policy.json", {
    name        = local.pagopapayopt_key,
    managed     = false,
    policy_name = "payopt-nightly-snapshots"
  }), "\""), "\""), "'", "'\\''")
  pagopapayopt_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/payopt/component@custom.json", {
    pipeline  = local.pagopapayopt_key
    lifecycle = local.pagopapayopt_key
  }), "\""), "\""), "'", "'\\''")
  pagopapayopt_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/payopt/index-template.json", {
    name                      = "payment-options"
    component_template_custom = "${local.pagopapayopt_key}@custom"
  }), "\""), "\""), "'", "'\\''")


  pagopapayopt_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/payopt/data-view.json", {
    key   = local.pagopapayopt_key
    name  = "Opzioni Pagamento"
    index = "payment-options"
  }), "\""), "\""), "'", "'\\''")
}

## space
resource "null_resource" "payopt_kibana_space" {
  #   depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.payopt_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapayopt_ingest_pipeline" {
  depends_on = [null_resource.payopt_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.pagopapayopt_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapayopt_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapayopt_ilm_policy" {
  depends_on = [null_resource.pagopapayopt_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.pagopapayopt_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapayopt_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapayopt_component_template_custom" {
  depends_on = [null_resource.pagopapayopt_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopapayopt_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapayopt_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "pagopapayopt_index_template" {
  depends_on = [null_resource.pagopapayopt_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.pagopapayopt_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapayopt_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapayopt_service_data_stream_rollover" {
  depends_on = [null_resource.pagopapayopt_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-payment-options-service-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapayopt_kibana_data_view" {
  depends_on = [null_resource.payopt_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.payopt_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapayopt_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
