#################################### [NDP] ####################################
locals {

  ## query
  query_path = "${path.module}/ndp/${local.ndp_nodo_key}/query/*.ndjson"

  ## space
  ndp_space_name = "ndp"
  ndp_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/space.json", {
    name = "${local.ndp_space_name}"
  }), "\""), "\""), "'", "'\\''")

  ## nodo
  ndp_nodo_key = "nodo"

  ndp_nodo_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/ndp/${local.ndp_nodo_key}/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  ndp_nodo_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name        = local.ndp_nodo_key,
    managed     = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  ndp_nodo_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
    name = local.ndp_nodo_key
  }), "\""), "\""), "'", "'\\''")
  ndp_nodo_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
    name = local.ndp_nodo_key
  }), "\""), "\""), "'", "'\\''")
  ndp_nodo_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
    name                       = local.ndp_nodo_key
    component_template_package = "${local.ndp_nodo_key}@package"
    component_template_custom  = "${local.ndp_nodo_key}@custom"
  }), "\""), "\""), "'", "'\\''")

  ndp_nodo_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
    name = local.ndp_nodo_key
  }), "\""), "\""), "'", "'\\''")

  ## nodoreplica
  ndp_nodoreplica_key = "nodoreplica"

  ndp_nodoreplica_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/ndp/${local.ndp_nodoreplica_key}/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  ndp_nodoreplica_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name        = local.ndp_nodoreplica_key,
    managed     = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  ndp_nodoreplica_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
    name = local.ndp_nodoreplica_key
  }), "\""), "\""), "'", "'\\''")
  ndp_nodoreplica_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
    name = local.ndp_nodoreplica_key
  }), "\""), "\""), "'", "'\\''")
  ndp_nodoreplica_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
    name                       = local.ndp_nodoreplica_key
    component_template_package = "${local.ndp_nodoreplica_key}@package"
    component_template_custom  = "${local.ndp_nodoreplica_key}@custom"
  }), "\""), "\""), "'", "'\\''")


  ndp_nodoreplica_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
    name = local.ndp_nodoreplica_key
  }), "\""), "\""), "'", "'\\''")

  ## nodocron
  ndp_nodocron_key = "nodocron"

  ndp_nodocron_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/ndp/${local.ndp_nodocron_key}/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  ndp_nodocron_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name        = local.ndp_nodocron_key,
    managed     = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  ndp_nodocron_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
    name = local.ndp_nodocron_key
  }), "\""), "\""), "'", "'\\''")
  ndp_nodocron_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
    name = local.ndp_nodocron_key
  }), "\""), "\""), "'", "'\\''")
  ndp_nodocron_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
    name                       = local.ndp_nodocron_key
    component_template_package = "${local.ndp_nodocron_key}@package"
    component_template_custom  = "${local.ndp_nodocron_key}@custom"
  }), "\""), "\""), "'", "'\\''")


  ndp_nodocron_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
    name = local.ndp_nodocron_key
  }), "\""), "\""), "'", "'\\''")

  ## nodocronreplica
  ndp_nodocronreplica_key = "nodocronreplica"

  ndp_nodocronreplica_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/ndp/${local.ndp_nodocronreplica_key}/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  ndp_nodocronreplica_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name        = local.ndp_nodocronreplica_key,
    managed     = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  ndp_nodocronreplica_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
    name = local.ndp_nodocronreplica_key
  }), "\""), "\""), "'", "'\\''")
  ndp_nodocronreplica_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
    name = local.ndp_nodocronreplica_key
  }), "\""), "\""), "'", "'\\''")
  ndp_nodocronreplica_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
    name                       = local.ndp_nodocronreplica_key
    component_template_package = "${local.ndp_nodocronreplica_key}@package"
    component_template_custom  = "${local.ndp_nodocronreplica_key}@custom"
  }), "\""), "\""), "'", "'\\''")


  ndp_nodocronreplica_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
    name = local.ndp_nodocronreplica_key
  }), "\""), "\""), "'", "'\\''")

  ## pagopawebbo
  ndp_pagopawebbo_key = "pagopawebbo"

  ndp_pagopawebbo_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/ndp/${local.ndp_pagopawebbo_key}/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  ndp_pagopawebbo_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name        = local.ndp_pagopawebbo_key,
    managed     = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  ndp_pagopawebbo_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
    name = local.ndp_pagopawebbo_key
  }), "\""), "\""), "'", "'\\''")
  ndp_pagopawebbo_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
    name = local.ndp_pagopawebbo_key
  }), "\""), "\""), "'", "'\\''")
  ndp_pagopawebbo_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
    name                       = local.ndp_pagopawebbo_key
    component_template_package = "${local.ndp_pagopawebbo_key}@package"
    component_template_custom  = "${local.ndp_pagopawebbo_key}@custom"
  }), "\""), "\""), "'", "'\\''")


  ndp_pagopawebbo_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
    name = local.ndp_pagopawebbo_key
  }), "\""), "\""), "'", "'\\''")

  ## pagopawfespwfesp
  ndp_pagopawfespwfesp_key = "pagopawfespwfesp"

  ndp_pagopawfespwfesp_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/ndp/${local.ndp_pagopawfespwfesp_key}/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  ndp_pagopawfespwfesp_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name        = local.ndp_pagopawfespwfesp_key,
    managed     = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  ndp_pagopawfespwfesp_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
    name = local.ndp_pagopawfespwfesp_key
  }), "\""), "\""), "'", "'\\''")
  ndp_pagopawfespwfesp_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
    name = local.ndp_pagopawfespwfesp_key
  }), "\""), "\""), "'", "'\\''")
  ndp_pagopawfespwfesp_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
    name                       = local.ndp_pagopawfespwfesp_key
    component_template_package = "${local.ndp_pagopawfespwfesp_key}@package"
    component_template_custom  = "${local.ndp_pagopawfespwfesp_key}@custom"
  }), "\""), "\""), "'", "'\\''")


  ndp_pagopawfespwfesp_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
    name = local.ndp_pagopawfespwfesp_key
  }), "\""), "\""), "'", "'\\''")

  ## wispconverter
  ndp_wispconverter_key = "wispconverter"

  ndp_wispconverter_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/log-template/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  ndp_wispconverter_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name        = local.ndp_wispconverter_key,
    managed     = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  ndp_wispconverter_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
    name = local.ndp_wispconverter_key
  }), "\""), "\""), "'", "'\\''")
  ndp_wispconverter_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
    name = local.ndp_wispconverter_key
  }), "\""), "\""), "'", "'\\''")
  ndp_wispconverter_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
    name                       = local.ndp_wispconverter_key
    component_template_package = "${local.ndp_wispconverter_key}@package"
    component_template_custom  = "${local.ndp_wispconverter_key}@custom"
  }), "\""), "\""), "'", "'\\''")
  ndp_wispconverter_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
    name = local.ndp_wispconverter_key
  }), "\""), "\""), "'", "'\\''")

}

