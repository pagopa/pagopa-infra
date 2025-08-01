{
  "properties": {
    "lenses": [
      {
        "order": 0,
        "parts": [
          {
            "position": {
              "x": 0,
              "y": 0,
              "colSpan": 15,
              "rowSpan": 2
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "content": "<span>\n<h1 style=\"font-size:3em;color:green\">Multi-node monitoring dashboard</h1>\n</span>\n<span style=\"font-size:1.2em\">\nThis dashboard contains all information that permits to track down primitives invocation down to an exact applicative instance, in order to better monitor Multi-node infrastructure.\n</span>",
                  "title": "",
                  "subtitle": "",
                  "markdownSource": 1,
                  "markdownUri": ""
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 3,
              "colSpan": 18,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "content": "<h1 style=\"background-color:red;color:white;font-size:2.5em;padding-left: 0.5em\">\nRouting overview\n</h1>\n",
                  "title": "",
                  "subtitle": "",
                  "markdownSource": 1,
                  "markdownUri": ""
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 4,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "101d8a5a-cd26-486c-9654-a11849e484d6",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.63\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        backendUrl_s startswith \"https://weuprod.fdr.internal.platform.pagopa.it\",\n        \"04 FdR-Fase1\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/wisp-soap-converter\",\n        \"05 WISP Dismantling\",\n        (backendUrl_s == \"\"),\n        \"06 no backend: handled by APIM policies\",\n        \"99 unknown\"\n    )                 \n| summarize count() by raw_backend_name, primitive_name\n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Pie",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "Routed Backend",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        backendUrl_s startswith \"https://weuprod.fdr.internal.platform.pagopa.it\",\n        \"04 FdR-Fase1\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/wisp\",\n        \"05 WISP Dismantling\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 unknown\"\n    )\n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
                  "PartTitle": "Routed primitives: Overview - Percentages",
                  "PartSubTitle": "Percentages about all Nodo dei Pagamenti's primitives, grouped by routing backend"
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 4,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "18b6fb5a-5088-4bdb-ae14-5fb921e14e12",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend backend_name = case ( \n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.63\",\n        \"NDP004PROD (Nexi Postgres)\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://weuprod.fdr.internal.platform.pagopa.it\",\n        \"FdR-Fase1\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/wisp-soap-converter\",\n        \"WISP Dismantling\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"handled by APIM\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"no backend: error on APIM (wrong subkey)\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"no backend: error on APIM (\", lastError_reason_s, \")\"),\n        \"no backend: error on APIM (unknown)\"\n    )                   \n//| where backend_name startswith \"error on APIM\" \n//| project backend_name, primitive, backendTime_d, cacheTime_d, responseCode_d\n| summarize count() by backend_name, primitive_name\n| order by backend_name\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "AnalyticsGrid",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "GridColumnsWidth": {
                    "backend_name": "403px",
                    "primitive_name": "482px",
                    "Routed Backend": "259px",
                    "Primitive": "366px",
                    "Count": "90px"
                  },
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        backendUrl_s startswith \"https://weuprod.fdr.internal.platform.pagopa.it\",\n        \"04 FdR-Fase1\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/wisp\",\n        \"05 WISP Dismantling\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 unknown\"\n    )\n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc, primitive_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
                  "PartTitle": "Routed primitives: Overview - Volumes",
                  "PartSubTitle": "Volumes about routing of all Nodo dei Pagamenti's primitives"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 9,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "158b302f-1509-46e0-ac44-74b609417d5d",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.63\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )                 \n| where raw_backend_name != \"99 not needed\"\n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Pie",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "Routed Backend",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )                 \n| where raw_backend_name != \"99 not needed\"\n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
                  "PartTitle": "Routed primitives: On NDP instances - Percentages",
                  "PartSubTitle": "Percentages about primitives routed on NDP instances"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 14,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "135fb154-7be1-47c2-ba8f-186ca0154ab9",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| where backendUrl_s == \"\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"01 OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"02 Error on APIM (wrong subkey)\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"03 Error on APIM (\", lastError_reason_s, \")\"),\n        \"99 unknown\"\n    )                 \n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Outcome']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "AnalyticsGrid",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| where backendUrl_s == \"\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"01 OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"02 Error: Invalid subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"03 Error: \", lastError_reason_s),\n        \"99 unknown\"\n    )                 \n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Outcome']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n| render piechart\n\n",
                  "ControlType": "FrameControlChart",
                  "SpecificChart": "Pie",
                  "PartTitle": "Routed primitives: Managed by APIM policies - Percentages",
                  "PartSubTitle": "Percentages about outcomes of primitives not routed on backend and managed directly by APIM policies",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Outcome",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "LegendOptions": {
                    "isEnabled": true,
                    "position": "Bottom"
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 14,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "03021c2c-2a9b-41a7-bc6a-4e85651291f1",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| where backendUrl_s == \"\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"01 OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"02 Error: Invalid subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"03 Error: \", lastError_reason_s),\n        \"99 unknown\"\n    )                 \n| where raw_backend_name != \"01 OK\" and raw_backend_name !startswith \"02 Error\"\n//| summarize count() by raw_backend_name, primitive_name\n//| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Primitive']=primitive_name, ['Outcome']=backend_name, ['Caused by']=lastError_message_s\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "AnalyticsGrid",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "GridColumnsWidth": {
                    "Primitive": "216px",
                    "Outcome": "227px",
                    "Caused by": "694px",
                    "Error": "209px",
                    "HTTP Status": "118px",
                    "Execution time": "131px",
                    "Status": "82px"
                  },
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| where backendUrl_s == \"\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"01 OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"02 Error: Invalid subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"03 Error: \", lastError_reason_s),\n        \"99 Error: Unknown\"\n    )                 \n| where raw_backend_name != \"01 OK\" and raw_backend_name !startswith \"02 Error\"\n| extend backend_name = substring(raw_backend_name, 10)\n| project \n    ['Primitive']=primitive_name, \n    ['Error']=backend_name, \n    ['Status']=responseCode_d, \n    ['Execution time']=strcat(backendTime_d / 1000, \" sec\"), \n    ['Caused by']=lastError_message_s\n\n",
                  "PartTitle": "Routed primitives: Managed by APIM policies - Error details",
                  "PartSubTitle": "Details about errors of primitives not routed on backend and managed directly by APIM policies"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 20,
              "colSpan": 18,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "content": "<h1 style=\"background-color:red;color:white;font-size:2.5em;padding-left: 0.5em\">\n*verifyPaymentNotice*\n</h1>\n\n",
                  "title": "",
                  "subtitle": "",
                  "markdownSource": 1,
                  "markdownUri": ""
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 21,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "528c49a2-d712-4b05-9590-0ac0310a6f67",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.63\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        backendUrl_s startswith \"https://weuprod.fdr.internal.platform.pagopa.it\",\n        \"04 FdR-Fase1\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/wisp-soap-converter\",\n        \"05 WISP Dismantling\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 no backend: handled by APIM policies\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 no backend: error on APIM (wrong subkey)\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 no backend: error on APIM (\", lastError_reason_s, \")\"),\n        \"09 no backend: error on APIM (unknown)\"\n    )     \n| where primitive startswith \"activatePaymentNotice\" \n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Pie",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "Routed Backend",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 Unknown\"\n    )\n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
                  "ControlType": "FrameControlChart",
                  "PartTitle": "Routed primitives: VerifyPaymentNotice - Percentages",
                  "PartSubTitle": "Percentages about routed verifyPaymentNotice"
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 21,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "1398901e-3eca-448a-a611-3f3159f12202",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend backend_name = case ( \n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.63\",\n        \"NDP004PROD (Nexi Postgres)\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://weuprod.fdr.internal.platform.pagopa.it\",\n        \"FdR-Fase1\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/wisp-soap-converter\",\n        \"WISP Dismantling\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"no backend: handled by APIM policies\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"no backend: error on APIM (wrong subkey)\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"no backend: error on APIM (\", lastError_reason_s, \")\"),\n        \"no backend: error on APIM (unknown)\"\n    )                   \n| where primitive startswith \"activatePaymentNotice\" \n| summarize count() by backend_name, primitive_name\n| order by backend_name\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "AnalyticsGrid",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "GridColumnsWidth": {
                    "Routed Backend": "342.986px",
                    "Primitive": "314px",
                    "Count": "109.007px"
                  },
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend backend_name = case ( \n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.63\",\n        \"NDP004PROD (Nexi Postgres)\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"NDP001PROD PagoPA Postgres\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 Managed by APIM policies: OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 Managed by APIM policies: wrong subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 Managed by APIM policies: \", lastError_reason_s),\n        \"09 Managed by APIM policies: unknown error\"\n    )                   \n| summarize count() by backend_name, primitive_name\n| order by backend_name\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
                  "PartTitle": "Routed primitives: VerifyPaymentNotice - Volumes",
                  "PartSubTitle": "Volumes about routed verifyPaymentNotice"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 26,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "14dac35f-2541-4ab3-af03-bb0d1131df1f",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT1H",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\nrequests\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| join kind=inner (\n    dependencies\n    | project operation_Id, target\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n    by backend_name\n| project backend_name, [\"Total Requests\"]=Total, [\"KO Requests\"]=KO\n| render barchart kind=stacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "StackedBar",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "backend_name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Requests",
                        "type": "long"
                      },
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n| project [\"Backend Name\"]=\"All backends\", [\"Total Responses\"]=Total, [\"OK Responses\"]=Total-KO, [\"KO Responses\"]=KO\n| render barchart kind=unstacked\n\n",
                  "SpecificChart": "UnstackedBar",
                  "PartTitle": "Routed primitives: VerifyPaymentNotice - Error on NDP instances cumulative volumes",
                  "PartSubTitle": "Cumulative volumes about errors on NDP instances for routed verifyPaymentNotice",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Backend Name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Responses",
                        "type": "long"
                      },
                      {
                        "name": "OK Responses",
                        "type": "long"
                      },
                      {
                        "name": "KO Responses",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 26,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "14dac35f-2541-4ab3-af03-bb0d1131df1f",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT1H",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\nrequests\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| join kind=inner (\n    dependencies\n    | project operation_Id, target\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n    by backend_name\n| project backend_name, [\"Total Requests\"]=Total, [\"KO Requests\"]=KO\n| render barchart kind=stacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "StackedBar",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "backend_name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Requests",
                        "type": "long"
                      },
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n    by backend_name\n| project [\"Backend Name\"]=backend_name, [\"Total Responses\"]=Total, [\"OK Responses\"]=Total-KO, [\"KO Responses\"]=KO\n| render barchart kind=unstacked\n\n",
                  "SpecificChart": "UnstackedBar",
                  "PartTitle": "Routed primitives: VerifyPaymentNotice - Error on NDP instances volumes",
                  "PartSubTitle": "Volumes about errors on NDP instances for routed verifyPaymentNotice",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Backend Name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Responses",
                        "type": "long"
                      },
                      {
                        "name": "OK Responses",
                        "type": "long"
                      },
                      {
                        "name": "KO Responses",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 31,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "134ec9b3-3b61-4e63-bf5a-34d32c295971",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "2025-06-09T21:00:45.000Z/2025-06-09T21:45:45.000Z",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\",\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\",\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", \n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\",\n];\nrequests\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| join kind=inner (\n    dependencies\n    | project operation_Id, target, timestamp\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\", \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\", \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\", \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Requests\"] = countif(outcome == \"KO\") by bin(timestamp, 5m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Line",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "timestamp",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "Backend Name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\", \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\", \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\", \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Responses\"] = countif(outcome == \"KO\") by bin(timestamp, 5m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n\n",
                  "PartTitle": "Routed primitives: VerifyPaymentNotice - Error on NDP instances during time",
                  "PartSubTitle": "Volumes divided by time about errors on NDP instances for routed verifyPaymentNotice",
                  "Dimensions": {
                    "xAxis": {
                      "name": "timestamp",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "KO Responses",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "Backend Name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 31,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "56904424-8e7d-4a0f-b125-5d88c1620e64",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\nlet lowerTime = ago(24h);\nrequests\n| where timestamp > lowerTime\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where customDimensions[\"Response-Body\"] contains \"<fault>\"\n//\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fault_code = extract(\"<faultCode>(.*?)</faultCode>\", 1, response),\n         fault_string = extract(\"<faultString>(.*?)</faultString>\", 1, response)\n//\n| join kind=inner (\n    dependencies\n    | where timestamp > lowerTime\n    | project operation_Id, target\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| summarize Count = count() by raw_backend_name, primitive, fault_code\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "StackedColumn",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "fault_code",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "raw_backend_name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": true,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where customDimensions[\"Response-Body\"] contains \"<fault>\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fault_code = extract(\"<faultCode>(.*?)</faultCode>\", 1, response),\n         fault_string = extract(\"<faultString>(.*?)</faultString>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Fault Code\"] = fault_code\n| summarize Count = count() by [\"Fault Code\"], backend_name\n| top 20 by Count desc\n| render columnchart kind=unstacked\n\n",
                  "SpecificChart": "UnstackedColumn",
                  "PartTitle": "Routed primitives: VerifyPaymentNotice - Error on NDP instances details",
                  "PartSubTitle": "Details about errors on NDP instances for routed verifyPaymentNotice",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Fault Code",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "backend_name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "IsQueryContainTimeRange": false
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 37,
              "colSpan": 18,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "content": "<h1 style=\"background-color:red;color:white;font-size:2.5em;padding-left: 0.5em\">\n*activatePaymentNotice* (v1, v2)\n</h1>\n",
                  "title": "",
                  "subtitle": "",
                  "markdownSource": 1,
                  "markdownUri": ""
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 38,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "528c49a2-d712-4b05-9590-0ac0310a6f67",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.63\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        backendUrl_s startswith \"https://weuprod.fdr.internal.platform.pagopa.it\",\n        \"04 FdR-Fase1\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/wisp-soap-converter\",\n        \"05 WISP Dismantling\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 no backend: handled by APIM policies\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 no backend: error on APIM (wrong subkey)\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 no backend: error on APIM (\", lastError_reason_s, \")\"),\n        \"09 no backend: error on APIM (unknown)\"\n    )     \n| where primitive startswith \"activatePaymentNotice\" \n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Pie",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "Routed Backend",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\",\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\",\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\",\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\",\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 Unknown\"\n    )     \n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
                  "ControlType": "FrameControlChart",
                  "PartTitle": "Routed primitives: ActivatePaymentNotice - Percentages",
                  "PartSubTitle": "Percentages about routed activatePaymentNotice and activatePaymentNoticeV2"
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 38,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "1398901e-3eca-448a-a611-3f3159f12202",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend backend_name = case ( \n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.63\",\n        \"NDP004PROD (Nexi Postgres)\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://weuprod.fdr.internal.platform.pagopa.it\",\n        \"FdR-Fase1\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/wisp-soap-converter\",\n        \"WISP Dismantling\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"no backend: handled by APIM policies\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"no backend: error on APIM (wrong subkey)\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"no backend: error on APIM (\", lastError_reason_s, \")\"),\n        \"no backend: error on APIM (unknown)\"\n    )                   \n| where primitive startswith \"activatePaymentNotice\" \n| summarize count() by backend_name, primitive_name\n| order by backend_name\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "AnalyticsGrid",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "GridColumnsWidth": {
                    "Routed Backend": "343px",
                    "Primitive": "315px",
                    "Count": "103px"
                  },
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 Managed by APIM policies: OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 Managed by APIM policies: wrong subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 Managed by APIM policies: \", lastError_reason_s),\n        \"99 Managed by APIM policies: unknown error\"\n    )     \n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
                  "PartTitle": "Routed primitives: ActivatePaymentNotice - Volumes",
                  "PartSubTitle": "Volumes about routed activatePaymentNotice and activatePaymentNoticeV2"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 43,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "14dac35f-2541-4ab3-af03-bb0d1131df1f",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT1H",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\nrequests\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| join kind=inner (\n    dependencies\n    | project operation_Id, target\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n    by backend_name\n| project backend_name, [\"Total Requests\"]=Total, [\"KO Requests\"]=KO\n| render barchart kind=stacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "StackedBar",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "backend_name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Requests",
                        "type": "long"
                      },
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n| project [\"Backend Name\"]=\"All backends\", [\"Total Responses\"]=Total, [\"OK Responses\"]=Total-KO, [\"KO Responses\"]=KO\n| render barchart kind=unstacked\n\n",
                  "SpecificChart": "UnstackedBar",
                  "PartTitle": "Routed primitives: ActivatePaymentNotice - Error on NDP instances cumulative volumes",
                  "PartSubTitle": "Cumulative volumes about errors on NDP instances for routed activatePaymentNotice and activatePaymentNoticeV2",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Backend Name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Responses",
                        "type": "long"
                      },
                      {
                        "name": "OK Responses",
                        "type": "long"
                      },
                      {
                        "name": "KO Responses",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 43,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "14dac35f-2541-4ab3-af03-bb0d1131df1f",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT1H",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\nrequests\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| join kind=inner (\n    dependencies\n    | project operation_Id, target\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n    by backend_name\n| project backend_name, [\"Total Requests\"]=Total, [\"KO Requests\"]=KO\n| render barchart kind=stacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "StackedBar",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "backend_name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Requests",
                        "type": "long"
                      },
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n    by backend_name\n| project [\"Backend Name\"]=backend_name, [\"Total Responses\"]=Total, [\"OK Responses\"]=Total-KO, [\"KO Responses\"]=KO\n| render barchart kind=unstacked\n\n",
                  "SpecificChart": "UnstackedBar",
                  "PartTitle": "Routed primitives: ActivatePaymentNotice - Error on NDP instances volumes",
                  "PartSubTitle": "Volumes about errors on NDP instances for routed activatePaymentNotice and activatePaymentNoticeV2",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Backend Name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Responses",
                        "type": "long"
                      },
                      {
                        "name": "OK Responses",
                        "type": "long"
                      },
                      {
                        "name": "KO Responses",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 48,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "134ec9b3-3b61-4e63-bf5a-34d32c295971",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "2025-06-09T21:00:45.000Z/2025-06-09T21:45:45.000Z",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\",\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\",\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", \n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\",\n];\nrequests\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| join kind=inner (\n    dependencies\n    | project operation_Id, target, timestamp\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\", \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\", \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\", \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Requests\"] = countif(outcome == \"KO\") by bin(timestamp, 5m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Line",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "timestamp",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "Backend Name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\",\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\",\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", \n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\",\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\", \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\", \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\", \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Responses\"] = countif(outcome == \"KO\") by bin(timestamp, 5m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n\n",
                  "PartTitle": "Routed primitives: ActivatePaymentNotice - Error on NDP instances during time",
                  "PartSubTitle": "Volumes divided by time about errors on NDP instances for routed activatePaymentNotice and activatePaymentNoticeV2",
                  "Dimensions": {
                    "xAxis": {
                      "name": "timestamp",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "KO Responses",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "Backend Name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 48,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "56904424-8e7d-4a0f-b125-5d88c1620e64",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\nlet lowerTime = ago(24h);\nrequests\n| where timestamp > lowerTime\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where customDimensions[\"Response-Body\"] contains \"<fault>\"\n//\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fault_code = extract(\"<faultCode>(.*?)</faultCode>\", 1, response),\n         fault_string = extract(\"<faultString>(.*?)</faultString>\", 1, response)\n//\n| join kind=inner (\n    dependencies\n    | where timestamp > lowerTime\n    | project operation_Id, target\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| summarize Count = count() by raw_backend_name, primitive, fault_code\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "StackedColumn",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "fault_code",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "raw_backend_name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": true,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where customDimensions[\"Response-Body\"] contains \"<fault>\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fault_code = extract(\"<faultCode>(.*?)</faultCode>\", 1, response),\n         fault_string = extract(\"<faultString>(.*?)</faultString>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Fault Code\"] = fault_code\n| summarize Count = count() by [\"Fault Code\"], backend_name\n| top 20 by Count desc\n| render columnchart kind=unstacked\n\n",
                  "SpecificChart": "UnstackedColumn",
                  "PartTitle": "Routed primitives: ActivatePaymentNotice - Error on NDP instances details",
                  "PartSubTitle": "Details about errors on NDP instances for routed activatePaymentNotice and activatePaymentNoticeV2",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Fault Code",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "backend_name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "IsQueryContainTimeRange": false
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 54,
              "colSpan": 18,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "content": "<h1 style=\"background-color:red;color:white;font-size:2.5em;padding-left: 0.5em\">\n*closePayment* (v2)\n</h1>\n",
                  "title": "",
                  "subtitle": "",
                  "markdownSource": 1,
                  "markdownUri": ""
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 55,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "528c49a2-d712-4b05-9590-0ac0310a6f67",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.63\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        backendUrl_s startswith \"https://weuprod.fdr.internal.platform.pagopa.it\",\n        \"04 FdR-Fase1\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/wisp-soap-converter\",\n        \"05 WISP Dismantling\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 no backend: handled by APIM policies\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 no backend: error on APIM (wrong subkey)\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 no backend: error on APIM (\", lastError_reason_s, \")\"),\n        \"09 no backend: error on APIM (unknown)\"\n    )     \n| where primitive startswith \"activatePaymentNotice\" \n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Pie",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "Routed Backend",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)[\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\",\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 Unknown\"\n    )     \n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n",
                  "ControlType": "FrameControlChart",
                  "PartTitle": "Routed primitives: ClosePaymentV2 - Percentages",
                  "PartSubTitle": "Percentages about routed closePaymentV2"
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 55,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "1398901e-3eca-448a-a611-3f3159f12202",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend backend_name = case ( \n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.63\",\n        \"NDP004PROD (Nexi Postgres)\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://weuprod.fdr.internal.platform.pagopa.it\",\n        \"FdR-Fase1\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/wisp-soap-converter\",\n        \"WISP Dismantling\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"no backend: handled by APIM policies\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"no backend: error on APIM (wrong subkey)\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"no backend: error on APIM (\", lastError_reason_s, \")\"),\n        \"no backend: error on APIM (unknown)\"\n    )                   \n| where primitive startswith \"activatePaymentNotice\" \n| summarize count() by backend_name, primitive_name\n| order by backend_name\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "AnalyticsGrid",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "GridColumnsWidth": {
                    "Routed Backend": "343px",
                    "Primitive": "315px",
                    "Count": "103px"
                  },
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 Managed by APIM policies: OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 Managed by APIM policies: wrong subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 Managed by APIM policies: \", lastError_reason_s),\n        \"99 Managed by APIM policies: unknown error\"\n    )     \n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
                  "PartTitle": "Routed primitives: ClosePaymentV2 - Volumes",
                  "PartSubTitle": "Volumes about routed closePaymentV2"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 60,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "14dac35f-2541-4ab3-af03-bb0d1131df1f",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT1H",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\nrequests\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| join kind=inner (\n    dependencies\n    | project operation_Id, target\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n    by backend_name\n| project backend_name, [\"Total Requests\"]=Total, [\"KO Requests\"]=KO\n| render barchart kind=stacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "StackedBar",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "backend_name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Requests",
                        "type": "long"
                      },
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend fault_code = resultCode\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"HTTP Status\"] = fault_code\n| summarize Count = count()\n| top 20 by Count desc\n| project [\"Backend Name\"] = \"All backends\", [\"KO Requests\"] = Count\n| render barchart kind=stacked\n\n",
                  "PartTitle": "Routed primitives: ClosePaymentV2 - Error on NDP instances cumulative volumes",
                  "PartSubTitle": "Cumulative volumes about errors on NDP instances for routed closePaymentV2",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Backend Name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 60,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "14dac35f-2541-4ab3-af03-bb0d1131df1f",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT1H",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\nrequests\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| join kind=inner (\n    dependencies\n    | project operation_Id, target\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n    by backend_name\n| project backend_name, [\"Total Requests\"]=Total, [\"KO Requests\"]=KO\n| render barchart kind=stacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "StackedBar",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "backend_name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Requests",
                        "type": "long"
                      },
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend fault_code = resultCode\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"HTTP Status\"] = fault_code\n| summarize Count = count() by backend_name\n| top 20 by Count desc\n| project [\"Backend Name\"]=backend_name, [\"KO Requests\"]=Count\n| render barchart kind=stacked\n\n",
                  "PartTitle": "Routed primitives: ClosePaymentV2 - Error on NDP instances volumes",
                  "PartSubTitle": "Volumes about errors on NDP instances for routed closePaymentV2",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Backend Name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 65,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "134ec9b3-3b61-4e63-bf5a-34d32c295971",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "2025-06-09T21:00:45.000Z/2025-06-09T21:45:45.000Z",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\",\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\",\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", \n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\",\n];\nrequests\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| join kind=inner (\n    dependencies\n    | project operation_Id, target, timestamp\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\", \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\", \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\", \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Requests\"] = countif(outcome == \"KO\") by bin(timestamp, 5m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Line",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "timestamp",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "Backend Name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend outcome = resultCode\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\", \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\", \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\", \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Responses\"] = count(outcome) by bin(timestamp, 5m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n\n",
                  "PartTitle": "Routed primitives: ClosePaymentV2 - Error on NDP instances during time",
                  "PartSubTitle": "Volumes divided by time about errors on NDP instances for routed closePaymentV2",
                  "Dimensions": {
                    "xAxis": {
                      "name": "timestamp",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "KO Responses",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "Backend Name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 65,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "56904424-8e7d-4a0f-b125-5d88c1620e64",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\nlet lowerTime = ago(24h);\nrequests\n| where timestamp > lowerTime\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where customDimensions[\"Response-Body\"] contains \"<fault>\"\n//\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fault_code = extract(\"<faultCode>(.*?)</faultCode>\", 1, response),\n         fault_string = extract(\"<faultString>(.*?)</faultString>\", 1, response)\n//\n| join kind=inner (\n    dependencies\n    | where timestamp > lowerTime\n    | project operation_Id, target\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| summarize Count = count() by raw_backend_name, primitive, fault_code\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "StackedColumn",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "fault_code",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "raw_backend_name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": true,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend fault_code = resultCode\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"HTTP Status\"] = fault_code\n| summarize Count = count() by [\"HTTP Status\"], backend_name\n| top 20 by Count desc\n| render columnchart kind=unstacked\n\n",
                  "SpecificChart": "UnstackedColumn",
                  "PartTitle": "Routed primitives: ClosePaymentV2 - Error on NDP instances details",
                  "PartSubTitle": "Details about errors on NDP instances for routed closePaymentV2",
                  "Dimensions": {
                    "xAxis": {
                      "name": "HTTP Status",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "backend_name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "IsQueryContainTimeRange": false
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 71,
              "colSpan": 18,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "content": "<h1 style=\"background-color:red;color:white;font-size:2.5em;padding-left: 0.5em\">\n*sendPaymentOutcome* (v1, v2)\n</h1>\n",
                  "title": "",
                  "subtitle": "",
                  "markdownSource": 1,
                  "markdownUri": ""
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 72,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "528c49a2-d712-4b05-9590-0ac0310a6f67",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.63\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        backendUrl_s startswith \"https://weuprod.fdr.internal.platform.pagopa.it\",\n        \"04 FdR-Fase1\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/wisp-soap-converter\",\n        \"05 WISP Dismantling\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 no backend: handled by APIM policies\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 no backend: error on APIM (wrong subkey)\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 no backend: error on APIM (\", lastError_reason_s, \")\"),\n        \"09 no backend: error on APIM (unknown)\"\n    )     \n| where primitive startswith \"activatePaymentNotice\" \n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Pie",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "Routed Backend",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\",\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\",\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", \n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", \n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 Unknown\"\n    )     \n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
                  "ControlType": "FrameControlChart",
                  "PartTitle": "Routed primitives: SendPaymentOutcome - Percentages",
                  "PartSubTitle": "Percentages about routed sendPaymentOutcome and sendPaymentOutcomeV2"
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 72,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "1398901e-3eca-448a-a611-3f3159f12202",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend backend_name = case ( \n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.63\",\n        \"NDP004PROD (Nexi Postgres)\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://weuprod.fdr.internal.platform.pagopa.it\",\n        \"FdR-Fase1\",\n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/wisp-soap-converter\",\n        \"WISP Dismantling\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"no backend: handled by APIM policies\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"no backend: error on APIM (wrong subkey)\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"no backend: error on APIM (\", lastError_reason_s, \")\"),\n        \"no backend: error on APIM (unknown)\"\n    )                   \n| where primitive startswith \"activatePaymentNotice\" \n| summarize count() by backend_name, primitive_name\n| order by backend_name\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "AnalyticsGrid",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "GridColumnsWidth": {
                    "Routed Backend": "285px",
                    "Primitive": "222px"
                  },
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n     //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        backendUrl_s startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        backendUrl_s startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 Managed by APIM policies: OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 Managed by APIM policies: wrong subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 Managed by APIM policies: \", lastError_reason_s),\n        \"99 Managed by APIM policies: unknown error\"\n    )     \n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
                  "PartTitle": "Routed primitives: SendPaymentOutcome - Volumes",
                  "PartSubTitle": "Volumes about routed sendPaymentOutcome and sendPaymentOutcomeV2"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 77,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "14dac35f-2541-4ab3-af03-bb0d1131df1f",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT1H",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\nrequests\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| join kind=inner (\n    dependencies\n    | project operation_Id, target\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n    by backend_name\n| project backend_name, [\"Total Requests\"]=Total, [\"KO Requests\"]=KO\n| render barchart kind=stacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "StackedBar",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "backend_name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Requests",
                        "type": "long"
                      },
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n| project [\"Backend Name\"]=\"All backends\", [\"Total Responses\"]=Total, [\"OK Responses\"]=Total-KO, [\"KO Responses\"]=KO\n| render barchart kind=unstacked\n",
                  "SpecificChart": "UnstackedBar",
                  "PartTitle": "Routed primitives: SendPaymentOutcome - Error on NDP instances cumulative volumes",
                  "PartSubTitle": "Cumulative volumes about errors on NDP instances for routed sendPaymentOutcome and sendPaymentOutcomeV2",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Backend Name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Responses",
                        "type": "long"
                      },
                      {
                        "name": "OK Responses",
                        "type": "long"
                      },
                      {
                        "name": "KO Responses",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 77,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "14dac35f-2541-4ab3-af03-bb0d1131df1f",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT1H",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\nrequests\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| join kind=inner (\n    dependencies\n    | project operation_Id, target\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n    by backend_name\n| project backend_name, [\"Total Requests\"]=Total, [\"KO Requests\"]=KO\n| render barchart kind=stacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "StackedBar",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "backend_name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Requests",
                        "type": "long"
                      },
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend req = tostring(customDimensions[\"Request-Body\"])\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize\n    Total = count(),\n    KO = countif(outcome == \"KO\")\n    by backend_name\n| project [\"Backend Name\"]=backend_name, [\"Total Responses\"]=Total, [\"OK Responses\"]=Total-KO, [\"KO Responses\"]=KO\n| render barchart kind=unstacked\n\n",
                  "SpecificChart": "UnstackedBar",
                  "PartTitle": "Routed primitives: SendPaymentOutcome - Error on NDP instances volumes",
                  "PartSubTitle": "Volumes about errors on NDP instances for routed sendPaymentOutcome and sendPaymentOutcomeV2",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Backend Name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Total Responses",
                        "type": "long"
                      },
                      {
                        "name": "OK Responses",
                        "type": "long"
                      },
                      {
                        "name": "KO Responses",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 82,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "134ec9b3-3b61-4e63-bf5a-34d32c295971",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "2025-06-09T21:00:45.000Z/2025-06-09T21:45:45.000Z",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\",\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\",\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", \n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\",\n];\nrequests\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| join kind=inner (\n    dependencies\n    | project operation_Id, target, timestamp\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\", \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\", \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\", \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Requests\"] = countif(outcome == \"KO\") by bin(timestamp, 5m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Line",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "timestamp",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "KO Requests",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "Backend Name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)[    \n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\",\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\",\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", \n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\",\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\", \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\", \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\", \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Responses\"] = countif(outcome == \"KO\") by bin(timestamp, 5m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n\n",
                  "PartTitle": "Routed primitives: SendPaymentOutcome - Error on NDP instances during time",
                  "PartSubTitle": "Volumes divided by time about errors on NDP instances for routed sendPaymentOutcome and sendPaymentOutcomeV2",
                  "Dimensions": {
                    "xAxis": {
                      "name": "timestamp",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "KO Responses",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "Backend Name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  }
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 82,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "56904424-8e7d-4a0f-b125-5d88c1620e64",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false\n];\nlet lowerTime = ago(24h);\nrequests\n| where timestamp > lowerTime\n| extend operationId_s = tostring(customDimensions[\"Operation Name\"])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where customDimensions[\"Response-Body\"] contains \"<fault>\"\n//\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fault_code = extract(\"<faultCode>(.*?)</faultCode>\", 1, response),\n         fault_string = extract(\"<faultString>(.*?)</faultString>\", 1, response)\n//\n| join kind=inner (\n    dependencies\n    | where timestamp > lowerTime\n    | project operation_Id, target\n) on operation_Id\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| summarize Count = count() by raw_backend_name, primitive, fault_code\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "StackedColumn",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "fault_code",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "raw_backend_name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": true,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: bool)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where customDimensions[\"Response-Body\"] contains \"<fault>\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fault_code = extract(\"<faultCode>(.*?)</faultCode>\", 1, response),\n         fault_string = extract(\"<faultString>(.*?)</faultString>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\",\n        \"01 NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\",\n        \"02 NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\",\n        \"03 NDP004PROD (Nexi Postgres)\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Fault Code\"] = fault_code\n| summarize Count = count() by [\"Fault Code\"], backend_name\n| top 20 by Count desc\n| render columnchart kind=unstacked\n\n",
                  "SpecificChart": "UnstackedColumn",
                  "PartTitle": "Routed primitives: SendPaymentOutcome - Error on NDP instances details",
                  "PartSubTitle": "Details about errors on NDP instances for routed sendPaymentOutcome and sendPaymentOutcomeV2",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Fault Code",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "backend_name",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "IsQueryContainTimeRange": false
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 88,
              "colSpan": 18,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "content": "<h1 style=\"background-color:red;color:white;font-size:2.5em;padding-left: 0.5em\">\nMiscellaneous\n</h1>\n",
                  "title": "",
                  "subtitle": "",
                  "markdownSource": 1,
                  "markdownUri": ""
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 89,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "8e35488e-1420-46ab-8d6b-de628e773964",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nlet api_counts = AzureDiagnostics\n| join kind=inner (monitored_apis) on operationId_s\n| summarize Count = count() by primitive;\nmonitored_apis\n| summarize by primitive  // rimuove i duplicati\n| join kind=leftouter (api_counts) on primitive\n| extend Count = coalesce(Count, 0)\n| order by Count desc, primitive asc\n| project ['Primitive name']=primitive, Count\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "AnalyticsGrid",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "GridColumnsWidth": {
                    "Primitive name": "514px",
                    "Count": "123px",
                    "Deprecated": "114px"
                  },
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string, deprecated: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", false,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", false,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", false,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", false,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", false,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", false,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", false,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", false,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", false,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", false,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", false,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", false,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", false,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", false,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", false,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", false,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", false,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", false,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", false,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", false,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", false,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", false,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", false,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", false,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", false,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", false,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", false,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", false,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nlet api_counts = AzureDiagnostics\n| join kind=inner (monitored_apis) on operationId_s\n| summarize Count = count() by primitive;\nmonitored_apis\n| summarize any(deprecated) by primitive\n| join kind=leftouter (api_counts) on primitive\n| extend Count = coalesce(Count, 0)\n| order by Count desc, primitive asc\n| project ['Primitive name'] = primitive, ['Deprecated'] = any_deprecated, Count\n\n",
                  "PartTitle": "Invoked primitives: Deprecation - Details",
                  "PartSubTitle": "Details about deprecated and not-deprecated primitives, invoked in the defined time slot"
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 89,
              "colSpan": 9,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "111b4b2f-672e-4d39-b011-45469360bfb3",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT1H",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string, is_auth: boolean)[\n    //  Node for PSP Auth\n    \"63b6e2daea7c4a25440fdaa0\", \"activatePaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", true,\n    \"63b6e2daea7c4a25440fdaa3\", \"demandPaymentNotice\", true,\n    \"63b6e2daea7c4a25440fdaa4\", \"nodoChiediCatalogoServiziV2\", true,\n    \"63ff4f22aca2fd18dcc4a6f8\", \"nodoChiediInformativaPA\", true,\n    \"63ff4f22aca2fd18dcc4a6f9\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2daea7c4a25440fdaa1\", \"sendPaymentOutcome\", true,\n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", true,\n    \"63b6e2daea7c4a25440fdaa2\", \"verificaBollettino\", true,\n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\", true,\n    // Node for PSP\n    \"61dedafc2a92e81a0c7a58fc\", \"activatePaymentNotice\", false,\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", false,\n    \"62bb23bdea7c4a0f183fc065\", \"demandPaymentNotice\", false,\n    \"62bb23bdea7c4a0f183fc066\", \"nodoChiediCatalogoServiziV2\", false,\n    \"61dedafc2a92e81a0c7a58fd\", \"sendPaymentOutcome\", false,\n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", false,\n    \"61dedafc2a92e81a0c7a58fe\", \"verificaBollettino\", false,\n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\", false,\n    // Nodo per PSP Auth\n    \"63b6e2da2a92e811a8f338fc\", \"nodoAttivaRPT\", true,\n    \"63b6e2da2a92e811a8f33900\", \"nodoChiediElencoQuadraturePSP\", true,\n    \"63b6e2da2a92e811a8f338fe\", \"nodoChiediInformativaPA\", true,\n    \"63b6e2da2a92e811a8f338ff\", \"nodoChiediTemplateInformativaPSP\", true,\n    \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione\", true,\n    \"63b6e2da2a92e811a8f338fd\", \"nodoInviaRT\", true,\n    \"63b6e2da2a92e811a8f338fb\", \"nodoVerificaRPT\", true,\n    // Nodo per PSP\n    \"61dedafc2a92e81a0c7a58f6\", \"nodoAttivaRPT\", false,\n    \"6217ba1b2a92e81fa4f15e7a\", \"nodoChiediElencoQuadraturePSP\", false,\n    \"6217ba1b2a92e81fa4f15e78\", \"nodoChiediInformativaPA\", false,\n    \"6217ba1b2a92e81fa4f15e79\", \"nodoChiediTemplateInformativaPSP\", false,\n    \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione\", false,\n    \"6217ba1b2a92e81fa4f15e77\", \"nodoInviaRT\", false,\n    \"61dedafb2a92e81a0c7a58f5\", \"nodoVerificaRPT\", false,\n    // Nodo per PA Auth\n    \"63e5d8212a92e80448d38e01\", \"nodoChiediCopiaRT\", true,\n    \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione\", true,\n    \"63e5d8212a92e80448d38e04\", \"nodoChiediElencoQuadraturePA\", true,\n    \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione\", true,\n    \"63e5d8212a92e80448d38e02\", \"nodoChiediInformativaPSP\", true,\n    \"63e5d8212a92e80448d38dfe\", \"nodoChiediListaPendentiRPT\", true,\n    \"63e5d8212a92e80448d38e05\", \"nodoChiediQuadraturaPA\", true,\n    \"63e5d8212a92e80448d38dfd\", \"nodoChiediStatoRPT\", true,\n    \"63e5d8212a92e80448d38e00\", \"nodoInviaCarrelloRPT\", true,\n    \"63e5d8212a92e80448d38dff\", \"nodoInviaRPT\", true,\n    \"63e5d8212a92e80448d38e03\", \"nodoPAChiediInformativaPA\", true,\n    // Nodo per PA\n    \"62189aea2a92e81fa4f15ec8\", \"nodoChiediCopiaRT\", false,\n    \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ecb\", \"nodoChiediElencoQuadraturePA\", false,\n    \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione\", false,\n    \"62189aea2a92e81fa4f15ec9\", \"nodoChiediInformativaPSP\", false,\n    \"62189aea2a92e81fa4f15ec5\", \"nodoChiediListaPendentiRPT\", false,\n    \"62189aea2a92e81fa4f15ecc\", \"nodoChiediQuadraturaPA\", false,\n    \"62189aea2a92e81fa4f15ec4\", \"nodoChiediStatoRPT\", false,\n    \"62189aea2a92e81fa4f15ec7\", \"nodoInviaCarrelloRPT\", false,\n    \"62189aea2a92e81fa4f15ec6\", \"nodoInviaRPT\", false,\n    \"62189aea2a92e81fa4f15eca\", \"nodoPAChiediInformativaPA\", false,\n    // Node for PA Auth\n    \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione \", true,\n    \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione\", true,\n    // Node for IO Auth\n    \"63b6e2da2a92e811a8f338ec\", \"activateIOPayment\", true,\n    // Node for IO\n    \"61dedb1eea7c4a07cc7d47b8\", \"activateIOPayment\", false,\n    // Node for eCommerce V1\n    \"checkPosition\", \"checkPosition\", false,\n    // Nodo per eCommerce V2\n    \"closePaymentV2\", \"closePaymentV2\", false,\n    // Nodo per PM V1               \n    \"closePayment\", \"closePayment\", false,\n    \"nodoChiediAvanzamentoPagamento\", \"nodoChiediAvanzamentoPagamento\", false,\n    \"nodoChiediInformazioniPagamento\", \"nodoChiediInformazioniPagamento\", false,\n    \"nodoChiediListaPSP\", \"nodoChiediListaPSP\", false,\n    \"nodoInoltraEsitoPagamentoCarta\", \"nodoInoltraEsitoPagamentoCarta\", false,\n    \"nodoInoltraEsitoPagamentoPayPal\", \"nodoInoltraEsitoPagamentoPayPal\", false,\n    \"nodoInoltraPagamentoMod1\", \"nodoInoltraPagamentoMod1\", false,\n    \"nodoInoltraPagamentoMod2\", \"nodoInoltraPagamentoMod2\", false,\n    \"nodoNotificaAnnullamento\", \"nodoNotificaAnnullamento\", false,\n    \"parkedList\", \"parkedList\", false,\n];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| summarize Count=count() by is_auth\n| extend type = case(is_auth, \"Auth\", \"Non-Auth\")\n| project [\"Is on Auth\"]=type, Count\n| render piechart\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Pie",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-apim",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "Is on Auth",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Count",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "PartTitle": "Invoked primitives: Auth - Percentage",
                  "PartSubTitle": "Percentage about usage of Auth primitives (i.e. the ones that require subscription key) "
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 95,
              "colSpan": 18,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "content": "<h1 style=\"background-color:red;color:white;font-size:2.5em;padding-left: 0.5em\">\nFlows Monitoring\n</h1>\n",
                  "title": "",
                  "subtitle": "",
                  "markdownSource": 1,
                  "markdownUri": ""
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 96,
              "colSpan": 21,
              "rowSpan": 6
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "5d5b7ffd-3586-4324-8594-f777f2034d31",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let lowerBound = ago(10m);\nlet monitored_apis = datatable(operationId_s: string, primitive: string) [\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", \n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", \n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\",\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", \n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", \n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\",\n    // \"closePaymentV2\", \"closePaymentV2\", // TODO closePaymentV2 are impossible to track until AppInsight tracing is disabled in API-set!!! \n];\nlet parsed = dependencies\n| where timestamp > lowerBound\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where isnotempty(operationId_s) and isnotempty(primitive)\n| extend request = tostring(customDimensions[\"Request-Body\"])\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend noticeNumber = extract(\"<noticeNumber>(.*?)</noticeNumber>\", 1, request)\n| extend noticeNumber = iif(isempty(noticeNumber), extract(\"<noticeNumber>(.*?)</noticeNumber>\", 1, response), noticeNumber)\n| extend paymentToken = extract(\"<paymentToken>(.*?)</paymentToken>\", 1, request)\n| extend paymentToken = iif(isempty(paymentToken), extract(\"<paymentToken>(.*?)</paymentToken>\", 1, response), paymentToken)\n| extend idempotencyKey = extract(\"<idempotencyKey>(.*?)</idempotencyKey>\", 1, request)\n| extend faultCode = extract(\"<faultCode>(.*?)</faultCode>\", 1, response)\n| extend outcome = iif(isempty(faultCode), \"OK\", faultCode)\n| extend backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\", \"NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\", \"NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\", \"NDP004PROD (Nexi Postgres)\",\n        \"Unknown\"\n    )\n;\n// Calculating verifyPaymentNotice\nlet onlyVerifyPaymentNotice = parsed\n| where primitive == \"verifyPaymentNotice\"\n| summarize status = any(outcome) by noticeNumber, primitive, paymentToken, backend_name\n| extend kv = pack(primitive, status)\n| summarize merged = make_bag(kv) by noticeNumber, paymentToken, verifyTarget=backend_name\n| evaluate bag_unpack(merged)\n;\n// Calculating activatePaymentNoticeV2\nlet onlyActivatePaymentNoticeV2 = parsed\n| where primitive == \"activatePaymentNoticeV2\"\n| summarize status = any(outcome) by noticeNumber, primitive, idempotencyKey, paymentToken, backend_name\n| extend kv = pack(primitive, status)\n| summarize merged = make_bag(kv) by noticeNumber, idempotencyKey, paymentToken, activateV2Target=backend_name\n| evaluate bag_unpack(merged)\n;\n// Calculating sendPaymentOutcomeV2\nlet onlySendPaymentOutcomeV2 = parsed\n| where primitive == \"sendPaymentOutcomeV2\"\n| summarize status = any(outcome) by paymentToken, primitive, backend_name\n| extend kv = pack(primitive, status)\n| summarize merged = make_bag(kv) by paymentToken, spoV2Target=backend_name\n| evaluate bag_unpack(merged)\n;\n// Merging activatePaymentNoticeV2 and sendPaymentOutcomeV2 by payment token\nlet activatePlusSPO = onlyActivatePaymentNoticeV2\n| join kind=leftouter onlySendPaymentOutcomeV2 on paymentToken\n| project noticeNumber,\n          idempotencyKey,\n          paymentToken, \n          activatePaymentNoticeV2,\n          sendPaymentOutcomeV2,\n          activateV2Target,\n          spoV2Target\n;\n// Merging previous view with verifyPaymentNotice by notice number\nlet verifyPlusPrevious = activatePlusSPO\n| join kind=leftouter onlyVerifyPaymentNotice on noticeNumber\n| project noticeNumber,\n          idempotencyKey,\n          paymentToken, \n          verifyPaymentNotice,\n          activatePaymentNoticeV2,\n          sendPaymentOutcomeV2,\n          verifyTarget,\n          activateV2Target,\n          spoV2Target\n;\n// Finally, format the result table!\nverifyPlusPrevious\n| project \n    [\"Notice number\"] = noticeNumber,\n    [\"Idempotency key\"] = idempotencyKey,\n    [\"Payment token\"] = paymentToken,\n    [\"VerifyPaymentNotice\"] = verifyPaymentNotice,\n    [\"ActivatePaymentNoticeV2\"] = activatePaymentNoticeV2,\n    [\"SendPaymentOutcomeV2\"] = sendPaymentOutcomeV2,\n    [\"VerifyPaymentNotice target\"] = verifyTarget,\n    [\"ActivatePaymentNoticeV2 target\"] = activateV2Target,\n    [\"SendPaymentOutcomeV2 target\"] = spoV2Target\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "AnalyticsGrid",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "pagopa-${env_short}-appinsights",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": true,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "GridColumnsWidth": {
                    "Notice number": "153.997px",
                    "Idempotency key": "152.99px",
                    "Payment token": "135.993px",
                    "VerifyPaymentNotice": "200.993px",
                    "ActivatePaymentNoticeV2": "200.993px",
                    "SendPaymentOutcomeV2": "223px",
                    "VerifyPaymentNotice target": "199.997px",
                    "ActivatePaymentNoticeV2 target": "228.986px",
                    "SendPaymentOutcomeV2 target": "232.031px",
                    "Fiscal code": "106.986px",
                    "Insights": "472.035px",
                    "Started at": "142px"
                  },
                  "Query": "let lowerBound = ago(10m);\nlet monitored_apis = datatable(operationId_s: string, primitive: string) [\n    \"63b6e2daea7c4a25440fdaa5\", \"activatePaymentNoticeV2\", \n    \"63b6e2daea7c4a25440fdaa6\", \"sendPaymentOutcomeV2\", \n    \"63b6e2daea7c4a25440fda9f\", \"verifyPaymentNotice\",\n    \"63c559672a92e811a8f33a00\", \"activatePaymentNoticeV2\", \n    \"63c559672a92e811a8f33a01\", \"sendPaymentOutcomeV2\", \n    \"61dedafc2a92e81a0c7a58fb\", \"verifyPaymentNotice\",\n    // \"closePaymentV2\", \"closePaymentV2\", // TODO closePaymentV2 are impossible to track until AppInsight tracing is disabled in API-set!!! \n];\nlet parsed = dependencies\n| where timestamp > lowerBound\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where isnotempty(operationId_s) and isnotempty(primitive)\n| extend request = tostring(customDimensions[\"Request-Body\"])\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fiscalCode = extract(\"<fiscalCode>(.*?)</fiscalCode>\", 1, request)\n| extend fiscalCode = iif(isempty(fiscalCode), extract(\"<fiscalCode>(.*?)</fiscalCode>\", 1, response), fiscalCode)\n| extend noticeNumber = extract(\"<noticeNumber>(.*?)</noticeNumber>\", 1, request)\n| extend noticeNumber = iif(isempty(noticeNumber), extract(\"<noticeNumber>(.*?)</noticeNumber>\", 1, response), noticeNumber)\n| extend paymentToken = extract(\"<paymentToken>(.*?)</paymentToken>\", 1, request)\n| extend paymentToken = iif(isempty(paymentToken), extract(\"<paymentToken>(.*?)</paymentToken>\", 1, response), paymentToken)\n| extend faultCode = extract(\"<faultCode>(.*?)</faultCode>\", 1, response)\n| extend outcome = iif(isempty(faultCode), \"OK\", faultCode)\n| extend backend_name = case ( \n        target startswith \"https://weuprod.nodo.internal.platform.pagopa.it/nodo\", \"NDP001PROD PagoPA Postgres\",\n        target startswith \"https://10.79.20.34\", \"NDP003PROD (Nexi Oracle)\",\n        target startswith \"https://10.79.20.25\", \"NDP004PROD (Nexi Postgres)\",\n        \"Unknown\"\n    )\n;\n// Calculating verifyPaymentNotice\nlet onlyVerifyPaymentNotice = parsed\n| where primitive == \"verifyPaymentNotice\"\n| summarize status = any(outcome) by timestamp, fiscalCode, noticeNumber, paymentToken, backend_name\n| extend kv = pack(\"verifyPaymentNotice\", status)\n| summarize merged = make_bag(kv) by verifyTmstmp=timestamp, fiscalCode, noticeNumber, paymentToken, verifyTarget=backend_name\n| evaluate bag_unpack(merged)\n;\n// Calculating activatePaymentNoticeV2\nlet onlyActivatePaymentNoticeV2 = parsed\n| where primitive == \"activatePaymentNoticeV2\"\n| summarize status = any(outcome) by timestamp, fiscalCode, noticeNumber, paymentToken, backend_name\n| extend kv = pack(\"activatePaymentNoticeV2\", status)\n| summarize merged = make_bag(kv) by activateV2Tmstmp=timestamp, fiscalCode, noticeNumber, paymentToken, activateV2Target=backend_name\n| evaluate bag_unpack(merged)\n;\n// Calculating sendPaymentOutcomeV2\nlet onlySendPaymentOutcomeV2 = parsed\n| where primitive == \"sendPaymentOutcomeV2\"\n| summarize status = any(outcome) by timestamp, fiscalCode, paymentToken, backend_name\n| extend kv = pack(\"sendPaymentOutcomeV2\", status)\n| summarize merged = make_bag(kv) by spoV2Tmstmp=timestamp, fiscalCode, paymentToken, spoV2Target=backend_name\n| evaluate bag_unpack(merged)\n;\n// Merging activatePaymentNoticeV2 and sendPaymentOutcomeV2 by payment token\nlet activatePlusSPO = onlyActivatePaymentNoticeV2\n| join kind=leftouter onlySendPaymentOutcomeV2 on paymentToken\n| project \n          fiscalCode, \n          noticeNumber,\n          paymentToken, \n          activatePaymentNoticeV2,\n          sendPaymentOutcomeV2,\n          activateV2Target,\n          spoV2Target,\n          activateV2Tmstmp,\n          spoV2Tmstmp\n;\n// Merging previous view with verifyPaymentNotice by notice number\nlet verifyPlusPrevious = activatePlusSPO\n| join kind=leftouter onlyVerifyPaymentNotice on noticeNumber\n| project fiscalCode, \n          noticeNumber,\n          paymentToken, \n          verifyPaymentNotice,\n          activatePaymentNoticeV2,\n          sendPaymentOutcomeV2,\n          verifyTarget,\n          activateV2Target,\n          spoV2Target,\n          activateV2Tmstmp,\n          spoV2Tmstmp,\n          verifyTmstmp\n;\n// Finally, format the result table!\nverifyPlusPrevious\n| extend timestamps = bag_merge(\n        pack(\"VerifyPaymentNotice\", iff(isnotempty(verifyTmstmp), tostring(verifyTmstmp), \"\")),\n        pack(\"ActivatePaymentNoticeV2\", iff(isnotempty(activateV2Tmstmp), tostring(activateV2Tmstmp), \"\")),\n        pack(\"SendPaymentOutcomeV2\", iff(isnotempty(spoV2Tmstmp), tostring(spoV2Tmstmp), \"\"))\n    )\n| project \n    [\"Started at\"] = case(verifyTmstmp != \"\" and verifyTmstmp <= activateV2Tmstmp, verifyTmstmp, activateV2Tmstmp),\n    [\"Fiscal code\"] = fiscalCode,\n    [\"Notice number\"] = noticeNumber,\n    [\"Payment token\"] = paymentToken,\n    [\"VerifyPaymentNotice\"] = verifyPaymentNotice,\n    [\"ActivatePaymentNoticeV2\"] = activatePaymentNoticeV2,\n    [\"SendPaymentOutcomeV2\"] = sendPaymentOutcomeV2,\n    [\"Verify executed at\"]=verifyTmstmp,\n    [\"Activate executed at\"]=activateV2Tmstmp,\n    [\"SPO executed at\"]=spoV2Tmstmp,\n    [\"Insights\"]= bag_merge(\n        pack(\"Targets\", bag_merge(\n            pack(\"VerifyPaymentNotice\", iff(isnotempty(verifyTarget), verifyTarget, \"-\")),\n            pack(\"ActivatePaymentNoticeV2\", iff(isnotempty(activateV2Target), activateV2Target, \"-\")),\n            pack(\"SendPaymentOutcomeV2\", iff(isnotempty(spoV2Target), spoV2Target, \"-\"))\n        )),\n        pack(\"Timestamps\", bag_merge(\n            pack(\"VerifyPaymentNotice\", iff(isnotempty(verifyTmstmp), tostring(verifyTmstmp), \"-\")),\n            pack(\"ActivatePaymentNoticeV2\", iff(isnotempty(activateV2Tmstmp), tostring(activateV2Tmstmp), \"-\")),\n            pack(\"SendPaymentOutcomeV2\", iff(isnotempty(spoV2Tmstmp), tostring(spoV2Tmstmp), \"-\"))\n        ))\n    )\n\n",
                  "PartTitle": "Flow insights: NMU transactions - Last 10m",
                  "PartSubTitle": "Details about all the transactions in Nuovo Modello Unico"
                }
              }
            }
          }
        ]
      }
    ],
    "metadata": {
      "model": {
        "timeRange": {
          "value": {
            "relative": {
              "duration": 24,
              "timeUnit": 1
            }
          },
          "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
        },
        "filterLocale": {
          "value": "en-us"
        },
        "filters": {
          "value": {
            "MsPortalFx_TimeRange": {
              "model": {
                "format": "local",
                "granularity": "auto",
                "relative": "1h"
              },
              "displayCache": {
                "name": "Local Time",
                "value": "Past hour"
              },
              "filteredPartIds": [
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75012",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75014",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75016",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75018",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e7501a",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e7501e",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75020",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75022",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75024",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75026",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75028",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e7502c",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e7502e",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75030",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75032",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75034",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75036",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e7503a",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e7503c",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e7503e",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75040",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75042",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75044",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75048",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e7504a",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e7504c",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e7504e",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75050",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75052",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75056",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e75058",
                "StartboardPart-LogsDashboardPart-cf00e9f2-04ba-4d71-a5f6-eb37d1e7505c"
              ]
            }
          }
        }
      }
    }
  },
  "name": "Multi-node monitoring - NDP",
  "type": "Microsoft.Portal/dashboards",
  "location": "INSERT LOCATION",
  "tags": {
    "hidden-title": "Multi-node monitoring - NDP"
  },
  "apiVersion": "2022-12-01-preview"
}