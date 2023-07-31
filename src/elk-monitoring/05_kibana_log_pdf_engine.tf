#################################### [PDF ENGINE] ####################################
locals {
  ## space
  shared_space_name = "shared"
  shared_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/space.json", {
    name = "${local.shared_space_name}"
  }), "\""), "\""), "'", "'\\''")

  ## pdf-engine
  pagopapdfengine_key = "pagopapdfengine"

  pagopapdfengine_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/shared/${local.pagopapdfengine_key}/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  pagopapdfengine_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name        = local.pagopapdfengine_key,
    managed     = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  pagopapdfengine_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
    name = local.pagopapdfengine_key
  }), "\""), "\""), "'", "'\\''")
  pagopapdfengine_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
    name = local.pagopapdfengine_key
  }), "\""), "\""), "'", "'\\''")
  pagopapdfengine_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
    name                       = local.pagopapdfengine_key
    component_template_package = "${local.pagopapdfengine_key}@package"
    component_template_custom  = "${local.pagopapdfengine_key}@custom"
  }), "\""), "\""), "'", "'\\''")


  pagopapdfengine_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
    name = local.pagopapdfengine_key
  }), "\""), "\""), "'", "'\\''")

}

## space
resource "null_resource" "shared_kibana_space" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.shared_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

## pdf-engine
resource "null_resource" "pagopapdfengine_ingest_pipeline" {
  depends_on = [null_resource.shared_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.pagopapdfengine_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapdfengine_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapdfengine_ilm_policy" {
  depends_on = [null_resource.pagopapdfengine_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.pagopapdfengine_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapdfengine_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapdfengine_component_template_package" {
  depends_on = [null_resource.pagopapdfengine_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopapdfengine_key}@package" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapdfengine_component_template_package}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapdfengine_component_template_custom" {
  depends_on = [null_resource.pagopapdfengine_component_template_package]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopapdfengine_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapdfengine_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "pagopapdfengine_index_template" {
  depends_on = [null_resource.pagopapdfengine_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.pagopapdfengine_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapdfengine_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopapdfengine_data_stream_rollover" {
  depends_on = [null_resource.pagopapdfengine_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.pagopapdfengine_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}



resource "null_resource" "pagopapdfengine_kibana_data_view" {
  depends_on = [null_resource.shared_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.shared_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopapdfengine_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