## space
resource "null_resource" "ndp_kibana_space" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

## nodo
resource "null_resource" "ndp_nodo_ingest_pipeline" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.ndp_nodo_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodo_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodo_ilm_policy" {
  depends_on = [null_resource.ndp_nodo_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.ndp_nodo_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodo_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodo_component_template_package" {
  depends_on = [null_resource.ndp_nodo_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_nodo_key}@package" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodo_component_template_package}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodo_component_template_custom" {
  depends_on = [null_resource.ndp_nodo_component_template_package]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_nodo_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodo_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "ndp_nodo_index_template" {
  depends_on = [null_resource.ndp_nodo_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.ndp_nodo_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodo_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodo_data_stream_rollover" {
  depends_on = [null_resource.ndp_nodo_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.ndp_nodo_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodo_kibana_data_view" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.ndp_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodo_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

## nodoreplica
resource "null_resource" "ndp_nodoreplica_ingest_pipeline" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.ndp_nodoreplica_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodoreplica_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodoreplica_ilm_policy" {
  depends_on = [null_resource.ndp_nodoreplica_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.ndp_nodoreplica_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodoreplica_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodoreplica_component_template_package" {
  depends_on = [null_resource.ndp_nodoreplica_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_nodoreplica_key}@package" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodoreplica_component_template_package}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodoreplica_component_template_custom" {
  depends_on = [null_resource.ndp_nodoreplica_component_template_package]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_nodoreplica_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodoreplica_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "ndp_nodoreplica_index_template" {
  depends_on = [null_resource.ndp_nodoreplica_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.ndp_nodoreplica_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodoreplica_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodoreplica_data_stream_rollover" {
  depends_on = [null_resource.ndp_nodoreplica_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.ndp_nodoreplica_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodoreplica_kibana_data_view" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.ndp_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodoreplica_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

## nodocron
resource "null_resource" "ndp_nodocron_ingest_pipeline" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.ndp_nodocron_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodocron_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodocron_ilm_policy" {
  depends_on = [null_resource.ndp_nodocron_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.ndp_nodocron_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodocron_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodocron_component_template_package" {
  depends_on = [null_resource.ndp_nodocron_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_nodocron_key}@package" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodocron_component_template_package}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodocron_component_template_custom" {
  depends_on = [null_resource.ndp_nodocron_component_template_package]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_nodocron_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodocron_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "ndp_nodocron_index_template" {
  depends_on = [null_resource.ndp_nodocron_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.ndp_nodocron_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodocron_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodocron_data_stream_rollover" {
  depends_on = [null_resource.ndp_nodocron_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.ndp_nodocron_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodocron_kibana_data_view" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.ndp_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodocron_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

## nodocronreplica
resource "null_resource" "ndp_nodocronreplica_ingest_pipeline" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.ndp_nodocronreplica_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodocronreplica_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodocronreplica_ilm_policy" {
  depends_on = [null_resource.ndp_nodocronreplica_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.ndp_nodocronreplica_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodocronreplica_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodocronreplica_component_template_package" {
  depends_on = [null_resource.ndp_nodocronreplica_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_nodocronreplica_key}@package" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodocronreplica_component_template_package}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodocronreplica_component_template_custom" {
  depends_on = [null_resource.ndp_nodocronreplica_component_template_package]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_nodocronreplica_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodocronreplica_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "ndp_nodocronreplica_index_template" {
  depends_on = [null_resource.ndp_nodocronreplica_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.ndp_nodocronreplica_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodocronreplica_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodocronreplica_data_stream_rollover" {
  depends_on = [null_resource.ndp_nodocronreplica_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.ndp_nodocronreplica_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

## query RE json log
resource "null_resource" "ndp_nodocronreplica_kibana_data_view" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.ndp_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_nodocronreplica_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

## query RE for nodo
resource "null_resource" "ndp_nodo_upload_query" {
  depends_on = [null_resource.ndp_nodo_data_stream_rollover]

  triggers = {
    always_run = "${timestamp()}"
  }

  for_each = fileset(path.module, local.query_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.ndp_space_name}/api/saved_objects/_import?overwrite=true" \
      -H 'kbn-xsrf: true' \
      --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

## pagopawebbo
resource "null_resource" "ndp_pagopawebbo_ingest_pipeline" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.ndp_pagopawebbo_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawebbo_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_pagopawebbo_ilm_policy" {
  depends_on = [null_resource.ndp_pagopawebbo_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.ndp_pagopawebbo_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawebbo_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_pagopawebbo_component_template_package" {
  depends_on = [null_resource.ndp_pagopawebbo_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_pagopawebbo_key}@package" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawebbo_component_template_package}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_pagopawebbo_component_template_custom" {
  depends_on = [null_resource.ndp_pagopawebbo_component_template_package]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_pagopawebbo_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawebbo_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "ndp_pagopawebbo_index_template" {
  depends_on = [null_resource.ndp_pagopawebbo_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.ndp_pagopawebbo_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawebbo_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_pagopawebbo_data_stream_rollover" {
  depends_on = [null_resource.ndp_pagopawebbo_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.ndp_pagopawebbo_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_pagopawebbo_kibana_data_view" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.ndp_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawebbo_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

## pagopawfespwfesp
resource "null_resource" "ndp_pagopawfespwfesp_ingest_pipeline" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.ndp_pagopawfespwfesp_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawfespwfesp_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_pagopawfespwfesp_ilm_policy" {
  depends_on = [null_resource.ndp_pagopawfespwfesp_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.ndp_pagopawfespwfesp_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawfespwfesp_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_pagopawfespwfesp_component_template_package" {
  depends_on = [null_resource.ndp_pagopawfespwfesp_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_pagopawfespwfesp_key}@package" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawfespwfesp_component_template_package}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_pagopawfespwfesp_component_template_custom" {
  depends_on = [null_resource.ndp_pagopawfespwfesp_component_template_package]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_pagopawfespwfesp_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawfespwfesp_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "ndp_pagopawfespwfesp_index_template" {
  depends_on = [null_resource.ndp_pagopawfespwfesp_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.ndp_pagopawfespwfesp_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawfespwfesp_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_pagopawfespwfesp_data_stream_rollover" {
  depends_on = [null_resource.ndp_pagopawfespwfesp_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.ndp_pagopawfespwfesp_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_pagopawfespwfesp_kibana_data_view" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.ndp_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawfespwfesp_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}


## wispconverter
resource "null_resource" "ndp_wispconverter_ingest_pipeline" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.ndp_wispconverter_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_wispconverter_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_wispconverter_ilm_policy" {
  depends_on = [null_resource.ndp_wispconverter_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.ndp_wispconverter_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_wispconverter_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_wispconverter_component_template_package" {
  depends_on = [null_resource.ndp_wispconverter_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_wispconverter_key}@package" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_wispconverter_component_template_package}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_wispconverter_component_template_custom" {
  depends_on = [null_resource.ndp_wispconverter_component_template_package]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.ndp_wispconverter_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_wispconverter_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "ndp_pagopawfespwfesp_index_template" {
  depends_on = [null_resource.ndp_pagopawfespwfesp_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.ndp_pagopawfespwfesp_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawfespwfesp_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_pagopawfespwfesp_data_stream_rollover" {
  depends_on = [null_resource.ndp_pagopawfespwfesp_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.ndp_pagopawfespwfesp_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_pagopawfespwfesp_kibana_data_view" {
  depends_on = [null_resource.ndp_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.ndp_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_pagopawfespwfesp_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
