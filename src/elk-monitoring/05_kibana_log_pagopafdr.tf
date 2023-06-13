#################################### [FDR] ####################################
locals {
  ## space
  fdr_space_name = "fdr"
  fdr_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/space.json", {
    name = "${local.fdr_space_name}"
  }), "\""), "\""), "'", "'\\''")

  ## fdr-nodo
  pagopafdrnodo_key = "pagopafdrnodo"

  pagopafdrnodo_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/fdr/${local.pagopafdrnodo_key}/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  pagopafdrnodo_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name = local.pagopafdrnodo_key,
    managed = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  pagopafdrnodo_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
    name = local.pagopafdrnodo_key
  }), "\""), "\""), "'", "'\\''")
  pagopafdrnodo_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
    name = local.pagopafdrnodo_key
  }), "\""), "\""), "'", "'\\''")
  pagopafdrnodo_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
    name                       = local.pagopafdrnodo_key
    component_template_package = "${local.pagopafdrnodo_key}@package"
    component_template_custom  = "${local.pagopafdrnodo_key}@custom"
  }), "\""), "\""), "'", "'\\''")


  pagopafdrnodo_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
    name = local.pagopafdrnodo_key
  }), "\""), "\""), "'", "'\\''")

  ## fdr-nodo-cron
  pagopafdrnodocron_key = "pagopafdrnodocron"

  pagopafdrnodocron_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/fdr/${local.pagopafdrnodocron_key}/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  pagopafdrnodocron_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name = local.pagopafdrnodocron_key,
    managed = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  pagopafdrnodocron_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
    name = local.pagopafdrnodocron_key
  }), "\""), "\""), "'", "'\\''")
  pagopafdrnodocron_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
    name = local.pagopafdrnodocron_key
  }), "\""), "\""), "'", "'\\''")
  pagopafdrnodocron_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
    name                       = local.pagopafdrnodocron_key
    component_template_package = "${local.pagopafdrnodocron_key}@package"
    component_template_custom  = "${local.pagopafdrnodocron_key}@custom"
  }), "\""), "\""), "'", "'\\''")


  pagopafdrnodocron_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
    name = local.pagopafdrnodocron_key
  }), "\""), "\""), "'", "'\\''")

  ## fdr
  pagopafdr_key = "pagopafdr"

  pagopafdr_ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/log-template/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")
  pagopafdr_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name = local.pagopafdr_key,
    managed = false,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  pagopafdr_component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
    name = local.pagopafdr_key
  }), "\""), "\""), "'", "'\\''")
  pagopafdr_component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
    name = local.pagopafdr_key
  }), "\""), "\""), "'", "'\\''")
  pagopafdr_index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
    name                       = local.pagopafdr_key
    component_template_package = "${local.pagopafdr_key}@package"
    component_template_custom  = "${local.pagopafdr_key}@custom"
  }), "\""), "\""), "'", "'\\''")


  pagopafdr_data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/data-view.json", {
    name = local.pagopafdr_key
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

## fdr-nodo
resource "null_resource" "pagopafdrnodo_ingest_pipeline" {
  depends_on = [null_resource.fdr_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.pagopafdrnodo_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdrnodo_ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdrnodo_ilm_policy" {
  depends_on = [null_resource.pagopafdrnodo_ingest_pipeline,null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.pagopafdrnodo_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdrnodo_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdrnodo_component_template_package" {
  depends_on = [null_resource.pagopafdrnodo_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopafdrnodo_key}@package" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdrnodo_component_template_package}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdrnodo_component_template_custom" {
  depends_on = [null_resource.pagopafdrnodo_component_template_package]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopafdrnodo_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdrnodo_component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }

}

resource "null_resource" "pagopafdrnodo_index_template" {
  depends_on = [null_resource.pagopafdrnodo_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.pagopafdrnodo_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdrnodo_index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdrnodo_data_stream_rollover" {
  depends_on = [null_resource.pagopafdrnodo_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-${local.pagopafdrnodo_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}



resource "null_resource" "pagopafdrnodo_kibana_data_view" {
  depends_on = [null_resource.fdr_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.fdr_space_name}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdrnodo_data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

# ## fdr-nodo-cron
# resource "null_resource" "pagopafdrnodocron_ingest_pipeline" {
#   depends_on = [null_resource.fdr_kibana_space]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.pagopafdrnodocron_key}" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${local.pagopafdrnodocron_ingest_pipeline}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "pagopafdrnodocron_ilm_policy" {
#   depends_on = [null_resource.pagopafdrnodocron_ingest_pipeline,null_resource.snapshot_policy]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.pagopafdrnodocron_key}" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${local.pagopafdrnodocron_ilm_policy}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "pagopafdrnodocron_component_template_package" {
#   depends_on = [null_resource.pagopafdrnodocron_ilm_policy]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopafdrnodocron_key}@package" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${local.pagopafdrnodocron_component_template_package}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "pagopafdrnodocron_component_template_custom" {
#   depends_on = [null_resource.pagopafdrnodocron_component_template_package]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopafdrnodocron_key}@custom" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${local.pagopafdrnodocron_component_template_custom}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }

# }

# resource "null_resource" "pagopafdrnodocron_index_template" {
#   depends_on = [null_resource.pagopafdrnodocron_component_template_custom]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_index_template/${local.pagopafdrnodocron_key}" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${local.pagopafdrnodocron_index_template}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "pagopafdrnodocron_data_stream_rollover" {
#   depends_on = [null_resource.pagopafdrnodocron_index_template]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X POST "${local.elastic_url}/logs-${local.pagopafdrnodocron_key}-default/_rollover/" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }



# resource "null_resource" "pagopafdrnodocron_kibana_data_view" {
#   depends_on = [null_resource.fdr_kibana_space]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X POST "${local.kibana_url}/s/${local.fdr_space_name}/api/data_views/data_view" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${local.pagopafdrnodocron_data_view}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# ## fdr
# resource "null_resource" "pagopafdr_ingest_pipeline" {
#   depends_on = [null_resource.fdr_kibana_space]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.pagopafdr_key}" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${local.pagopafdr_ingest_pipeline}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "pagopafdr_ilm_policy" {
#   depends_on = [null_resource.pagopafdr_ingest_pipeline,null_resource.snapshot_policy]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.pagopafdr_key}" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${local.pagopafdr_ilm_policy}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "pagopafdr_component_template_package" {
#   depends_on = [null_resource.pagopafdr_ilm_policy]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopafdr_key}@package" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${local.pagopafdr_component_template_package}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "pagopafdr_component_template_custom" {
#   depends_on = [null_resource.pagopafdr_component_template_package]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_component_template/${local.pagopafdr_key}@custom" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${local.pagopafdr_component_template_custom}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }

# }

# resource "null_resource" "pagopafdr_index_template" {
#   depends_on = [null_resource.pagopafdr_component_template_custom]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_index_template/${local.pagopafdr_key}" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${local.pagopafdr_index_template}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "pagopafdr_data_stream_rollover" {
#   depends_on = [null_resource.pagopafdr_index_template]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X POST "${local.elastic_url}/logs-${local.pagopafdr_key}-default/_rollover/" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }



# resource "null_resource" "pagopafdr_kibana_data_view" {
#   depends_on = [null_resource.fdr_kibana_space]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X POST "${local.kibana_url}/s/${local.fdr_space_name}/api/data_views/data_view" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${local.pagopafdr_data_view}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }
