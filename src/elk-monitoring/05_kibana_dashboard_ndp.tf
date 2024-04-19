#################################### [NDP] ####################################
locals {
  dashboard_path         = "${path.module}/ndp/${local.ndp_nodo_key}/dashboard/*.ndjson"
  wc_dashboard_path     = "${path.module}/ndp/${local.ndp_wispconverter_key}/dashboard/*.ndjson"
  replica_dashboard_path = var.env_short != "p" ? "${path.module}/ndp/${local.ndp_nodoreplica_key}/dashboard/*.ndjson" : "/FAKE-NO-REPLICA"
  # replica_query_path     = var.env_short != "p" ? "${path.module}/ndp/${local.ndp_nodoreplica_key}/query/*.ndjson" : "/FAKE-NO-REPLICA"
}

resource "null_resource" "ndp_nodo_upload_dashboard" {
  depends_on = [null_resource.ndp_nodo_upload_query]

  triggers = {
    always_run = "${timestamp()}"
  }

  for_each = fileset(path.module, local.dashboard_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.ndp_space_name}/api/saved_objects/_import?overwrite=true" \
      -H 'kbn-xsrf: true' \
      --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodoreplica_upload_dashboard" {
  depends_on = [null_resource.ndp_nodo_upload_query]

  triggers = {
    always_run = "${timestamp()}"
  }

  for_each = fileset(path.module, local.replica_dashboard_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.ndp_space_name}/api/saved_objects/_import?overwrite=true" \
      -H 'kbn-xsrf: true' \
      --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_wispconverter_upload_dashboard" {

  triggers = {
    always_run = "${timestamp()}"
  }

  for_each = fileset(path.module, local.wc_dashboard_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.ndp_space_name}/api/saved_objects/_import?overwrite=true" \
      -H 'kbn-xsrf: true' \
      --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
