locals {

  action_groups_default = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]

  # Enabled alert on production after deploy
  action_groups = var.env_short == "p" ? concat(local.action_groups_default, [data.azurerm_monitor_action_group.opsgenie[0].id]) : local.action_groups_default

  # SEV3 -> No Opsgenie alert
  action_groups_sev3 = var.env_short == "p" ? concat(local.action_groups_default) : local.action_groups_default


  api_fdr_nodo_auth_alerts = [
    // Nodo per PA WS (AUTH)
    {
      operationId_s : "6352c3bcc257810f183b398b",
      primitiva : "nodoChiediElencoFlussiRendicontazione",
      sub_service : "nodo-per-pa"
    },
    {
      operationId_s : "6352c3bcc257810f183b398c",
      primitiva : "nodoChiediFlussoRendicontazione",
      sub_service : "nodo-per-pa"
    },
    // Nodo per PSP WS (AUTH)
    {
      operationId_s : "6352c3bdc257810f183b399c",
      primitiva : "nodoInviaFlussoRendicontazione",
      sub_service : "nodo-per-psp"
    }
  ]

  api_fdr_nodo_alerts = [
    // Nodo per PA WS
    {
      operationId_s : "6218976195aa0303ccfcf901",
      primitiva : "nodoChiediElencoFlussiRendicontazione",
      sub_service : "nodo-per-pa"
    },
    {
      operationId_s : "6218976195aa0303ccfcf902",
      primitiva : "nodoChiediFlussoRendicontazione",
      sub_service : "nodo-per-pa"
    },
    // Nodo per PSP WS
    {
      operationId_s : "61e9630cb78e981290d7c74c",
      primitiva : "nodoInviaFlussoRendicontazione",
      sub_service : "nodo-per-psp"
    }
  ]
}

