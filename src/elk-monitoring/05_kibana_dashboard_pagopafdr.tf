#################################### [FDRNODO] ####################################
locals {
  fdrnodo_dashboard_path = "${path.module}/${local.fdr_space_name}/${local.pagopafdrnodo_key}/dashboard/*.ndjson"
  fdr_dashboard_path = "${path.module}/${local.fdr_space_name}/${local.pagopafdr_key}/dashboard/*.ndjson"
}

resource "null_resource" "pagopafdrnodo_upload_dashboard" {
  depends_on = [null_resource.pagopafdrnodo_kibana_data_view]

  triggers = {
    always_run = "${timestamp()}"
  }

  for_each = fileset(path.module, local.fdrnodo_dashboard_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.fdr_space_name}/api/saved_objects/_import?overwrite=true" \
      -H 'kbn-xsrf: true' \
      --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdr_upload_dashboard" {
  depends_on = [null_resource.pagopafdr_kibana_data_view]

  triggers = {
    always_run = "${timestamp()}"
  }

  for_each = fileset(path.module, local.fdr_dashboard_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.fdr_space_name}/api/saved_objects/_import?overwrite=true" \
      -H 'kbn-xsrf: true' \
      --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
