#################################### [NDP] ####################################
locals {
  dashboard_path         = var.env_short == "d" || var.env_short == "u" ? "${path.module}/ndp/${local.ndp_nodo_key}/dashboard/*.ndjson" : "${path.module}/ndp/${local.ndp_nodo_key}/dashboard/*.ndjson_trick_for_not_upload"
  replica_dashboard_path = var.env_short == "d" || var.env_short == "u" ? "${path.module}/ndp/${local.ndp_nodoreplica_key}/dashboard/*.ndjson" : "${path.module}/ndp/${local.ndp_nodoreplica_key}/dashboard/*.ndjson_trick_for_not_upload"
  query_path             = var.env_short == "d" || var.env_short == "u" ? "${path.module}/ndp/${local.ndp_nodo_key}/query/*.ndjson" : "${path.module}/ndp/${local.ndp_nodo_key}/query/*.ndjson_trick_for_not_upload"
  replica_query_path     = var.env_short == "d" || var.env_short == "u" ? "${path.module}/ndp/${local.ndp_nodoreplica_key}/query/*.ndjson" : "${path.module}/ndp/${local.ndp_nodoreplica_key}/query/*.ndjson_trick_for_not_upload"
}

resource "null_resource" "ndp_nodo_upload_query" {
  depends_on = [null_resource.ndp_nodo_data_stream_rollover]

  for_each = fileset(path.module, local.query_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodoreplica_upload_query" {
  depends_on = [null_resource.ndp_nodoreplica_data_stream_rollover]

  for_each = fileset(path.module, local.replica_query_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodo_upload_dashboard" {
  depends_on = [null_resource.ndp_nodo_upload_query]

  for_each = fileset(path.module, local.dashboard_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_nodoreplica_upload_dashboard" {
  depends_on = [null_resource.ndp_nodoreplica_upload_query]

  for_each = fileset(path.module, local.replica_dashboard_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
