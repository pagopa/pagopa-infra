#################################### [FDR] ####################################
locals {
  ## space
  pagopafdr_space_name = "fdr"
  pagopafdr_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/space.json", {
      name  = "${local.pagopafdr_space_name}"
    }), "\""), "\""), "'", "'\\''")

  ## fdr
  pagopafdr_key = "pagopafdr"

  pagopafdr_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/log-template/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  pagopafdr_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
      name  = local.pagopafdr_key
    }), "\""), "\""), "'", "'\\''")
  pagopafdr_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
      name  = local.pagopafdr_key
    }), "\""), "\""), "'", "'\\''")
  pagopafdr_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
      name  = local.pagopafdr_key
    }), "\""), "\""), "'", "'\\''")
  pagopafdr_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
      name     = local.pagopafdr_key
     component_template_package     = "${local.pagopafdr_key}@package"
      component_template_custom     = "${local.pagopafdr_key}@custom"
    }), "\""), "\""), "'", "'\\''")

  
  pagopafdr_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
      name  = local.pagopafdr_key
    }), "\""), "\""), "'", "'\\''")
}

## space
resource "null_resource" "pagopafdr_kibana_space" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdr_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

## fdr
resource "null_resource" "pagopafdr_ingest_pipeline" {
  depends_on = [null_resource.pagopafdr_kibana_space]

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
  depends_on = [null_resource.pagopafdr_ingest_pipeline]

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

resource "null_resource" "pagopafdr_component_template_package" {
  depends_on = [null_resource.pagopafdr_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopafdr_key}@package" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdr_component_template_package}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdr_component_template_custom" {
  depends_on = [null_resource.pagopafdr_component_template_package]

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
  depends_on = [null_resource.pagopafdr_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.pagopafdr_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdr_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
