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
              "y": 2,
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
              "y": 3,
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = ${monitored_apis_kql};\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend primitive = iff(isempty(primitive), iff(isempty(operationId_s), \"ResourceNotFound-404\", operationId_s), primitive)\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        backendUrl_s startswith \"https://${fdr_host}\",\n        \"04 FdR-Fase1\",\n        backendUrl_s startswith \"https://${nodo_host}/wisp\",\n        \"05 WISP Dismantling\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 unknown\"\n    )\n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
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
                  "value": "Routed primitives: Overview - Percentages",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Percentages about all Nodo dei Pagamenti's primitives, grouped by routing backend",
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
                  "Query": "let monitored_apis = ${monitored_apis_kql};\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend primitive = iff(isempty(primitive), iff(isempty(operationId_s), \"ResourceNotFound-404\", operationId_s), primitive)\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        backendUrl_s startswith \"https://${fdr_host}\",\n        \"04 FdR-Fase1\",\n        backendUrl_s startswith \"https://${nodo_host}/wisp\",\n        \"05 WISP Dismantling\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 unknown\"\n    )\n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
                  "PartTitle": "Routed primitives: Overview - Percentages",
                  "PartSubTitle": "Percentages about all Nodo dei Pagamenti's primitives, grouped by routing backend"
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 3,
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = ${monitored_apis_kql};\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend primitive = iff(isempty(primitive), iff(isempty(operationId_s), \"ResourceNotFound-404\", operationId_s), primitive)\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        backendUrl_s startswith \"https://${fdr_host}\",\n        \"04 FdR-Fase1\",\n        backendUrl_s startswith \"https://${nodo_host}/wisp\",\n        \"05 WISP Dismantling\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 unknown\"\n    )\n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc, primitive_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
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
                  "value": "Routed primitives: Overview - Volumes",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes about routing of all Nodo dei Pagamenti's primitives",
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
                  "Query": "let monitored_apis = ${monitored_apis_kql};\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend primitive = iff(isempty(primitive), iff(isempty(operationId_s), \"ResourceNotFound-404\", operationId_s), primitive)\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        backendUrl_s startswith \"https://${fdr_host}\",\n        \"04 FdR-Fase1\",\n        backendUrl_s startswith \"https://${nodo_host}/wisp\",\n        \"05 WISP Dismantling\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 unknown\"\n    )\n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc, primitive_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
                  "PartTitle": "Routed primitives: Overview - Volumes",
                  "PartSubTitle": "Volumes about routing of all Nodo dei Pagamenti's primitives"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 8,
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = ${monitored_apis_kql};\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend primitive = iff(isempty(primitive), iff(isempty(operationId_s), \"ResourceNotFound-404\", operationId_s), primitive)\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )                 \n| where raw_backend_name != \"99 not needed\"\n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
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
                  "value": "Routed primitives: On NDP instances - Percentages",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Percentages about primitives routed on NDP instances",
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
                  "Query": "let monitored_apis = ${monitored_apis_kql};\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend primitive = iff(isempty(primitive), iff(isempty(operationId_s), \"ResourceNotFound-404\", operationId_s), primitive)\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )                 \n| where raw_backend_name != \"99 not needed\"\n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
                  "PartTitle": "Routed primitives: On NDP instances - Percentages",
                  "PartSubTitle": "Percentages about primitives routed on NDP instances"
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 8,
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
                      "${appinsights_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "8f4a5a24-c7c2-4c73-b128-29463313c583",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT30M",
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
                  "value": "let monitored_apis = ${monitored_apis_kql};\nlet backend_stats = dependencies\n    | extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n    | join kind=leftouter monitored_apis on operationId_s\n    | where operationId_s != \"\" and primitive != \"\"\n    | extend response = tostring(customDimensions[\"Response-Body\"])\n    | extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n    | extend raw_backend_name = case ( \n                                    target startswith \"https://${nodo_host}/nodo\",\n                                    \"01 ${pagopa_postgres_id} PagoPA\",\n                                    target startswith \"${nexi_postgres_backend}\",\n                                    \"03 ${nexi_postgres_id} Nexi\",\n                                    \"99 not needed\"\n                                )   \n    | where raw_backend_name !startswith \"99\"\n    | extend backend_name = substring(raw_backend_name, 3)\n    | summarize\n        Total = count(),\n        KO = countif(outcome == \"KO\")\n        by backend_name\n    | project\n        [\"Backend Name\"]=backend_name,\n        [\"Invocations\"]=Total\n;\nbackend_stats\n| union (backend_stats\n    | summarize \n        [\"Backend Name\"] = \"TOTAL\",\n        [\"Total Invocations\"] = sum([\"Invocations\"])\n    )\n| render barchart kind=unstacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "UnstackedBar",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Routed primitives: On NDP instances - Volumes",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes about primitives routed on NDP instances",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "Backend Name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Invocations",
                        "type": "long"
                      },
                      {
                        "name": "Total Invocations",
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
                  "Query": "let monitored_apis = ${monitored_apis_kql};\nlet backend_stats = dependencies\n    | extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n    | join kind=leftouter monitored_apis on operationId_s\n    | where operationId_s != \"\" and primitive != \"\"\n    | extend response = tostring(customDimensions[\"Response-Body\"])\n    | extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n    | extend raw_backend_name = case ( \n                                    target startswith \"https://${nodo_host}/nodo\",\n                                    \"01 ${pagopa_postgres_id} PagoPA\",\n                                    target startswith \"${nexi_postgres_backend}\",\n                                    \"03 ${nexi_postgres_id} Nexi\",\n                                    \"99 not needed\"\n                                )   \n    | where raw_backend_name !startswith \"99\"\n    | extend backend_name = substring(raw_backend_name, 3)\n    | summarize\n        Total = count(),\n        KO = countif(outcome == \"KO\")\n        by backend_name\n    | project\n        [\"Backend Name\"]=backend_name,\n        [\"Invocations\"]=Total\n;\nbackend_stats\n| union (backend_stats\n    | summarize \n        [\"Backend Name\"] = \"TOTAL\",\n        [\"Total Invocations\"] = sum([\"Invocations\"])\n    )\n| render barchart kind=unstacked\n\n",
                  "PartTitle": "Routed primitives: On NDP instances - Volumes",
                  "PartSubTitle": "Volumes about primitives routed on NDP instances",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Backend Name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Invocations",
                        "type": "long"
                      },
                      {
                        "name": "Total Invocations",
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
              "y": 13,
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = ${monitored_apis_kql};\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend primitive = iff(isempty(primitive), iff(isempty(operationId_s), \"ResourceNotFound-404\", operationId_s), primitive)\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| where backendUrl_s == \"\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"01 OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"02 Error: Invalid subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"03 Error: \", lastError_reason_s),\n        \"99 unknown\"\n    )                 \n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Outcome']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n| render piechart\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true,
                  "value": "Pie"
                },
                {
                  "name": "PartTitle",
                  "value": "Routed primitives: Managed by APIM policies - Percentages",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Percentages about outcomes of primitives not routed on backend and managed directly by APIM policies",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true,
                  "value": {
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
                  }
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true,
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  }
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
                  "Query": "let monitored_apis = ${monitored_apis_kql};\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend primitive = iff(isempty(primitive), iff(isempty(operationId_s), \"ResourceNotFound-404\", operationId_s), primitive)\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| where backendUrl_s == \"\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"01 OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"02 Error: Invalid subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"03 Error: \", lastError_reason_s),\n        \"99 unknown\"\n    )                 \n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Outcome']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n| render piechart\n\n",
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
              "y": 13,
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = ${monitored_apis_kql};\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend primitive = iff(isempty(primitive), iff(isempty(operationId_s), \"ResourceNotFound-404\", operationId_s), primitive)\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| where backendUrl_s == \"\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"01 OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"02 Error: Invalid subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"03 Error: \", lastError_reason_s),\n        \"99 Error: Unknown\"\n    )                 \n| where raw_backend_name != \"01 OK\" and raw_backend_name !startswith \"02 Error\"\n| extend backend_name = substring(raw_backend_name, 10)\n| project \n    ['Primitive']=primitive_name, \n    ['Error']=backend_name, \n    ['Status']=responseCode_d, \n    ['Execution time']=strcat(backendTime_d / 1000, \" sec\"), \n    ['Caused by']=lastError_message_s\n\n",
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
                  "value": "Routed primitives: Managed by APIM policies - Error details",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Details about errors of primitives not routed on backend and managed directly by APIM policies",
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
                  "Query": "let monitored_apis = ${monitored_apis_kql};\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend primitive = iff(isempty(primitive), iff(isempty(operationId_s), \"ResourceNotFound-404\", operationId_s), primitive)\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| where backendUrl_s == \"\"\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"01 OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"02 Error: Invalid subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"03 Error: \", lastError_reason_s),\n        \"99 Error: Unknown\"\n    )                 \n| where raw_backend_name != \"01 OK\" and raw_backend_name !startswith \"02 Error\"\n| extend backend_name = substring(raw_backend_name, 10)\n| project \n    ['Primitive']=primitive_name, \n    ['Error']=backend_name, \n    ['Status']=responseCode_d, \n    ['Execution time']=strcat(backendTime_d / 1000, \" sec\"), \n    ['Caused by']=lastError_message_s\n\n",
                  "PartTitle": "Routed primitives: Managed by APIM policies - Error details",
                  "PartSubTitle": "Details about errors of primitives not routed on backend and managed directly by APIM policies"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 18,
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
              "y": 19,
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.verifyPaymentNotice.id}', '${apis.node_for_psp_v1.verifyPaymentNotice.name}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.id}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 Unknown\"\n    )\n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
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
                  "value": "Routed primitives: VerifyPaymentNotice - Percentages",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Percentages about routed verifyPaymentNotice",
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.verifyPaymentNotice.id}', '${apis.node_for_psp_v1.verifyPaymentNotice.name}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.id}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 Unknown\"\n    )\n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
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
              "y": 19,
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.verifyPaymentNotice.id}', '${apis.node_for_psp_v1.verifyPaymentNotice.name}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.id}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend backend_name = case ( \n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"${nexi_postgres_id} Nexi\",\n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"${pagopa_postgres_id} PagoPA\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 Managed by APIM policies: OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 Managed by APIM policies: wrong subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 Managed by APIM policies: \", lastError_reason_s),\n        \"09 Managed by APIM policies: unknown error\"\n    )                   \n| summarize count() by backend_name, primitive_name\n| order by backend_name\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
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
                  "value": "Routed primitives: VerifyPaymentNotice - Volumes",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes about routed verifyPaymentNotice",
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.verifyPaymentNotice.id}', '${apis.node_for_psp_v1.verifyPaymentNotice.name}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.id}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend backend_name = case ( \n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"${nexi_postgres_id} Nexi\",\n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"${pagopa_postgres_id} PagoPA\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 Managed by APIM policies: OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 Managed by APIM policies: wrong subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 Managed by APIM policies: \", lastError_reason_s),\n        \"09 Managed by APIM policies: unknown error\"\n    )                   \n| summarize count() by backend_name, primitive_name\n| order by backend_name\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
                  "PartTitle": "Routed primitives: VerifyPaymentNotice - Volumes",
                  "PartSubTitle": "Volumes about routed verifyPaymentNotice"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 24,
              "colSpan": 18,
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
                      "${appinsights_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.verifyPaymentNotice.id}', '${apis.node_for_psp_v1.verifyPaymentNotice.name}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.id}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.name}'];\nlet backend_stats = dependencies\n    | extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n    | join kind=leftouter monitored_apis on operationId_s\n    | where operationId_s != \"\" and primitive != \"\"\n    | extend response = tostring(customDimensions[\"Response-Body\"])\n    | extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n    | extend raw_backend_name = case ( \n                                    target startswith \"https://${nodo_host}/nodo\",\n                                    \"01 ${pagopa_postgres_id} PagoPA\",\n                                    target startswith \"${nexi_postgres_backend}\",\n                                    \"03 ${nexi_postgres_id} Nexi\",\n                                    \"99 not needed\"\n                                )   \n    | where raw_backend_name !startswith \"99\"\n    | extend backend_name = substring(raw_backend_name, 3)\n    | summarize\n        Total = count(),\n        KO = countif(outcome == \"KO\")\n        by backend_name\n    | project\n        [\"Backend Name\"]=backend_name,\n        [\"Total Responses\"]=Total,\n        [\"OK Responses\"]=Total - KO,\n        [\"KO Responses\"]=KO;\nbackend_stats\n| union (backend_stats\n    | summarize \n        [\"Backend Name\"] = \"TOTAL\",\n        [\"Total Responses\"] = sum([\"Total Responses\"]),\n        [\"OK Responses\"] = sum([\"OK Responses\"]),\n        [\"KO Responses\"] = sum([\"KO Responses\"])\n    )\n| render barchart kind=unstacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "UnstackedBar",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Routed primitives: VerifyPaymentNotice - Error on NDP instances volumes",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes about errors on NDP instances for routed verifyPaymentNotice",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "Backend Name",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "KO Responses",
                        "type": "long"
                      },
                      {
                        "name": "OK Responses",
                        "type": "long"
                      },
                      {
                        "name": "Total Responses",
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.verifyPaymentNotice.id}', '${apis.node_for_psp_v1.verifyPaymentNotice.name}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.id}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.name}'];\nlet backend_stats = dependencies\n    | extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n    | join kind=leftouter monitored_apis on operationId_s\n    | where operationId_s != \"\" and primitive != \"\"\n    | extend response = tostring(customDimensions[\"Response-Body\"])\n    | extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n    | extend raw_backend_name = case ( \n                                    target startswith \"https://${nodo_host}/nodo\",\n                                    \"01 ${pagopa_postgres_id} PagoPA\",\n                                    target startswith \"${nexi_postgres_backend}\",\n                                    \"03 ${nexi_postgres_id} Nexi\",\n                                    \"99 not needed\"\n                                )   \n    | where raw_backend_name !startswith \"99\"\n    | extend backend_name = substring(raw_backend_name, 3)\n    | summarize\n        Total = count(),\n        KO = countif(outcome == \"KO\")\n        by backend_name\n    | project\n        [\"Backend Name\"]=backend_name,\n        [\"Total Responses\"]=Total,\n        [\"OK Responses\"]=Total - KO,\n        [\"KO Responses\"]=KO;\nbackend_stats\n| union (backend_stats\n    | summarize \n        [\"Backend Name\"] = \"TOTAL\",\n        [\"Total Responses\"] = sum([\"Total Responses\"]),\n        [\"OK Responses\"] = sum([\"OK Responses\"]),\n        [\"KO Responses\"] = sum([\"KO Responses\"])\n    )\n| render barchart kind=unstacked\n\n",
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
                        "name": "KO Responses",
                        "type": "long"
                      },
                      {
                        "name": "OK Responses",
                        "type": "long"
                      },
                      {
                        "name": "Total Responses",
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
              "y": 29,
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
                      "${appinsights_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.verifyPaymentNotice.id}', '${apis.node_for_psp_v1.verifyPaymentNotice.name}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.id}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\", \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\", \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Responses\"] = countif(outcome == \"KO\") by bin(timestamp, 1m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n\n",
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
                  "value": "Routed primitives: VerifyPaymentNotice - Error on NDP instances during time",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes divided by time about errors on NDP instances for routed verifyPaymentNotice",
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.verifyPaymentNotice.id}', '${apis.node_for_psp_v1.verifyPaymentNotice.name}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.id}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\", \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\", \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Responses\"] = countif(outcome == \"KO\") by bin(timestamp, 1m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n\n",
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
              "y": 29,
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
                      "${appinsights_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.verifyPaymentNotice.id}', '${apis.node_for_psp_v1.verifyPaymentNotice.name}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.id}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where customDimensions[\"Response-Body\"] contains \"<fault>\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fault_code = extract(\"<faultCode>(.*?)</faultCode>\", 1, response),\n         fault_string = extract(\"<faultString>(.*?)</faultString>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Fault Code\"] = fault_code\n| summarize Count = count() by [\"Fault Code\"], backend_name\n| top 20 by Count desc\n| render columnchart kind=unstacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "UnstackedColumn",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Routed primitives: VerifyPaymentNotice - Error on NDP instances details",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Details about errors on NDP instances for routed verifyPaymentNotice",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.verifyPaymentNotice.id}', '${apis.node_for_psp_v1.verifyPaymentNotice.name}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.id}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where customDimensions[\"Response-Body\"] contains \"<fault>\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fault_code = extract(\"<faultCode>(.*?)</faultCode>\", 1, response),\n         fault_string = extract(\"<faultString>(.*?)</faultString>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Fault Code\"] = fault_code\n| summarize Count = count() by [\"Fault Code\"], backend_name\n| top 20 by Count desc\n| render columnchart kind=unstacked\n\n",
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
              "y": 34,
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
                      "${appinsights_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "5bdf835f-192a-4001-8815-ef8493812088",
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.verifyPaymentNotice.id}', '${apis.node_for_psp_v1.verifyPaymentNotice.name}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.id}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n                                target startswith \"https://${nodo_host}/nodo\",\n                                \"01 ${pagopa_postgres_id} PagoPA\",\n                                target startswith \"${nexi_postgres_backend}\",\n                                \"03 ${nexi_postgres_id} Nexi\",\n                                \"99 not needed\"\n                            )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Timestamp\"] = timestamp\n| summarize [\"Average Duration (ms)\"] = avg(duration) by bin([\"Timestamp\"], 1m), [\"Backend Name\"]=backend_name\n| order by [\"Timestamp\"] asc\n| render timechart\n\n",
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
                  "value": "Routed primitives: VerifyPaymentNotice - Average time duration on NDP instances",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Average elapsed time on NDP instances for routed verifyPaymentNotice",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "Timestamp",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "Average Duration (ms)",
                        "type": "real"
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.verifyPaymentNotice.id}', '${apis.node_for_psp_v1.verifyPaymentNotice.name}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.id}', '${apis.node_for_psp_v1_noauth.verifyPaymentNotice.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n                                target startswith \"https://${nodo_host}/nodo\",\n                                \"01 ${pagopa_postgres_id} PagoPA\",\n                                target startswith \"${nexi_postgres_backend}\",\n                                \"03 ${nexi_postgres_id} Nexi\",\n                                \"99 not needed\"\n                            )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Timestamp\"] = timestamp\n| summarize [\"Average Duration (ms)\"] = avg(duration) by bin([\"Timestamp\"], 1m), [\"Backend Name\"]=backend_name\n| order by [\"Timestamp\"] asc\n| render timechart\n\n",
                  "PartTitle": "Routed primitives: VerifyPaymentNotice - Average time duration on NDP instances",
                  "PartSubTitle": "Average elapsed time on NDP instances for routed verifyPaymentNotice"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 39,
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
              "y": 40,
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.activatePaymentNotice.id}', '${apis.node_for_psp_v1.activatePaymentNotice.name}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 Unknown\"\n    )     \n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
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
                  "value": "Routed primitives: ActivatePaymentNotice - Percentages",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Percentages about routed activatePaymentNotice and activatePaymentNoticeV2",
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.activatePaymentNotice.id}', '${apis.node_for_psp_v1.activatePaymentNotice.name}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 Unknown\"\n    )     \n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
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
              "y": 40,
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.activatePaymentNotice.id}', '${apis.node_for_psp_v1.activatePaymentNotice.name}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 Managed by APIM policies: OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 Managed by APIM policies: wrong subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 Managed by APIM policies: \", lastError_reason_s),\n        \"99 Managed by APIM policies: unknown error\"\n    )     \n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
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
                  "value": "Routed primitives: ActivatePaymentNotice - Volumes",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes about routed activatePaymentNotice and activatePaymentNoticeV2",
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.activatePaymentNotice.id}', '${apis.node_for_psp_v1.activatePaymentNotice.name}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 Managed by APIM policies: OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 Managed by APIM policies: wrong subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 Managed by APIM policies: \", lastError_reason_s),\n        \"99 Managed by APIM policies: unknown error\"\n    )     \n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
                  "PartTitle": "Routed primitives: ActivatePaymentNotice - Volumes",
                  "PartSubTitle": "Volumes about routed activatePaymentNotice and activatePaymentNoticeV2"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 45,
              "colSpan": 18,
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
                      "${appinsights_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.activatePaymentNotice.id}', '${apis.node_for_psp_v1.activatePaymentNotice.name}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.name}'];\nlet backend_stats = dependencies\n    | extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n    | join kind=leftouter monitored_apis on operationId_s\n    | where operationId_s != \"\" and primitive != \"\"\n    | extend response = tostring(customDimensions[\"Response-Body\"])\n    | extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n    | extend raw_backend_name = case ( \n                                    target startswith \"https://${nodo_host}/nodo\",\n                                    \"01 ${pagopa_postgres_id} PagoPA\",\n                                    target startswith \"${nexi_postgres_backend}\",\n                                    \"03 ${nexi_postgres_id} Nexi\",\n                                    \"99 not needed\"\n                                )   \n    | where raw_backend_name !startswith \"99\"\n    | extend backend_name = substring(raw_backend_name, 3)\n    | summarize\n        Total = count(),\n        KO = countif(outcome == \"KO\")\n        by backend_name\n    | project\n        [\"Backend Name\"]=backend_name,\n        [\"Total Responses\"]=Total,\n        [\"OK Responses\"]=Total - KO,\n        [\"KO Responses\"]=KO;\nbackend_stats\n| union (backend_stats\n    | summarize \n        [\"Backend Name\"] = \"TOTAL\",\n        [\"Total Responses\"] = sum([\"Total Responses\"]),\n        [\"OK Responses\"] = sum([\"OK Responses\"]),\n        [\"KO Responses\"] = sum([\"KO Responses\"])\n    )\n| render barchart kind=unstacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "UnstackedBar",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Routed primitives: ActivatePaymentNotice - Error on NDP instances volumes",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes about errors on NDP instances for routed activatePaymentNotice and activatePaymentNoticeV2",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.activatePaymentNotice.id}', '${apis.node_for_psp_v1.activatePaymentNotice.name}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.name}'];\nlet backend_stats = dependencies\n    | extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n    | join kind=leftouter monitored_apis on operationId_s\n    | where operationId_s != \"\" and primitive != \"\"\n    | extend response = tostring(customDimensions[\"Response-Body\"])\n    | extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n    | extend raw_backend_name = case ( \n                                    target startswith \"https://${nodo_host}/nodo\",\n                                    \"01 ${pagopa_postgres_id} PagoPA\",\n                                    target startswith \"${nexi_postgres_backend}\",\n                                    \"03 ${nexi_postgres_id} Nexi\",\n                                    \"99 not needed\"\n                                )   \n    | where raw_backend_name !startswith \"99\"\n    | extend backend_name = substring(raw_backend_name, 3)\n    | summarize\n        Total = count(),\n        KO = countif(outcome == \"KO\")\n        by backend_name\n    | project\n        [\"Backend Name\"]=backend_name,\n        [\"Total Responses\"]=Total,\n        [\"OK Responses\"]=Total - KO,\n        [\"KO Responses\"]=KO;\nbackend_stats\n| union (backend_stats\n    | summarize \n        [\"Backend Name\"] = \"TOTAL\",\n        [\"Total Responses\"] = sum([\"Total Responses\"]),\n        [\"OK Responses\"] = sum([\"OK Responses\"]),\n        [\"KO Responses\"] = sum([\"KO Responses\"])\n    )\n| render barchart kind=unstacked\n\n",
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
              "y": 50,
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
                      "${appinsights_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.activatePaymentNotice.id}', '${apis.node_for_psp_v1.activatePaymentNotice.name}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\", \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\", \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Responses\"] = countif(outcome == \"KO\") by bin(timestamp, 1m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n\n",
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
                  "value": "Routed primitives: ActivatePaymentNotice - Error on NDP instances during time",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes divided by time about errors on NDP instances for routed activatePaymentNotice and activatePaymentNoticeV2",
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.activatePaymentNotice.id}', '${apis.node_for_psp_v1.activatePaymentNotice.name}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\", \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\", \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Responses\"] = countif(outcome == \"KO\") by bin(timestamp, 1m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n\n",
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
              "y": 50,
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
                      "${appinsights_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.activatePaymentNotice.id}', '${apis.node_for_psp_v1.activatePaymentNotice.name}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where customDimensions[\"Response-Body\"] contains \"<fault>\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fault_code = extract(\"<faultCode>(.*?)</faultCode>\", 1, response),\n         fault_string = extract(\"<faultString>(.*?)</faultString>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Fault Code\"] = fault_code\n| summarize Count = count() by [\"Fault Code\"], backend_name\n| top 20 by Count desc\n| render columnchart kind=unstacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "UnstackedColumn",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Routed primitives: ActivatePaymentNotice - Error on NDP instances details",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Details about errors on NDP instances for routed activatePaymentNotice and activatePaymentNoticeV2",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.activatePaymentNotice.id}', '${apis.node_for_psp_v1.activatePaymentNotice.name}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where customDimensions[\"Response-Body\"] contains \"<fault>\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fault_code = extract(\"<faultCode>(.*?)</faultCode>\", 1, response),\n         fault_string = extract(\"<faultString>(.*?)</faultString>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Fault Code\"] = fault_code\n| summarize Count = count() by [\"Fault Code\"], backend_name\n| top 20 by Count desc\n| render columnchart kind=unstacked\n\n",
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
                      "${appinsights_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "7839f359-6981-4fd1-a845-f29c26c5ce02",
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.activatePaymentNotice.id}', '${apis.node_for_psp_v1.activatePaymentNotice.name}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend raw_backend_name = case ( \n                                target startswith \"https://${nodo_host}/nodo\",\n                                \"01 ${pagopa_postgres_id} PagoPA\",\n                                target startswith \"${nexi_postgres_backend}\",\n                                \"03 ${nexi_postgres_id} Nexi\",\n                                \"99 not needed\"\n                            )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Timestamp\"] = timestamp\n| summarize [\"Average Duration (ms)\"] = avg(duration) by bin([\"Timestamp\"], 1m), [\"Backend Name\"]=backend_name\n| order by [\"Timestamp\"] asc\n| render timechart\n\n",
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
                  "value": "Routed primitives: ActivatePaymentNotice - Average time duration on NDP instances",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Average elapsed time on NDP instances for routed activatePaymentNoticeV2",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "Timestamp",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "Average Duration (ms)",
                        "type": "real"
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.activatePaymentNotice.id}', '${apis.node_for_psp_v1.activatePaymentNotice.name}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1.activatePaymentNoticeV2.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNotice.name}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.id}', '${apis.node_for_psp_v1_noauth.activatePaymentNoticeV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend raw_backend_name = case ( \n                                target startswith \"https://${nodo_host}/nodo\",\n                                \"01 ${pagopa_postgres_id} PagoPA\",\n                                target startswith \"${nexi_postgres_backend}\",\n                                \"03 ${nexi_postgres_id} Nexi\",\n                                \"99 not needed\"\n                            )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Timestamp\"] = timestamp\n| summarize [\"Average Duration (ms)\"] = avg(duration) by bin([\"Timestamp\"], 1m), [\"Backend Name\"]=backend_name\n| order by [\"Timestamp\"] asc\n| render timechart\n\n",
                  "PartTitle": "Routed primitives: ActivatePaymentNotice - Average time duration on NDP instances",
                  "PartSubTitle": "Average elapsed time on NDP instances for routed activatePaymentNoticeV2"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 60,
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
              "y": 61,
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_ecommerce_v2.closePaymentV2.id}', '${apis.node_for_ecommerce_v2.closePaymentV2.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 Unknown\"\n    )     \n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n",
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
                  "value": "Routed primitives: ClosePaymentV2 - Percentages",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Percentages about routed closePaymentV2",
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_ecommerce_v2.closePaymentV2.id}', '${apis.node_for_ecommerce_v2.closePaymentV2.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 Unknown\"\n    )     \n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n",
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
              "y": 61,
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_ecommerce_v2.closePaymentV2.id}', '${apis.node_for_ecommerce_v2.closePaymentV2.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 Managed by APIM policies: OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 Managed by APIM policies: wrong subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 Managed by APIM policies: \", lastError_reason_s),\n        \"99 Managed by APIM policies: unknown error\"\n    )     \n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
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
                  "value": "Routed primitives: ClosePaymentV2 - Volumes",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes about routed closePaymentV2",
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_ecommerce_v2.closePaymentV2.id}', '${apis.node_for_ecommerce_v2.closePaymentV2.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 Managed by APIM policies: OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 Managed by APIM policies: wrong subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 Managed by APIM policies: \", lastError_reason_s),\n        \"99 Managed by APIM policies: unknown error\"\n    )     \n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
                  "PartTitle": "Routed primitives: ClosePaymentV2 - Volumes",
                  "PartSubTitle": "Volumes about routed closePaymentV2"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 66,
              "colSpan": 18,
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
                      "${appinsights_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_ecommerce_v2.closePaymentV2.id}', '${apis.node_for_ecommerce_v2.closePaymentV2.name}'];\nlet backend_stats = dependencies\n    | extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n    | join kind=leftouter monitored_apis on operationId_s\n    | where operationId_s != \"\" and primitive != \"\"\n    | extend response = parse_json(tostring(customDimensions[\"Response-Body\"])) \n    | extend outcome = response[\"outcome\"]\n    | extend raw_backend_name = case ( \n                                    target startswith \"https://${nodo_host}/nodo\",\n                                    \"01 ${pagopa_postgres_id} PagoPA\",\n                                    target startswith \"${nexi_postgres_backend}\",\n                                    \"03 ${nexi_postgres_id} Nexi\",\n                                    \"99 not needed\"\n                                )   \n    | where raw_backend_name !startswith \"99\"\n    | extend backend_name = substring(raw_backend_name, 3)\n    | summarize\n        Total = count(),\n        KO = countif(outcome == \"KO\")\n        by backend_name\n    | project\n        [\"Backend Name\"]=backend_name,\n        [\"Total Responses\"]=Total,\n        [\"OK Responses\"]=Total - KO,\n        [\"KO Responses\"]=KO;\nbackend_stats\n| union (backend_stats\n    | summarize \n        [\"Backend Name\"] = \"TOTAL\",\n        [\"Total Responses\"] = sum([\"Total Responses\"]),\n        [\"OK Responses\"] = sum([\"OK Responses\"]),\n        [\"KO Responses\"] = sum([\"KO Responses\"])\n    )\n| render barchart kind=unstacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "UnstackedBar",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Routed primitives: ClosePaymentV2 - Error on NDP instances volumes",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes about errors on NDP instances for routed closePaymentV2",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_ecommerce_v2.closePaymentV2.id}', '${apis.node_for_ecommerce_v2.closePaymentV2.name}'];\nlet backend_stats = dependencies\n    | extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n    | join kind=leftouter monitored_apis on operationId_s\n    | where operationId_s != \"\" and primitive != \"\"\n    | extend response = parse_json(tostring(customDimensions[\"Response-Body\"])) \n    | extend outcome = response[\"outcome\"]\n    | extend raw_backend_name = case ( \n                                    target startswith \"https://${nodo_host}/nodo\",\n                                    \"01 ${pagopa_postgres_id} PagoPA\",\n                                    target startswith \"${nexi_postgres_backend}\",\n                                    \"03 ${nexi_postgres_id} Nexi\",\n                                    \"99 not needed\"\n                                )   \n    | where raw_backend_name !startswith \"99\"\n    | extend backend_name = substring(raw_backend_name, 3)\n    | summarize\n        Total = count(),\n        KO = countif(outcome == \"KO\")\n        by backend_name\n    | project\n        [\"Backend Name\"]=backend_name,\n        [\"Total Responses\"]=Total,\n        [\"OK Responses\"]=Total - KO,\n        [\"KO Responses\"]=KO;\nbackend_stats\n| union (backend_stats\n    | summarize \n        [\"Backend Name\"] = \"TOTAL\",\n        [\"Total Responses\"] = sum([\"Total Responses\"]),\n        [\"OK Responses\"] = sum([\"OK Responses\"]),\n        [\"KO Responses\"] = sum([\"KO Responses\"])\n    )\n| render barchart kind=unstacked\n\n",
                  "SpecificChart": "UnstackedBar",
                  "PartTitle": "Routed primitives: ClosePaymentV2 - Error on NDP instances volumes",
                  "PartSubTitle": "Volumes about errors on NDP instances for routed closePaymentV2",
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
              "y": 71,
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
                      "${appinsights_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_ecommerce_v2.closePaymentV2.id}', '${apis.node_for_ecommerce_v2.closePaymentV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = parse_json(tostring(customDimensions[\"Response-Body\"]))\n| extend outcome = response[\"outcome\"]\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\", \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\", \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Responses\"] = countif(outcome == \"KO\") by bin(timestamp, 1m), [\"Backend Name\"] = backend_name\n| order by timestamp asc\n| render timechart\n\n",
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
                  "value": "Routed primitives: ClosePaymentV2 - Error on NDP instances during time",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes divided by time about errors on NDP instances for routed closePaymentV2",
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_ecommerce_v2.closePaymentV2.id}', '${apis.node_for_ecommerce_v2.closePaymentV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = parse_json(tostring(customDimensions[\"Response-Body\"]))\n| extend outcome = response[\"outcome\"]\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\", \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\", \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Responses\"] = countif(outcome == \"KO\") by bin(timestamp, 1m), [\"Backend Name\"] = backend_name\n| order by timestamp asc\n| render timechart\n\n",
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
              "y": 71,
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
                      "${appinsights_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_ecommerce_v2.closePaymentV2.id}', '${apis.node_for_ecommerce_v2.closePaymentV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where toint(resultCode) >= 300\n| extend [\"HTTP Status\"] = resultCode\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize Count = count() by [\"HTTP Status\"], backend_name\n| top 20 by Count desc\n| render columnchart kind=unstacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "UnstackedColumn",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Routed primitives: ClosePaymentV2 - Error on NDP instances details",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Details about errors on NDP instances for routed closePaymentV2",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_ecommerce_v2.closePaymentV2.id}', '${apis.node_for_ecommerce_v2.closePaymentV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where toint(resultCode) >= 300\n| extend [\"HTTP Status\"] = resultCode\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize Count = count() by [\"HTTP Status\"], backend_name\n| top 20 by Count desc\n| render columnchart kind=unstacked\n\n",
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
              "y": 76,
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
                      "${appinsights_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "7839f359-6981-4fd1-a845-f29c26c5ce02",
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_ecommerce_v2.closePaymentV2.id}', '${apis.node_for_ecommerce_v2.closePaymentV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend raw_backend_name = case ( \n                                target startswith \"https://${nodo_host}/nodo\",\n                                \"01 ${pagopa_postgres_id} PagoPA\",\n                                target startswith \"${nexi_postgres_backend}\",\n                                \"03 ${nexi_postgres_id} Nexi\",\n                                \"99 not needed\"\n                            )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Timestamp\"] = timestamp\n| summarize [\"Average Duration (ms)\"] = avg(duration) by bin([\"Timestamp\"], 1m), [\"Backend Name\"]=backend_name\n| order by [\"Timestamp\"] asc\n| render timechart\n\n",
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
                  "value": "Routed primitives: ClosePaymentV2 - Average time duration on NDP instances",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Average elapsed time on NDP instances for routed closePaymentV2",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "Timestamp",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "Average Duration (ms)",
                        "type": "real"
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_ecommerce_v2.closePaymentV2.id}', '${apis.node_for_ecommerce_v2.closePaymentV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend raw_backend_name = case ( \n                                target startswith \"https://${nodo_host}/nodo\",\n                                \"01 ${pagopa_postgres_id} PagoPA\",\n                                target startswith \"${nexi_postgres_backend}\",\n                                \"03 ${nexi_postgres_id} Nexi\",\n                                \"99 not needed\"\n                            )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Timestamp\"] = timestamp\n| summarize [\"Average Duration (ms)\"] = avg(duration) by bin([\"Timestamp\"], 1m), [\"Backend Name\"]=backend_name\n| order by [\"Timestamp\"] asc\n| render timechart\n\n",
                  "PartTitle": "Routed primitives: ClosePaymentV2 - Average time duration on NDP instances",
                  "PartSubTitle": "Average elapsed time on NDP instances for routed closePaymentV2"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 81,
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.sendPaymentOutcome.id}', '${apis.node_for_psp_v1.sendPaymentOutcome.name}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 Unknown\"\n    )     \n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
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
                  "value": "Routed primitives: SendPaymentOutcome - Percentages",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Percentages about routed sendPaymentOutcome and sendPaymentOutcomeV2",
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.sendPaymentOutcome.id}', '${apis.node_for_psp_v1.sendPaymentOutcome.name}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\"),\n        \"06 Managed by APIM policies\",\n        \"99 Unknown\"\n    )     \n| summarize Count = count() by raw_backend_name\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend'] = backend_name, Count\n| render piechart\n\n",
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.sendPaymentOutcome.id}', '${apis.node_for_psp_v1.sendPaymentOutcome.name}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 Managed by APIM policies: OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 Managed by APIM policies: wrong subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 Managed by APIM policies: \", lastError_reason_s),\n        \"99 Managed by APIM policies: unknown error\"\n    )     \n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
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
                  "value": "Routed primitives: SendPaymentOutcome - Volumes",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes about routed sendPaymentOutcome and sendPaymentOutcomeV2",
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.sendPaymentOutcome.id}', '${apis.node_for_psp_v1.sendPaymentOutcome.name}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.name}'];\nAzureDiagnostics\n| join kind=leftouter monitored_apis on operationId_s\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| where operationId_s in (monitored_apis | project operationId_s)\n| extend primitive_name = case (is_auth, strcat(primitive, \" (Auth)\"), primitive)\n| extend raw_backend_name = case ( \n        backendUrl_s startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        backendUrl_s startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        (backendUrl_s == \"\" and responseCode_d == 200),\n        \"06 Managed by APIM policies: OK\",\n        (backendUrl_s == \"\" and responseCode_d == 401),\n        \"07 Managed by APIM policies: wrong subscription key\",\n        (backendUrl_s == \"\" and lastError_reason_s != \"\"),\n        strcat(\"08 Managed by APIM policies: \", lastError_reason_s),\n        \"99 Managed by APIM policies: unknown error\"\n    )     \n| summarize count() by raw_backend_name, primitive_name\n| order by raw_backend_name asc\n| extend backend_name = substring(raw_backend_name, 3)\n| project ['Routed Backend']=backend_name, ['Primitive']=primitive_name, ['Count']=count_\n\n",
                  "PartTitle": "Routed primitives: SendPaymentOutcome - Volumes",
                  "PartSubTitle": "Volumes about routed sendPaymentOutcome and sendPaymentOutcomeV2"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 87,
              "colSpan": 18,
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
                      "${appinsights_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.sendPaymentOutcome.id}', '${apis.node_for_psp_v1.sendPaymentOutcome.name}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.name}'];\nlet backend_stats = dependencies\n    | extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n    | join kind=leftouter monitored_apis on operationId_s\n    | where operationId_s != \"\" and primitive != \"\"\n    | extend response = tostring(customDimensions[\"Response-Body\"])\n    | extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n    | extend raw_backend_name = case ( \n                                    target startswith \"https://${nodo_host}/nodo\",\n                                    \"01 ${pagopa_postgres_id} PagoPA\",\n                                    target startswith \"${nexi_postgres_backend}\",\n                                    \"03 ${nexi_postgres_id} Nexi\",\n                                    \"99 not needed\"\n                                )   \n    | where raw_backend_name !startswith \"99\"\n    | extend backend_name = substring(raw_backend_name, 3)\n    | summarize\n        Total = count(),\n        KO = countif(outcome == \"KO\")\n        by backend_name\n    | project\n        [\"Backend Name\"]=backend_name,\n        [\"Total Responses\"]=Total,\n        [\"OK Responses\"]=Total - KO,\n        [\"KO Responses\"]=KO;\nbackend_stats\n| union (backend_stats\n    | summarize \n        [\"Backend Name\"] = \"TOTAL\",\n        [\"Total Responses\"] = sum([\"Total Responses\"]),\n        [\"OK Responses\"] = sum([\"OK Responses\"]),\n        [\"KO Responses\"] = sum([\"KO Responses\"])\n    )\n| render barchart kind=unstacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "UnstackedBar",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Routed primitives: SendPaymentOutcome - Error on NDP instances volumes",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes about errors on NDP instances for routed sendPaymentOutcome and sendPaymentOutcomeV2",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.sendPaymentOutcome.id}', '${apis.node_for_psp_v1.sendPaymentOutcome.name}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.name}'];\nlet backend_stats = dependencies\n    | extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n    | join kind=leftouter monitored_apis on operationId_s\n    | where operationId_s != \"\" and primitive != \"\"\n    | extend response = tostring(customDimensions[\"Response-Body\"])\n    | extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n    | extend raw_backend_name = case ( \n                                    target startswith \"https://${nodo_host}/nodo\",\n                                    \"01 ${pagopa_postgres_id} PagoPA\",\n                                    target startswith \"${nexi_postgres_backend}\",\n                                    \"03 ${nexi_postgres_id} Nexi\",\n                                    \"99 not needed\"\n                                )   \n    | where raw_backend_name !startswith \"99\"\n    | extend backend_name = substring(raw_backend_name, 3)\n    | summarize\n        Total = count(),\n        KO = countif(outcome == \"KO\")\n        by backend_name\n    | project\n        [\"Backend Name\"]=backend_name,\n        [\"Total Responses\"]=Total,\n        [\"OK Responses\"]=Total - KO,\n        [\"KO Responses\"]=KO;\nbackend_stats\n| union (backend_stats\n    | summarize \n        [\"Backend Name\"] = \"TOTAL\",\n        [\"Total Responses\"] = sum([\"Total Responses\"]),\n        [\"OK Responses\"] = sum([\"OK Responses\"]),\n        [\"KO Responses\"] = sum([\"KO Responses\"])\n    )\n| render barchart kind=unstacked\n\n",
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
              "y": 92,
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
                      "${appinsights_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.sendPaymentOutcome.id}', '${apis.node_for_psp_v1.sendPaymentOutcome.name}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\", \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\", \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Responses\"] = countif(outcome == \"KO\") by bin(timestamp, 1m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n\n",
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
                  "value": "Routed primitives: SendPaymentOutcome - Error on NDP instances during time",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Volumes divided by time about errors on NDP instances for routed sendPaymentOutcome and sendPaymentOutcomeV2",
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.sendPaymentOutcome.id}', '${apis.node_for_psp_v1.sendPaymentOutcome.name}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\", \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\", \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| summarize [\"KO Responses\"] = countif(outcome == \"KO\") by bin(timestamp, 1m), [\"Backend Name\"]=backend_name\n| order by timestamp asc\n| render timechart\n\n",
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
              "y": 92,
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
                      "${appinsights_id}"
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.sendPaymentOutcome.id}', '${apis.node_for_psp_v1.sendPaymentOutcome.name}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where customDimensions[\"Response-Body\"] contains \"<fault>\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fault_code = extract(\"<faultCode>(.*?)</faultCode>\", 1, response),\n         fault_string = extract(\"<faultString>(.*?)</faultString>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Fault Code\"] = fault_code\n| summarize Count = count() by [\"Fault Code\"], backend_name\n| top 20 by Count desc\n| render columnchart kind=unstacked\n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "UnstackedColumn",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Routed primitives: SendPaymentOutcome - Error on NDP instances details",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Details about errors on NDP instances for routed sendPaymentOutcome and sendPaymentOutcomeV2",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.sendPaymentOutcome.id}', '${apis.node_for_psp_v1.sendPaymentOutcome.name}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| where customDimensions[\"Response-Body\"] contains \"<fault>\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend fault_code = extract(\"<faultCode>(.*?)</faultCode>\", 1, response),\n         fault_string = extract(\"<faultString>(.*?)</faultString>\", 1, response)\n| extend raw_backend_name = case ( \n        target startswith \"https://${nodo_host}/nodo\",\n        \"01 ${pagopa_postgres_id} PagoPA\",\n        target startswith \"${nexi_postgres_backend}\",\n        \"03 ${nexi_postgres_id} Nexi\",\n        \"99 not needed\"\n    )   \n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Fault Code\"] = fault_code\n| summarize Count = count() by [\"Fault Code\"], backend_name\n| top 20 by Count desc\n| render columnchart kind=unstacked\n\n",
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
              "y": 97,
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
                      "${appinsights_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "122262b6-152c-4eff-8645-0aeb92810e5b",
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
                  "value": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.sendPaymentOutcome.id}', '${apis.node_for_psp_v1.sendPaymentOutcome.name}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n                                target startswith \"https://${nodo_host}/nodo\",\n                                \"01 ${pagopa_postgres_id} PagoPA\",\n                                target startswith \"${nexi_postgres_backend}\",\n                                \"03 ${nexi_postgres_id} Nexi\",\n                                \"99 not needed\"\n                            )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Timestamp\"] = timestamp\n| summarize [\"Average Duration (ms)\"] = avg(duration) by bin([\"Timestamp\"], 1m), [\"Backend Name\"]=backend_name\n| order by [\"Timestamp\"] asc\n| render timechart\n\n",
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
                  "value": "Routed primitives: SendPaymentOutcome - Average time duration on NDP instances",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Average elapsed time on NDP instances for routed sendPaymentOutcome and sendPaymentOutcomeV2",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "Timestamp",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "Average Duration (ms)",
                        "type": "real"
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
                  "Query": "let monitored_apis = datatable(operationId_s: string, primitive: string)['${apis.node_for_psp_v1.sendPaymentOutcome.id}', '${apis.node_for_psp_v1.sendPaymentOutcome.name}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1.sendPaymentOutcomeV2.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcome.name}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.id}', '${apis.node_for_psp_v1_noauth.sendPaymentOutcomeV2.name}'];\ndependencies\n| extend operationId_s = tostring(split(operation_Name, \" - \")[1])\n| join kind=leftouter monitored_apis on operationId_s\n| where operationId_s != \"\" and primitive != \"\"\n| extend response = tostring(customDimensions[\"Response-Body\"])\n| extend outcome = extract(\"<outcome>(.*?)</outcome>\", 1, response)\n| extend raw_backend_name = case ( \n                                target startswith \"https://${nodo_host}/nodo\",\n                                \"01 ${pagopa_postgres_id} PagoPA\",\n                                target startswith \"${nexi_postgres_backend}\",\n                                \"03 ${nexi_postgres_id} Nexi\",\n                                \"99 not needed\"\n                            )\n| where raw_backend_name !startswith \"99\"\n| extend backend_name = substring(raw_backend_name, 3)\n| extend [\"Timestamp\"] = timestamp\n| summarize [\"Average Duration (ms)\"] = avg(duration) by bin([\"Timestamp\"], 1m), [\"Backend Name\"]=backend_name\n| order by [\"Timestamp\"] asc\n| render timechart\n\n",
                  "PartTitle": "Routed primitives: SendPaymentOutcome - Average time duration on NDP instances",
                  "PartSubTitle": "Average elapsed time on NDP instances for routed sendPaymentOutcome and sendPaymentOutcomeV2",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Timestamp",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "Average Duration (ms)",
                        "type": "real"
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
              "x": 0,
              "y": 102,
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
              "y": 103,
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
                      "${apim_id}"
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
                  "value": "let monitored_apis = ${monitored_apis_kql};\nlet api_counts = AzureDiagnostics\n| join kind=inner (monitored_apis) on operationId_s\n| summarize Count = count() by primitive;\nmonitored_apis\n| summarize any(deprecated) by primitive\n| join kind=leftouter (api_counts) on primitive\n| extend Count = coalesce(Count, 0)\n| order by Count desc, primitive asc\n| project ['Primitive name'] = primitive, ['Deprecated'] = any_deprecated, Count\n\n",
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
                  "value": "Invoked primitives: Deprecation - Details",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Details about deprecated and not-deprecated primitives, invoked in the defined time slot",
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
                  "Query": "let monitored_apis = ${monitored_apis_kql};\nlet api_counts = AzureDiagnostics\n| join kind=inner (monitored_apis) on operationId_s\n| summarize Count = count() by primitive;\nmonitored_apis\n| summarize any(deprecated) by primitive\n| join kind=leftouter (api_counts) on primitive\n| extend Count = coalesce(Count, 0)\n| order by Count desc, primitive asc\n| project ['Primitive name'] = primitive, ['Deprecated'] = any_deprecated, Count\n\n",
                  "PartTitle": "Invoked primitives: Deprecation - Details",
                  "PartSubTitle": "Details about deprecated and not-deprecated primitives, invoked in the defined time slot"
                }
              }
            }
          },
          {
            "position": {
              "x": 9,
              "y": 103,
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
                      "${apim_id}"
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
                  "value": "AzureDiagnostics\n| where operationId_s in (${all_operation_ids})\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| summarize Count=count() by is_auth\n| extend type = case(is_auth, \"Auth\", \"Non-Auth\")\n| project [\"Is on Auth\"]=type, Count\n| render piechart\n",
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
                  "value": "Invoked primitives: Auth - Percentage",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "Percentage about usage of Auth primitives (i.e. the ones that require subscription key) ",
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
                  "PartSubTitle": "Percentage about usage of Auth primitives (i.e. the ones that require subscription key) ",
                  "Query": "AzureDiagnostics\n| where operationId_s in (${all_operation_ids})\n| extend is_auth = url_s contains \"/nodo-auth/\"\n| summarize Count=count() by is_auth\n| extend type = case(is_auth, \"Auth\", \"Non-Auth\")\n| project [\"Is on Auth\"]=type, Count\n| render piechart\n"
                }
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 108,
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
              "y": 109,
              "colSpan": 18,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "content": "# Enhanced dashboard [on Grafana](https://pagopa-p-weu-grafana-avb5f4e0fqawgyea.weu.grafana.azure.com/d/aepmv9bibr0u8c/preview-manual-ndp-transactions-monitoring?orgId=1&var-domainIdSearchFilter=&var-noticeNumberSearchFilter=&var-paymentTokenSearchFilter=&var-verifiedOnInstance=No%20filter&var-activatedOnInstance=No%20filter&from=now-30m&to=now)\n",
                  "title": "",
                  "subtitle": "",
                  "markdownSource": 1,
                  "markdownUri": ""
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
                "relative": "30m"
              },
              "displayCache": {
                "name": "Local Time",
                "value": "Past 30 minutes"
              },
              "filteredPartIds": [
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3017",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3019",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf301b",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf301d",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf301f",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3021",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3025",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3027",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3029",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf302b",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf302d",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf302f",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3033",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3035",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3037",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3039",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf303b",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf303d",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3041",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3043",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3045",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3047",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3049",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf304b",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf304f",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3051",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3053",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3055",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3057",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3059",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf305d",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf305f",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3065",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3249",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf32fd",
                "StartboardPart-LogsDashboardPart-185612aa-c355-450f-8a31-bd28ccbf3335"
              ]
            }
          }
        }
      }
    }
  },
  "name": "opex_pagopa-multi-node-monitoring-ndp",
  "type": "Microsoft.Portal/dashboards",
  "location": "INSERT LOCATION",
  "tags": {
    "hidden-title": "Multi-node monitoring - NDP"
  },
  "apiVersion": "2022-12-01-preview"
}
