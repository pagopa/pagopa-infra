locals {
  grouped_operation_sets = {
    node_for_io_auth = var.env_short != "p" ? [] : [
      // Node for IO WS (AUTH)
      {
        operationId_s = "63b6e2da2a92e811a8f338ec",
        primitiva     = "activateIOPayment",
        sub_service   = "nodo-auth/node-for-io",
      }
    ]

    node_for_io = var.env_short != "p" ? [] : [
      {
        operationId_s = "61dedb1eea7c4a07cc7d47b8",
        primitiva     = "activateIOPaymentReq",
        sub_service   = "nodo/node-for-io",
      },
    ]

    nodo_per_pa_auth = var.env_short != "p" ? [] : [
      {
        operationId_s = "63e5d8212a92e80448d38dfd",
        primitiva     = "nodoChiediStatoRPT",
        sub_service   = "nodo-auth/nodo-per-pa",
      },
      {
        operationId_s = "63e5d8212a92e80448d38dfe",
        primitiva     = "nodoChiediListaPendentiRPT",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s = "63e5d8212a92e80448d38dff",
        primitiva     = "nodoInviaRPT",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s = "63e5d8212a92e80448d38e00",
        primitiva     = "nodoInviaCarrelloRPT",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s = "63e5d8212a92e80448d38e02",
        primitiva     = "nodoChiediInformativaPSP",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s = "63e5d8212a92e80448d38e03",
        primitiva     = "nodoPAChiediInformativaPA",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s = "63e5d8212a92e80448d38e04",
        primitiva     = "nodoChiediElencoQuadraturePA",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s = "63e5d8212a92e80448d38e05",
        primitiva     = "nodoChiediQuadraturaPA",
        sub_service   = "nodo-per-pa",
      },
      // Nodo per PSP Richiesta Avvisi WS (AUTH)
      {
        operationId_s = "63b6e2da2a92e811a8f338ed",
        primitiva     = "nodoChiediNumeroAvviso",
        sub_service   = "nodo-per-psp-richiesta-avvisi",
      },
      {
        operationId_s = "63b6e2da2a92e811a8f338ee",
        primitiva     = "nodoChiediCatalogoServizi",
        sub_service   = "nodo-per-psp-richiesta-avvisi",
      },
      //  Nodo per PA WS (AUTH)
      {
        operationId_s : "63b6e2da2a92e811a8f338f8",
        primitiva : "nodoChiediElencoFlussiRendicontazione",
        sub_service : "nodo-per-pa",
        response_time : 20000
      },
      {
        operationId_s : "63b6e2da2a92e811a8f338f9",
        primitiva : "nodoChiediFlussoRendicontazione",
        sub_service : "nodo-per-pa",
      },
    ]

    nodo_per_pa = var.env_short != "p" ? [] : [
      // nodo-per-pa
      {
        operationId_s = "62189aea2a92e81fa4f15ec4",
        primitiva     = "nodoChiediStatoRPT",
        sub_service   = "nodo/nodo-per-pa",
      },
      {
        operationId_s = "62189aea2a92e81fa4f15ec5",
        primitiva     = "nodoChiediListaPendentiRPT",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s = "62189aea2a92e81fa4f15ec6",
        primitiva     = "nodoInviaRPT",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s = "62189aea2a92e81fa4f15ec7",
        primitiva     = "nodoInviaCarrelloRPT",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s = "62189aea2a92e81fa4f15ec8",
        primitiva     = "nodoChiediCopiaRT",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s = "62189aea2a92e81fa4f15ec9",
        primitiva     = "nodoChiediInformativaPSP",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s = "62189aea2a92e81fa4f15eca",
        primitiva     = "nodoPAChiediInformativaPA",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s = "62189aea2a92e81fa4f15ecb",
        primitiva     = "nodoChiediElencoQuadraturePA",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s = "62189aea2a92e81fa4f15ecc",
        primitiva     = "nodoChiediQuadraturaPA",
        sub_service   = "nodo-per-pa",
      },
      {
        operationId_s : "61e9633dea7c4a07cc7d480d",
        primitiva : "nodoChiediElencoFlussiRendicontazione",
        sub_service : "nodo-per-pa",
        response_time : 20000
      },
      {
        operationId_s : "61e9633dea7c4a07cc7d480e",
        primitiva : "nodoChiediFlussoRendicontazione",
        sub_service : "nodo-per-pa",
      },
    ]

    nodo_per_psp_auth = var.env_short != "p" ? [] : [
      // Nodo per PSP WS (AUTH)
      {
        operationId_s = "63b6e2da2a92e811a8f338fb",
        primitiva     = "nodoVerificaRPT",
        sub_service   = "nodo-auth/nodo-per-psp",
      },
      {
        operationId_s = "63b6e2da2a92e811a8f338fc",
        primitiva     = "nodoAttivaRPT",
        sub_service   = "nodo-per-psp",
      },
      {
        operationId_s = "63b6e2da2a92e811a8f338fd",
        primitiva     = "nodoInviaRT",
        sub_service   = "nodo-per-psp",
      },
      {
        operationId_s = "63b6e2da2a92e811a8f338fe",
        primitiva     = "nodoChiediInformativaPA",
        sub_service   = "nodo-per-psp",
      },
      {
        operationId_s = "63b6e2da2a92e811a8f338ff",
        primitiva     = "nodoChiediTemplateInformativaPSP",
        sub_service   = "nodo-per-psp",
      },
      {
        operationId_s = "63b6e2da2a92e811a8f33900",
        primitiva     = "nodoChiediElencoQuadraturePSP",
        sub_service   = "nodo-per-psp",
      },
      {
        operationId_s : "63b6e2da2a92e811a8f33901",
        primitiva : "nodoInviaFlussoRendicontazione",
        sub_service : "nodo-per-psp",
        response_time : 20000
      },
    ]

    nodo_per_psp = var.env_short != "p" ? [] : [
      // nodo-per-psp
      {
        operationId_s = "61dedafb2a92e81a0c7a58f5",
        primitiva     = "nodoVerificaRPT",
        sub_service   = "nodo/nodo-per-psp",
      },
      {
        operationId_s = "61dedafc2a92e81a0c7a58f6",
        primitiva     = "nodoAttivaRPT",
        sub_service   = "nodo-per-psp",
      },
      {
        operationId_s = "6217ba1b2a92e81fa4f15e77",
        primitiva     = "nodoInviaRT",
        sub_service   = "nodo-per-psp",
      },
      {
        operationId_s = "6217ba1b2a92e81fa4f15e78",
        primitiva     = "nodoChiediInformativaPA",
        sub_service   = "nodo-per-psp",
      },
      {
        operationId_s = "6217ba1b2a92e81fa4f15e79",
        primitiva     = "nodoChiediTemplateInformativaPSP",
        sub_service   = "nodo-per-psp",
      },
      {
        operationId_s = "6217ba1b2a92e81fa4f15e7a",
        primitiva     = "nodoChiediElencoQuadraturePSP",
        sub_service   = "nodo-per-psp",
      },
      // nodo-per-psp-richiesta-avvisi
      {
        operationId_s = "6217ba1a2a92e81fa4f15e75",
        primitiva     = "nodoChiediNumeroAvviso",
        sub_service   = "nodo-per-psp-richiesta-avvisi",
        response_time = 20000
      },
      {
        operationId_s = "6217ba1b2a92e81fa4f15e76",
        primitiva     = "nodoChiediCatalogoServizi",
        sub_service   = "nodo-per-psp-richiesta-avvisi",
      },
      {
        operationId_s : "61e9633eea7c4a07cc7d4811",
        primitiva : "nodoInviaFlussoRendicontazione",
        sub_service : "nodo-per-psp",
        response_time : 20000
      }
    ]

    node_for_psp_auth = var.env_short != "p" ? [] : [
      // Node for PSP WS (NM3) (AUTH)
      {
        operationId_s = "63b6e2daea7c4a25440fda9f",
        primitiva     = "verifyPaymentNotice",
        sub_service   = "nodo-auth/node-for-psp",
      },
      {
        operationId_s = "63b6e2daea7c4a25440fdaa0",
        primitiva     = "activatePaymentNotice",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "63b6e2daea7c4a25440fdaa1",
        primitiva     = "sendPaymentOutcome",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "63b6e2daea7c4a25440fdaa2",
        primitiva     = "verificaBollettino",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "63b6e2daea7c4a25440fdaa3",
        primitiva     = "demandPaymentNotice",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "63b6e2daea7c4a25440fdaa4",
        primitiva     = "nodoChiediCatalogoServiziV2",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "63b6e2daea7c4a25440fdaa5",
        primitiva     = "activatePaymentNoticeV2",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "63b6e2daea7c4a25440fdaa6",
        primitiva     = "sendPaymentOutcomeV2",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "63ff4f22aca2fd18dcc4a6f8",
        primitiva     = "nodoChiediInformativaPA",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "63ff4f22aca2fd18dcc4a6f9",
        primitiva     = "nodoChiediTemplateInformativaPSP",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s : "63ff4f22aca2fd18dcc4a6f7",
        primitiva : "nodoInviaFlussoRendicontazione",
        sub_service : "node-for-psp",
      },
    ]

    node_for_psp = var.env_short != "p" ? [] : [
      // node-for-psp
      {
        operationId_s = "61dedafc2a92e81a0c7a58fb",
        primitiva     = "verifyPaymentNotice",
        sub_service   = "nodo/node-for-psp",
      },
      {
        operationId_s = "61dedafc2a92e81a0c7a58fc",
        primitiva     = "activatePaymentNotice",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "61dedafc2a92e81a0c7a58fd",
        primitiva     = "sendPaymentOutcome",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "61dedafc2a92e81a0c7a58fe",
        primitiva     = "verificaBollettino",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "62bb23bdea7c4a0f183fc065",
        primitiva     = "demandPaymentNotice",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "62bb23bdea7c4a0f183fc066",
        primitiva     = "nodoChiediCatalogoServiziV2",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "63c559672a92e811a8f33a00",
        primitiva     = "activatePaymentNoticeV2",
        sub_service   = "node-for-psp",
      },
      {
        operationId_s = "63c559672a92e811a8f33a01",
        primitiva     = "sendPaymentOutcomeV2",
        sub_service   = "node-for-psp",
      },
    ]

    nodo_for_pa_auth = var.env_short != "p" ? [] : [
      // Node for PA WS (AUTH)
      {
        operationId_s : "63ff73adea7c4a1860530e3a",
        primitiva : "nodoChiediElencoFlussiRendicontazione",
        sub_service : "nodo-auth/node-for-pa",
      },
      {
        operationId_s : "63ff73adea7c4a1860530e3b",
        primitiva : "nodoChiediFlussoRendicontazione",
        sub_service : "nodo-auth/node-for-pa",
      },
    ]

    node_for_ecommerce_auth = var.env_short != "p" ? [] : [
      // Node for eCommerce API(AUTH)
      {
        operationId_s : "checkPosition",
        primitiva : "checkPosition",
        sub_service : "nodo-auth/node-for-ecommerce",
      },
      {
        operationId_s : "closePaymentV2",
        primitiva : "closePaymentV2",
        sub_service : "nodo-auth/node-for-ecommerce",
      },
    ]
  }

  formatted_operation_data = var.env_short == "p" ? {
    for key, ops in local.grouped_operation_sets : key => {
      sub_service = ops[0].sub_service
      formatted_operations = join(",\n  ", [
        for op in ops : "\"${op.operationId_s}\", \"${op.primitiva}\""
      ])
    }
  } : {}

  error_fault_code = "('${join("', '", ["PPT_AUTENTICAZIONE", "PPT_SYSTEM_ERROR", "PPT_ERRORE_IDEMPOTENZA"])}')"

  // Nodo SOAP path
  nodo_soap_path = "/nodo/webservices/input"
  // Nodo SOAP path short
  nodo_soap_path_short = "/webservices/input"

  // PagoPA Nodo ingress
  pagopa_nodo_ingress = "https://weuprod.nodo.internal.platform.pagopa.it"

  # Default alert action groups: slack channel and email
  action_groups_default = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
  # If production and severity is higher than severity 3, the alert is forwarder to opsgenie action group
  action_groups = var.env_short == "p" ? concat(local.action_groups_default, [data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]) : local.action_groups_default
  # In case of alert with severity SEV3 it isn't forwarder to opsgenie, but only on slack channel and email
  action_groups_sev3 = var.env_short == "p" ? concat(local.action_groups_default) : local.action_groups_default
}
