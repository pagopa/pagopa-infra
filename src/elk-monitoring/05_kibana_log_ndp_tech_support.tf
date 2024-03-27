#################################### [NDP] ####################################
locals {

  ## nodo tech support
  ndp_techsupport_key = "tech-support"

  #  ndp_techsupport_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/ndp/${local.ndp_techsupport_key}/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  ndp_techsupport_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name        = local.ndp_techsupport_key,
    managed     = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  ndp_techsupport_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
    name = local.ndp_techsupport_key
  }), "\""), "\""), "'", "'\\''")
  ndp_techsupport_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
    name = local.ndp_techsupport_key
  }), "\""), "\""), "'", "'\\''")
  ndp_techsupport_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
    name                       = local.ndp_techsupport_key
    component_template_package = "${local.ndp_techsupport_key}@package"
    component_template_custom  = "${local.ndp_techsupport_key}@custom"
  }), "\""), "\""), "'", "'\\''")

  ndp_techsupport_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
    name = local.ndp_techsupport_key
  }), "\""), "\""), "'", "'\\''")

}

#resource "null_resource" "ndp_techsupport_ingest_pipeline" {
#  depends_on = [null_resource.ndp_kibana_space]
#
#  triggers = {
#    always_run = "${timestamp()}"
#  }
#
#  provisioner "local-exec" {
#    command     = <<EOT
#      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.ndp_techsupport_key}" \
#      -H 'kbn-xsrf: true' \
#      -H 'Content-Type: application/json' \
#      -d '${local.ndp_techsupport_ingest_pipeline}'
#    EOT
#    interpreter = ["/bin/bash", "-c"]
#  }
#}

resource "null_resource" "ndp_techsupport_ilm_policy" {
  #  depends_on = [null_resource.ndp_techsupport_ingest_pipeline, null_resource.snapshot_policy]
  depends_on = [null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.ndp_techsupport_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_techsupport_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_techsupport_component_template_package" {
  depends_on = [null_resource.ndp_techsupport_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_techsupport_key}@package" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_techsupport_component_template_package}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_techsupport_component_template_custom" {
  depends_on = [null_resource.ndp_techsupport_component_template_package]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_techsupport_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_techsupport_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "ndp_techsupport_index_template" {
  depends_on = [null_resource.ndp_techsupport_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.ndp_techsupport_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_techsupport_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_techsupport_data_stream_rollover" {
  depends_on = [null_resource.ndp_techsupport_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.ndp_techsupport_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_techsupport_kibana_data_view" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.ndp_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_techsupport_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
