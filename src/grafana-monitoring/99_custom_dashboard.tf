provider "grafana" {
  alias = "cloudinternal"

  url  = azurerm_dashboard_grafana.grafana_dashboard.endpoint
  auth = data.azurerm_key_vault_secret.grafana-key.value
}

locals {
  custom_dashboard_by_file = fileset("${path.module}/env/${var.location_short}-${var.instance}/dashboard/", "**")

  dashboard_folder_map = flatten([
    for rt in local.custom_dashboard_by_file : {
      foldername = dirname(rt)
    }
  ])

  dashboard_file_map = flatten([
    for rt in local.custom_dashboard_by_file : {
      filename = "${dirname(rt)}/${basename(rt)}"

    }
  ])

  # create list of distinct folder
  #
  distinct_folder = toset([
    for item in local.dashboard_folder_map : item.foldername
  ])

}

resource "grafana_folder" "customfolder" {
  provider = grafana.cloudinternal
  for_each = { for subfolder in local.distinct_folder : subfolder => subfolder }

  title = "CUSTOM-${each.key}"
}

resource "grafana_dashboard" "azure_monitor_grafana" {
  provider = grafana.cloudinternal
  for_each = { for i in range(length(local.dashboard_file_map)) : local.dashboard_file_map[i].filename => i }

  config_json = file("${path.module}/env/${var.location_short}-${var.instance}/dashboard/${local.dashboard_file_map[each.value].filename}")

  folder    = grafana_folder.customfolder["${split("/", local.dashboard_file_map[each.value].filename)[0]}"].id
  overwrite = true
}

