#################################### [PAGOPA PAYMENTS PULL] ####################################
locals {
  ## space
  paymentspull_space_name = "gps"
  paymentspull_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/gps/space.json", {
    name = "${local.paymentspull_space_name}"
  }), "\""), "\""), "'", "'\\''")

  ## payments_pull
  pagopapaymentspull_key = "pagopapaymentspull"

  pagopapaymentspull_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/pagopa/gps/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  pagopapaymentspull_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/gps/ilm-policy.json", {
    name        = local.pagopapaymentspull_key,
    managed     = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  pagopapaymentspull_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/gps/component@custom.json", {
    pipeline  = local.pagopapaymentspull_key
    lifecycle = local.pagopapaymentspull_key
  }), "\""), "\""), "'", "'\\''")
  pagopapaymentspull_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/gps/index-template.json", {
    name                      = "gpd-payments-pull"
    component_template_custom = "${local.pagopapaymentspull_key}@custom"
  }), "\""), "\""), "'", "'\\''")

  pagopapaymentspull_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/gps/data-view.json", {
    name  = "Pagamenti Pull"
    index = "gpd-payments-pull"
  }), "\""), "\""), "'", "'\\''")
}

## space
resource "null_resource" "paymentspull_kibana_space" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.paymentspull_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopaymentspull_ingest_pipeline" {
  depends_on = [null_resource.paymentspull_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.pagopapaymentspull_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapaymentspull_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapaymentspull_ilm_policy" {
  depends_on = [null_resource.pagopaymentspull_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.pagopapaymentspull_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapaymentspull_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapaymentspull_component_template_custom" {
  depends_on = [null_resource.pagopapaymentspull_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopapaymentspull_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapaymentspull_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "pagopapaymentspull_index_template" {
  depends_on = [null_resource.pagopapaymentspull_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.pagopapaymentspull_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapaymentspull_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapaymentspull_data_stream_rollover" {
  depends_on = [null_resource.pagopapaymentspull_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.pagopapaymentspull_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapaymentspull_kibana_data_view" {
  depends_on = [null_resource.paymentspull_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.paymentspull_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapaymentspull_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
