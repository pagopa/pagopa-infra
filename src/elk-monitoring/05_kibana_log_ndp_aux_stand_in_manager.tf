#################################### [NDP-AUX] ####################################
locals {
  ## stand_in_manager
  standInManager_prj = {
    space = "${local.ndpAux_domain.space}"
    project_key = "pagopastandinmanager"
  }

  standInManager_kibana = {
    ingest_pipeline = replace(trimsuffix(trimprefix(file("${path.module}/${local.standInManager_prj.space}/${local.standInManager_prj.project_key}/ingest-pipeline.json"), "\""), "\""), "'", "'\\''")

    ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
      name        = local.standInManager_prj.project_key,
      managed     = false,
      policy_name = local.default_snapshot_policy_key
    }), "\""), "\""), "'", "'\\''")

    component_template_package = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@package.json", {
      name = local.standInManager_prj.project_key
    }), "\""), "\""), "'", "'\\''")

    component_template_custom = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/component@custom.json", {
      name = local.standInManager_prj.project_key
    }), "\""), "\""), "'", "'\\''")

    index_template = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/index-template.json", {
      name                       = local.standInManager_prj.project_key
      component_template_package = "${local.standInManager_prj.project_key}@package"
      component_template_custom  = "${local.standInManager_prj.project_key}@custom"
    }), "\""), "\""), "'", "'\\''")

    data_view = replace(trimsuffix(trimprefix(templatefile("${path.module}/${local.standInManager_prj.space}/data-view.json", {
      name = local.standInManager_prj.project_key
    }), "\""), "\""), "'", "'\\''")
  }

}

# ingest pipeline
resource "null_resource" "ndp_aux_stand_in_manager_ingest_pipeline" {
  depends_on = [null_resource.ndp_aux_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${local.standInManager_prj.project_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.standInManager_kibana.ingest_pipeline}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

# ilm policy
resource "null_resource" "ndp_aux_stand_in_manager_ilm_policy" {
  depends_on = [null_resource.ndp_aux_stand_in_manager_ingest_pipeline, null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.standInManager_prj.project_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.standInManager_kibana.ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

# component template - package
resource "null_resource" "ndp_aux_stand_in_manager_component_template_package" {
  depends_on = [null_resource.ndp_aux_stand_in_manager_ilm_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.standInManager_prj.project_key}@package" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.standInManager_kibana.component_template_package}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

# component template - custom
resource "null_resource" "ndp_aux_stand_in_manager_component_template_custom" {
  depends_on = [null_resource.ndp_aux_stand_in_manager_component_template_package]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${local.standInManager_prj.project_key}@custom" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.standInManager_kibana.component_template_custom}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

# index template
resource "null_resource" "ndp_aux_stand_in_manager_index_template" {
  depends_on = [null_resource.ndp_aux_stand_in_manager_component_template_custom]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${local.standInManager_prj.project_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.standInManager_kibana.index_template}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

# data stream
resource "null_resource" "ndp_aux_stand_in_manager_data_stream_rollover" {
  depends_on = [null_resource.ndp_aux_stand_in_manager_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-apm.app-${local.standInManager_prj.project_key}-default/_rollover/" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

# data view
resource "null_resource" "ndp_aux_stand_in_manager_kibana_data_view" {
  depends_on = [null_resource.ndp_aux_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.standInManager_prj.space}/api/data_views/data_view" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.standInManager_kibana.data_view}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
