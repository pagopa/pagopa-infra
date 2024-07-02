#################################### [PRINTIT] ####################################
locals {
  ## space
  printit_space_name = "printit"
  printit_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/space.json", {
    name = "${local.printit_space_name}"
  }), "\""), "\""), "'", "'\\''")

  ## printit
  pagopaprintit_key = "pagopaprintit"

  pagopaprintit_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/log-template/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  pagopaprintit_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name        = local.pagopaprintit_key,
    managed     = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  pagopaprintit_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
    name = local.pagopaprintit_key
  }), "\""), "\""), "'", "'\\''")
  pagopaprintit_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
    name = local.pagopaprintit_key
  }), "\""), "\""), "'", "'\\''")
  pagopaprintit_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
    name                       = local.pagopaprintit_key
    component_template_package = "${local.pagopaprintit_key}@package"
    component_template_custom  = "${local.pagopaprintit_key}@custom"
  }), "\""), "\""), "'", "'\\''")


  pagopaprintit_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
    name = local.pagopaprintit_key
  }), "\""), "\""), "'", "'\\''")
}

## space
resource "null_resource" "printit_kibana_space" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.printit_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopaprintit_ingest_pipeline" {
  depends_on = [null_resource.fdr_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.pagopaprintit_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopaprintit_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopaprintit_ilm_policy" {
  depends_on = [null_resource.pagopaprintit_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.pagopaprintit_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopaprintit_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopaprintit_component_template_package" {
  depends_on = [null_resource.pagopaprintit_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopaprintit_key}@package" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopaprintit_component_template_package}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopaprintit_component_template_custom" {
  depends_on = [null_resource.pagopaprintit_component_template_package]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopaprintit_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopaprintit_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "pagopaprintit_index_template" {
  depends_on = [null_resource.pagopaprintit_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.pagopaprintit_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopaprintit_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopaprintit_data_stream_rollover" {
  depends_on = [null_resource.pagopaprintit_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.pagopaprintit_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopaprintit_kibana_data_view" {
  depends_on = [null_resource.printit_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.printit_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopaprintit_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
