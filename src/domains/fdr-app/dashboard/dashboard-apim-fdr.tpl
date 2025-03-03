{
  "lenses": {
    "0": {
      "order": 0,
      "parts": {
        "0": {
          "position": {
            "x": 0,
            "y": 0,
            "colSpan": 18,
            "rowSpan": 1
          },
          "metadata": {
            "inputs": [],
            "type": "Extension/HubsExtension/PartType/MarkdownPart",
            "settings": {
              "content": {
                "content": "# Metriche e monitoring per API FdR-Fase1\n",
                "title": "",
                "subtitle": "",
                "markdownSource": 1,
                "markdownUri": ""
              }
            }
          }
        },
        "1": {
          "position": {
            "x": 0,
            "y": 1,
            "colSpan": 6,
            "rowSpan": 4
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
                "value": "11ec1765-14e7-4e02-8049-c7bfa170fcdc",
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
                "value": {
                  "scope": "hierarchy"
                },
                "isOptional": true
              },
              {
                "name": "Query",
                "value": "let threshold = 0.99;\nAzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-psp\" or url_s matches regex \"/nodo-auth/nodo-per-psp\" or url_s matches regex \"/nodo/nodo-per-psp\"\n| where operationId_s in ('63b6e2da2a92e811a8f33901', '63ff4f22aca2fd18dcc4a6f7', '61e9633eea7c4a07cc7d4811')\n| summarize\n    Total=count(),\n    Success=count(responseCode_d < 500)\n    by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")\n",
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
                "value": "pagopa-${env_short}-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
                  "aggregation": "Sum",
                  "splitBy": [],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "availability",
                      "type": "real"
                    },
                    {
                      "name": "watermark",
                      "type": "real"
                    }
                  ]
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
                "Dimensions": {
                  "aggregation": "Sum",
                  "splitBy": [],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "availability",
                      "type": "real"
                    },
                    {
                      "name": "watermark",
                      "type": "real"
                    }
                  ]
                },
                "IsQueryContainTimeRange": false,
                "Query": "let threshold = 0.99;\nAzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-psp\" or url_s matches regex \"/nodo-auth/nodo-per-psp\" or url_s matches regex \"/nodo/nodo-per-psp\"\n| where operationId_s in ('63b6e2da2a92e811a8f33901', '63ff4f22aca2fd18dcc4a6f7', '61e9633eea7c4a07cc7d4811')\n| summarize\n    Total=count(),\n    Success=count(responseCode_d < 500)\n    by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")\n\n"
              }
            },
            "partHeader": {
              "title": "Availability (5m)",
              "subtitle": "nodo-invia-flusso-rendicontazione"
            }
          }
        },
        "2":{
          "position": {
            "x": 6,
            "y": 1,
            "colSpan": 6,
            "rowSpan": 4
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
                "value": "155ac71b-1098-47b4-9317-0d9adb1092e0",
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
                "value": {
                  "scope": "hierarchy"
                },
                "isOptional": true
              },
              {
                "name": "Query",
                "value": "AzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-psp\" or url_s matches regex \"/nodo-auth/nodo-per-psp\" or url_s matches regex \"/nodo/nodo-per-psp\"\n| where operationId_s in ('63b6e2da2a92e811a8f33901', '63ff4f22aca2fd18dcc4a6f7', '61e9633eea7c4a07cc7d4811')\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")\n\n",
                "isOptional": true
              },
              {
                "name": "ControlType",
                "value": "FrameControlChart",
                "isOptional": true
              },
              {
                "name": "SpecificChart",
                "value": "StackedArea",
                "isOptional": true
              },
              {
                "name": "PartTitle",
                "value": "Analytics",
                "isOptional": true
              },
              {
                "name": "PartSubTitle",
                "value": "pagopa-p-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
                  "aggregation": "Sum",
                  "splitBy": [
                    {
                      "name": "HTTPStatus",
                      "type": "string"
                    }
                  ],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "count_",
                      "type": "long"
                    }
                  ]
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
                "Dimensions": {
                  "aggregation": "Sum",
                  "splitBy": [
                    {
                      "name": "HTTPStatus",
                      "type": "string"
                    }
                  ],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "count_",
                      "type": "long"
                    }
                  ]
                },
                "IsQueryContainTimeRange": false,
                "Query": "AzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-psp\" or url_s matches regex \"/nodo-auth/nodo-per-psp\" or url_s matches regex \"/nodo/nodo-per-psp\"\n| where operationId_s in ('63b6e2da2a92e811a8f33901', '63ff4f22aca2fd18dcc4a6f7', '61e9633eea7c4a07cc7d4811')\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")\n\n"
              }
            },
            "partHeader": {
              "title": "Response Codes (5m)",
              "subtitle": "nodo-invia-flusso-rendicontazione"
            }
          }
        },
        "3":{
          "position": {
            "x": 12,
            "y": 1,
            "colSpan": 6,
            "rowSpan": 4
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
                "value": "64d98666-5737-43ff-9a01-bd5f14116680",
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
                "value": {
                  "scope": "hierarchy"
                },
                "isOptional": true
              },
              {
                "name": "Query",
                "value": "let threshold = 1;\nAzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-psp\" or url_s matches regex \"/nodo-auth/nodo-per-psp\" or url_s matches regex \"/nodo/nodo-per-psp\"\n| where operationId_s in ('63b6e2da2a92e811a8f33901', '63ff4f22aca2fd18dcc4a6f7', '61e9633eea7c4a07cc7d4811')\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(DurationMs / 100.0, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n",
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
                "value": "pagopa-p-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
                  "aggregation": "Sum",
                  "splitBy": [],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "watermark",
                      "type": "long"
                    },
                    {
                      "name": "duration_percentile_95",
                      "type": "real"
                    }
                  ]
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
                "Dimensions": {
                  "aggregation": "Sum",
                  "splitBy": [],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "watermark",
                      "type": "long"
                    },
                    {
                      "name": "duration_percentile_95",
                      "type": "real"
                    }
                  ]
                },
                "IsQueryContainTimeRange": false,
                "Query": "let threshold = 1;\nAzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-psp\" or url_s matches regex \"/nodo-auth/nodo-per-psp\" or url_s matches regex \"/nodo/nodo-per-psp\"\n| where operationId_s in ('63b6e2da2a92e811a8f33901', '63ff4f22aca2fd18dcc4a6f7', '61e9633eea7c4a07cc7d4811')\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(DurationMs / 100.0, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n"
              }
            },
            "partHeader": {
              "title": "Percentile Response Time (5m)",
              "subtitle": "nodo-invia-flusso-rendicontazione"
            }
          }
        },
        "4":{
          "position": {
            "x": 0,
            "y": 5,
            "colSpan": 6,
            "rowSpan": 4
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
                "value": "32efaec6-c726-4315-a604-98be3123592f",
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
                "value": {
                  "scope": "hierarchy"
                },
                "isOptional": true
              },
              {
                "name": "Query",
                "value": "let threshold = 0.99;\nAzureDiagnostics\n| where TimeGenerated > ago(10m)\n| where url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e')\n| summarize\n    Total=count(),\n    Success=count(responseCode_d < 500)\n    by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n\n",
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
                "value": "pagopa-p-apim",
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
                "ControlType": "FrameControlChart",
                "Dimensions": {
                  "aggregation": "Sum",
                  "splitBy": [],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "availability",
                      "type": "real"
                    },
                    {
                      "name": "watermark",
                      "type": "real"
                    }
                  ]
                },
                "IsQueryContainTimeRange": false,
                "LegendOptions": {
                  "isEnabled": true,
                  "position": "Bottom"
                },
                "Query": "let threshold = 0.99;\nAzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e')\n| summarize\n    Total=count(),\n    Success=count(responseCode_d < 500)\n    by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")\n\n",
                "SpecificChart": "Line"
              }
            },
            "partHeader": {
              "title": "Availability (5m)",
              "subtitle": "nodo-chiedi-flusso-rendicontazione"
            }
          }
        },
        "5":{
          "position": {
            "x": 6,
            "y": 5,
            "colSpan": 6,
            "rowSpan": 4
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
                "value": "2d77ab68-e36d-422a-834c-b0050971c0ab",
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
                "value": {
                  "scope": "hierarchy"
                },
                "isOptional": true
              },
              {
                "name": "Query",
                "value": "AzureDiagnostics\n| where TimeGenerated > ago(1200m)\n| where url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e')\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")\n",
                "isOptional": true
              },
              {
                "name": "ControlType",
                "value": "FrameControlChart",
                "isOptional": true
              },
              {
                "name": "SpecificChart",
                "value": "StackedArea",
                "isOptional": true
              },
              {
                "name": "PartTitle",
                "value": "Analytics",
                "isOptional": true
              },
              {
                "name": "PartSubTitle",
                "value": "pagopa-p-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
                  "aggregation": "Sum",
                  "splitBy": [
                    {
                      "name": "HTTPStatus",
                      "type": "string"
                    }
                  ],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "count_",
                      "type": "long"
                    }
                  ]
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
                "Query": "AzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/nodo-per-pa\" or url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e')\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")\n\n",
                "Dimensions": {
                  "aggregation": "Sum",
                  "splitBy": [
                    {
                      "name": "HTTPStatus",
                      "type": "string"
                    }
                  ],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "count_",
                      "type": "long"
                    }
                  ]
                },
                "IsQueryContainTimeRange": false
              }
            },
            "partHeader": {
              "title": "Response Codes (5m)",
              "subtitle": "nodo-chiedi-flusso-rendicontazione"
            }
          }
        },
        "6":{
          "position": {
            "x": 12,
            "y": 5,
            "colSpan": 6,
            "rowSpan": 4
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
                "value": "15a5095a-1132-4a30-ba85-ab51b274fa68",
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
                "value": {
                  "scope": "hierarchy"
                },
                "isOptional": true
              },
              {
                "name": "Query",
                "value": "let threshold = 1;\nAzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e')\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(DurationMs / 100, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n",
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
                "value": "pagopa-p-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
                  "aggregation": "Sum",
                  "splitBy": [],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "watermark",
                      "type": "long"
                    },
                    {
                      "name": "duration_percentile_95",
                      "type": "long"
                    }
                  ]
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
                "Query": "let threshold = 1;\nAzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/nodo-per-pa\" or url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e')\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(DurationMs / 100.0, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n",
                "Dimensions": {
                  "aggregation": "Sum",
                  "splitBy": [],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "watermark",
                      "type": "long"
                    },
                    {
                      "name": "duration_percentile_95",
                      "type": "real"
                    }
                  ]
                },
                "IsQueryContainTimeRange": false
              }
            },
            "partHeader": {
              "title": "Percentile Response Time (5m)",
              "subtitle": "nodo-chiedi-flusso-rendicontazione"
            }
          }
        },
        "7":{
          "position": {
            "x": 0,
            "y": 9,
            "colSpan": 6,
            "rowSpan": 4
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
                "value": "1422e1d9-1359-415f-add1-159c5d951477",
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
                "value": {
                  "scope": "hierarchy"
                },
                "isOptional": true
              },
              {
                "name": "Query",
                "value": "let threshold = 0.99;\nAzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e')\n| summarize\n    Total=count(),\n    Success=count(responseCode_d < 500)\n    by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")\n\n",
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
                "value": "pagopa-p-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
                  "aggregation": "Sum",
                  "splitBy": [],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "availability",
                      "type": "real"
                    },
                    {
                      "name": "watermark",
                      "type": "real"
                    }
                  ]
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
                "Query": "let threshold = 0.99;\nAzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/nodo-per-pa\" or url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3a', '63b6e2da2a92e811a8f338f8', '61e9633dea7c4a07cc7d480d')\n| summarize\n    Total=count(),\n    Success=count(responseCode_d < 500)\n    by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")\n\n",
                "Dimensions": {
                  "aggregation": "Sum",
                  "splitBy": [],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "availability",
                      "type": "real"
                    },
                    {
                      "name": "watermark",
                      "type": "real"
                    }
                  ]
                },
                "IsQueryContainTimeRange": false
              }
            },
            "partHeader": {
              "title": "Availability (5m)",
              "subtitle": "nodo-chiedi-elenco-flussi-rendicontazioni"
            }
          }
        },
        "8":{
          "position": {
            "x": 6,
            "y": 9,
            "colSpan": 6,
            "rowSpan": 4
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
                "value": "9de90707-16cf-4fed-84cf-b48c411214bf",
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
                "value": {
                  "scope": "hierarchy"
                },
                "isOptional": true
              },
              {
                "name": "Query",
                "value": "AzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3a', '63b6e2da2a92e811a8f338f8', '61e9633dea7c4a07cc7d480d')\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")\n\n",
                "isOptional": true
              },
              {
                "name": "ControlType",
                "value": "FrameControlChart",
                "isOptional": true
              },
              {
                "name": "SpecificChart",
                "value": "StackedArea",
                "isOptional": true
              },
              {
                "name": "PartTitle",
                "value": "Analytics",
                "isOptional": true
              },
              {
                "name": "PartSubTitle",
                "value": "pagopa-p-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
                  "aggregation": "Sum",
                  "splitBy": [
                    {
                      "name": "HTTPStatus",
                      "type": "string"
                    }
                  ],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "count_",
                      "type": "long"
                    }
                  ]
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
                "Query": "AzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/nodo-per-pa\" or url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3a', '63b6e2da2a92e811a8f338f8', '61e9633dea7c4a07cc7d480d')\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")\n\n",
                "Dimensions": {
                  "aggregation": "Sum",
                  "splitBy": [
                    {
                      "name": "HTTPStatus",
                      "type": "string"
                    }
                  ],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "count_",
                      "type": "long"
                    }
                  ]
                },
                "IsQueryContainTimeRange": false
              }
            },
            "partHeader": {
              "title": "Response Codes (5m)",
              "subtitle": "nodo-chiedi-elenco-flussi-rendicontazioni"
            }
          }
        },
        "9":{
          "position": {
            "x": 12,
            "y": 9,
            "colSpan": 6,
            "rowSpan": 4
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
                "value": "2f288b5d-b17f-4a08-812b-3e13b81563a4",
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
                "value": {
                  "scope": "hierarchy"
                },
                "isOptional": true
              },
              {
                "name": "Query",
                "value": "let threshold = 1;\nAzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3a', '63b6e2da2a92e811a8f338f8', '61e9633dea7c4a07cc7d480d')\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(DurationMs / 100.0, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n",
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
                "value": "pagopa-p-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
                  "aggregation": "Sum",
                  "splitBy": [],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "watermark",
                      "type": "long"
                    },
                    {
                      "name": "duration_percentile_95",
                      "type": "real"
                    }
                  ]
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
                "Query": "let threshold = 1;\nAzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/nodo-per-pa\" or url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3a', '63b6e2da2a92e811a8f338f8', '61e9633dea7c4a07cc7d480d')\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(DurationMs / 100.0, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n",
                "Dimensions": {
                  "aggregation": "Sum",
                  "splitBy": [],
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "watermark",
                      "type": "long"
                    },
                    {
                      "name": "duration_percentile_95",
                      "type": "real"
                    }
                  ]
                },
                "IsQueryContainTimeRange": false
              }
            },
            "partHeader": {
              "title": "Percentile Response Time (5m)",
              "subtitle": "nodo-chiedi-elenco-flussi-rendicontazioni"
            }
          }
        },
        "10":{
          "position": {
            "x": 0,
            "y": 13,
            "colSpan": 6,
            "rowSpan": 4
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
                    "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-p-appinsights"
                  ]
                },
                "isOptional": true
              },
              {
                "name": "PartId",
                "value": "97418253-48e5-459d-be11-8ddf1d18c91c",
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
                "isOptional": true
              },
              {
                "name": "Query",
                "value": "let threshold = 0.99;\ntraces\n//| where timestamp > ago(10m)\n| where cloud_RoleName == \"fdr-nodo\"\n| where message startswith \"End process [registerFdrForValidation]\"\n| extend outcome = extract(\"End process \\\\[registerFdrForValidation\\\\] -> \\\\[(.*?)\\\\]\", 1, message)\n| summarize\n    Total=count(),\n    Success=count(outcome == \"OK\")\n    by bin(timestamp, 5m)\n| extend availability=toreal(Success) / Total\n| project timestamp, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")\n",
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
                "value": "pagopa-p-appinsights",
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
                      "name": "availability",
                      "type": "real"
                    },
                    {
                      "name": "watermark",
                      "type": "real"
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
            "settings": {},
            "partHeader": {
              "title": "Availability",
              "subtitle": "register-for-validation"
            }
          }
        },
        "11":{
          "position": {
            "x": 6,
            "y": 13,
            "colSpan": 12,
            "rowSpan": 4
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
                    "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-p-appinsights"
                  ]
                },
                "isOptional": true
              },
              {
                "name": "PartId",
                "value": "10470a4f-124d-4eb9-b3f8-12e4c03554ff",
                "isOptional": true
              },
              {
                "name": "Version",
                "value": "2.0",
                "isOptional": true
              },
              {
                "name": "TimeRange",
                "value": "PT4H",
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
                "value": "let threshold = 0.99;\ntraces\n//| where timestamp > ago(10m)\n| where message startswith \"End process [NodoInviaFlussoRendicontazioneFTP]\"\n| extend outcome = extract(\"End process \\\\[NodoInviaFlussoRendicontazioneFTP\\\\] -> \\\\[(.*?)\\\\]\", 1, message)\n| summarize\n    Total=count(),\n    Success=count(outcome == \"OK\")\n    by bin(timestamp, 5m)\n| extend availability=toreal(Success) / Total\n| project timestamp, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")\n\n",
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
                "value": "pagopa-p-appinsights",
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
                      "name": "availability",
                      "type": "real"
                    },
                    {
                      "name": "watermark",
                      "type": "real"
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
                "GridColumnsWidth": {
                  "flowId": "261px",
                  "errorMessage": "464px"
                },
                "Query": "let threshold = 0.99;\ntraces\n//| where timestamp > ago(10m)\n| where cloud_RoleName == \"fdr-nodo\"\n| where message startswith \"End process [registerFdrForValidation]\"\n| extend errorMessage = extract(\"End process \\\\[registerFdrForValidation\\\\] -> \\\\[(.*?)\\\\](.*?)$\", 2, message)\n| where errorMessage != \"\"\n| extend flowId = customDimensions[\"fdr\"]\n| extend sessionId = customDimensions[\"sessionId\"]\n| order by timestamp desc \n| project timestamp, flowId, errorMessage, sessionId\n\n",
                "ControlType": "AnalyticsGrid",
                "PartTitle": "KO on register for validation",
                "PartSubTitle": "register-for-validation"
              }
            }
          }
        },
        "12":{
          "position": {
            "x": 0,
            "y": 17,
            "colSpan": 6,
            "rowSpan": 4
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
                    "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-p-appinsights"
                  ]
                },
                "isOptional": true
              },
              {
                "name": "PartId",
                "value": "11204b99-11fe-4006-adc5-efe636f910a4",
                "isOptional": true
              },
              {
                "name": "Version",
                "value": "2.0",
                "isOptional": true
              },
              {
                "name": "TimeRange",
                "value": "P2D",
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
                "value": "let threshold = 0.99;\ntraces\n//| where timestamp > ago(10m)\n| where cloud_RoleName == \"fdr-nodo\"\n| where message startswith \"End process [NodoInviaFlussoRendicontazioneFTP]\"\n| extend outcome = extract(\"End process \\\\[NodoInviaFlussoRendicontazioneFTP\\\\] -> \\\\[(.*?)\\\\]\", 1, message)\n| summarize\n    Total=count(),\n    Success=count(outcome == \"OK\")\n    by bin(timestamp, 5m)\n| extend availability=toreal(Success) / Total\n| project timestamp, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")\n\n",
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
                "value": "pagopa-p-appinsights",
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
                      "name": "availability",
                      "type": "real"
                    },
                    {
                      "name": "watermark",
                      "type": "real"
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
            "settings": {},
            "partHeader": {
              "title": "Availability",
              "subtitle": "nodo-invia-flusso-rendicontazione-FTP"
            }
          }
        },
        "13":{
          "position": {
            "x": 6,
            "y": 17,
            "colSpan": 12,
            "rowSpan": 4
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
                    "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-p-appinsights"
                  ]
                },
                "isOptional": true
              },
              {
                "name": "PartId",
                "value": "10470a4f-124d-4eb9-b3f8-12e4c03554ff",
                "isOptional": true
              },
              {
                "name": "Version",
                "value": "2.0",
                "isOptional": true
              },
              {
                "name": "TimeRange",
                "value": "PT4H",
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
                "value": "let threshold = 0.99;\ntraces\n//| where timestamp > ago(10m)\n| where cloud_RoleName == \"fdr-nodo\"\n| where message startswith \"End process [NodoInviaFlussoRendicontazioneFTP]\"\n| extend outcome = extract(\"End process \\\\[NodoInviaFlussoRendicontazioneFTP\\\\] -> \\\\[(.*?)\\\\]\", 1, message)\n| summarize\n    Total=count(),\n    Success=count(outcome == \"OK\")\n    by bin(timestamp, 5m)\n| extend availability=toreal(Success) / Total\n| project timestamp, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")\n\n",
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
                "value": "pagopa-p-appinsights",
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
                      "name": "availability",
                      "type": "real"
                    },
                    {
                      "name": "watermark",
                      "type": "real"
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
                "GridColumnsWidth": {
                  "sessionId": "151px",
                  "errorMessage": "470px",
                  "flowId": "271px",
                  "timestamp": "139px"
                },
                "Query": "traces\n//| where timestamp > ago(10m)\n| where cloud_RoleName == \"fdr-nodo\"\n| where message startswith \"End process [NodoInviaFlussoRendicontazioneFTP]\"\n| extend errorMessage = extract(\"End process \\\\[NodoInviaFlussoRendicontazioneFTP\\\\] -> \\\\[(.*?)\\\\](.*?)$\", 2, message)\n| where errorMessage != \"\"\n| extend flowId = customDimensions[\"fdr\"]\n| extend sessionId = customDimensions[\"sessionId\"]\n| order by timestamp desc \n| project timestamp, flowId, errorMessage, sessionId\n\n",
                "ControlType": "AnalyticsGrid",
                "PartTitle": "KO on nodoInviaFlussoRendicontazioneFTP",
                "PartSubTitle": "nodo-invia-flusso-rendicontazione-FTP"
              }
            }
          }
        },
        "14":{
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
                    "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                  ]
                },
                "isOptional": true
              },
              {
                "name": "PartId",
                "value": "2e43414e-25fd-4fd3-814e-d08be212561b",
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
                "value": "requests\n| where timestamp > ago(30m)\n| where tostring(customDimensions[\"Request-Body\"]) contains 'nodoInviaFlussoRendicontazione'\n| extend esito = extract(\"<esito>(.*?)</esito>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| summarize Count = count() by esito\n| order by Count desc\n\n",
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
                "value": "pagopa-p-appinsights",
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
                "IsQueryContainTimeRange": false,
                "PartTitle": "sssss",
                "Query": "requests\n//| where timestamp > ago(30m)\n| where name matches regex \"nodo(-auth){0,1}/((nodo-per-psp))\" or name matches regex \"nodo(-auth){0,1}/((node-for-psp))\"\n| where tostring(customDimensions[\"Request-Body\"]) contains 'nodoInviaFlussoRendicontazione'\n| extend esito = extract(\"<esito>(.*?)</esito>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| extend faultCode = extract(\"<faultCode>(.*?)</faultCode>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| summarize Count = count() by esito,faultCode,resultCode\n| order by Count desc\n\n"
              }
            },
            "partHeader": {
              "title": "Summary Esito nodo-invia-flusso-rendicontazione",
              "subtitle": "nodo-invia-flusso-rendicontazione"
            }
          }
        },
        "15":{
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
                    "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-${env_short}-appinsights"
                  ]
                },
                "isOptional": true
              },
              {
                "name": "PartId",
                "value": "2a2b0c9c-4e36-442f-8115-219111415662",
                "isOptional": true
              },
              {
                "name": "Version",
                "value": "2.0",
                "isOptional": true
              },
              {
                "name": "TimeRange",
                "value": "PT4H",
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
                "value": "requests\n//| where timestamp > ago(30m)\n| where name matches regex \"nodo(-auth){0,1}/((nodo-per-pa))\" or name matches regex \"nodo(-auth){0,1}/((node-for-pa))\"\n| where tostring(customDimensions[\"Request-Body\"]) contains 'nodoChiediFlussoRendicontazion'\n| extend esito = extract(\"<esito>(.*?)</esito>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| extend faultCode = extract(\"<faultCode>(.*?)</faultCode>\", 1, tostring(customDimensions[\"Response-Body\"]))\n//| where esito == \"\" and faultCode == \"\"\n| summarize Count = count() by esito,faultCode,resultCode\n| order by Count desc\n\n",
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
                "value": "pagopa-p-appinsights",
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
                "PartSubTitle": "nodoChiediFlussoRendicontazion",
                "PartTitle": "Sum Esisto nodoChiediFlussoRendicontazion"
              }
            }
          }
        },
        "16":{
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
                "value": "13d39484-2434-4a2b-9259-68335f67bbf2",
                "isOptional": true
              },
              {
                "name": "Version",
                "value": "2.0",
                "isOptional": true
              },
              {
                "name": "TimeRange",
                "value": "PT12H",
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
                "value": "requests\n//| where timestamp > ago(30m)\n| where name matches regex \"nodo(-auth){0,1}/((nodo-per-psp))\" or name matches regex \"nodo(-auth){0,1}/((node-for-psp))\"\n| where tostring(customDimensions[\"Request-Body\"]) contains 'nodoInviaFlussoRendicontazione'\n| extend esito = extract(\"<esito>(.*?)</esito>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| extend faultCode = extract(\"<faultCode>(.*?)</faultCode>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| extend idDominio = extract(\"<identificativoDominio>(.*?)</identificativoDominio>\", 1, tostring(customDimensions[\"Request-Body\"]))\n| where faultCode != \"\"\n| summarize count() by user_AuthenticatedId, idDominio, faultCode\n| order by count_ desc\n",
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
                "value": "pagopa-p-appinsights",
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
                "PartTitle": "KO nodo-invia-flusso-rendicontazione"
              }
            }
          }
        },
        "17":{
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
                    "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-monitor-rg/providers/microsoft.insights/components/pagopa-p-appinsights"
                  ]
                },
                "isOptional": true
              },
              {
                "name": "PartId",
                "value": "1147e37e-1417-449a-a274-abb6ce836a90",
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
                "value": "requests\n//| where timestamp > ago(30m)\n| where name matches regex \"nodo(-auth){0,1}/((nodo-per-pa))\" or name matches regex \"nodo(-auth){0,1}/((node-for-pa))\"\n| where tostring(customDimensions[\"Request-Body\"]) contains 'nodoChiediFlussoRendicontazion'\n| extend esito = extract(\"<esito>(.*?)</esito>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| extend faultCode = extract(\"<faultCode>(.*?)</faultCode>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| extend idDominio = extract(\"<identificativoDominio>(.*?)</identificativoDominio>\", 1, tostring(customDimensions[\"Request-Body\"]))\n//| where esito == \"\" and faultCode == \"\"\n| where faultCode != \"\"\n| summarize count() by user_AuthenticatedId, idDominio, faultCode\n",
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
                "value": "pagopa-p-appinsights",
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
                "PartTitle": "KO nodoChiediFlussoRendicontazion",
                "Query": "requests\n//| where timestamp > ago(30m)\n| where name matches regex \"nodo(-auth){0,1}/((nodo-per-pa))\" or name matches regex \"nodo(-auth){0,1}/((node-for-pa))\"\n| where tostring(customDimensions[\"Request-Body\"]) contains 'nodoChiediFlussoRendicontazion'\n| extend esito = extract(\"<esito>(.*?)</esito>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| extend faultCode = extract(\"<faultCode>(.*?)</faultCode>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| extend idDominio = extract(\"<identificativoDominio>(.*?)</identificativoDominio>\", 1, tostring(customDimensions[\"Request-Body\"]))\n//| where esito == \"\" and faultCode == \"\"\n| where faultCode != \"\"\n| summarize count() by user_AuthenticatedId, idDominio, faultCode\n| order by count_ desc\n\n"
              }
            }
          }
        },
        "18":{
          "position": {
            "x": 0,
            "y": 31,
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
                    "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-p-apim"
                  ]
                },
                "isOptional": true
              },
              {
                "name": "PartId",
                "value": "90558241-14c8-4d2a-b865-6dd65b10c61e",
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
                "value": {
                  "scope": "hierarchy"
                },
                "isOptional": true
              },
              {
                "name": "Query",
                "value": "AzureDiagnostics\n| where TimeGenerated > ago(8m)\n| where url_s matches regex \"/nodo-auth/node-for-psp\" or url_s matches regex \"/nodo-auth/nodo-per-psp\" or url_s matches regex \"/nodo/nodo-per-psp\" or url_s matches regex \"/nodo-auth/nodo-per-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63b6e2da2a92e811a8f33901', '63ff4f22aca2fd18dcc4a6f7', '61e9633eea7c4a07cc7d4811', // nodo-invia-flusso-rendicontazione\n                          '63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e', // nodo-chiedi-flusso-rendicontazione\n                          '63ff73adea7c4a1860530e3a', '63b6e2da2a92e811a8f338f8', '61e9633dea7c4a07cc7d480d') // nodo-chiedi-elenco-flussi-rendicontazioni\n//| summarize count() by backendUrl_s, url_s, backendResponseCode_d, bin(TimeGenerated,2m)\n| summarize count() by backendUrl_s, operationId_s, url_s\n",
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
                "value": "pagopa-p-apim",
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
                  "backendUrl_s": "510px",
                  "count_": "126px",
                  "operationId_s": "338px",
                  "url_s": "367px",
                  "endpoint": "369px"
                },
                "Query": "AzureDiagnostics\n//| where TimeGenerated > ago(8m)\n| where url_s matches regex \"/nodo-auth/node-for-psp\" or url_s matches regex \"/nodo-auth/nodo-per-psp\" or url_s matches regex \"/nodo/nodo-per-psp\" or url_s matches regex \"/nodo-auth/nodo-per-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n//| extend uri_entrypoint = case(\n//  url_s endswith \"v1/\", replace_string(url_s, \"v1/\", \"v1\"),\n//  url_s\n//)\n| extend uri_entrypoint = replace_regex(url_s, \"/v1(.*)\", \"/v1\")\n| extend uri_backend = replace_regex(backendUrl_s, \"/webservices/input(.*)\", \"/webservices/input\")\n| where operationId_s in ('63b6e2da2a92e811a8f33901', '63ff4f22aca2fd18dcc4a6f7', '61e9633eea7c4a07cc7d4811', // nodo-invia-flusso-rendicontazione\n                          '63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e', // nodo-chiedi-flusso-rendicontazione\n                          '63ff73adea7c4a1860530e3a', '63b6e2da2a92e811a8f338f8', '61e9633dea7c4a07cc7d480d') // nodo-chiedi-elenco-flussi-rendicontazioni\n| extend endpoint = case(\n    operationId_s == \"63b6e2da2a92e811a8f33901\", \"nodoInviaFlussoRendicontazione (Auth)\",\n    operationId_s == \"63ff4f22aca2fd18dcc4a6f7\", \"nodoInviaFlussoRendicontazione (Auth english)\",\n    operationId_s == \"61e9633eea7c4a07cc7d4811\", \"nodoInviaFlussoRendicontazione (non-Auth)\",\n    operationId_s == \"63ff73adea7c4a1860530e3b\", \"nodoChiediFlussoRendicontazione (Auth english)\",\n    operationId_s == \"63b6e2da2a92e811a8f338f9\", \"nodoChiediFlussoRendicontazione (Auth)\",\n    operationId_s == \"61e9633dea7c4a07cc7d480e\", \"nodoChiediFlussoRendicontazione (non-Auth)\",\n    operationId_s == \"63ff73adea7c4a1860530e3a\", \"nodoChiediElencoFlussiRendicontazione (Auth english)\",\n    operationId_s == \"63b6e2da2a92e811a8f338f8\", \"nodoChiediElencoFlussiRendicontazione (Auth)\",\n    operationId_s == \"61e9633dea7c4a07cc7d480d\", \"nodoChiediElencoFlussiRendicontazione (non-Auth)\",\n    operationId_s // Mantieni il valore originale se non corrisponde a nessuno dei valori specificati\n)\n| extend backend = case ( \n    backendUrl_s startswith \"https://10.79.20.34\", \"to Nexi\",\n    backendUrl_s startswith \"https://weuprod.fdr.internal.platform.pagopa.it/pagopa-fdr-nodo-service\", \"to FdR-Fase1\",\n    backendUrl_s == \"\", \"cached by APIM\",\n    backendUrl_s\n)\n| summarize count() by backend, endpoint, uri_entrypoint, uri_backend\n| project backend, endpoint, count_, uri_entrypoint, uri_backend\n| order by endpoint, count_\n\n",
                "PartTitle": "Routing to NdP or FdR-Fase1",
                "IsQueryContainTimeRange": false
              }
            }
          }
        },
        "19":{
          "position": {
            "x": 0,
            "y": 36,
            "colSpan": 18,
            "rowSpan": 1
          },
          "metadata": {
            "inputs": [],
            "type": "Extension/HubsExtension/PartType/MarkdownPart",
            "settings": {
              "content": {
                "content": "# Metriche e monitoring per Database PostgreSQL\n",
                "title": "",
                "subtitle": "",
                "markdownSource": 1,
                "markdownUri": ""
              }
            }
          }
        },
        "20":{
          "position": {
            "x": 0,
            "y": 37,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "aggregationType": 4,
                        "metricVisualization": {
                          "displayName": "CPU percent",
                          "resourceDisplayName": "pagopa-p-weu-fdr-flexible-postgresql"
                        },
                        "name": "cpu_percent",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/pagopa-p-weu-fdr-db-rg/providers/microsoft.dbforpostgresql/flexibleservers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      },
                      {
                        "aggregationType": 4,
                        "metricVisualization": {
                          "displayName": "Memory percent",
                          "resourceDisplayName": "pagopa-p-weu-fdr-flexible-postgresql"
                        },
                        "name": "memory_percent",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/pagopa-p-weu-fdr-db-rg/providers/microsoft.dbforpostgresql/flexibleservers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      }
                    ],
                    "timespan": {
                      "grain": 1,
                      "relative": {
                        "duration": 14400000
                      },
                      "showUTCTime": false
                    },
                    "title": "Cpu and Memory",
                    "titleKind": 2,
                    "visualization": {
                      "axisVisualization": {
                        "x": {
                          "axisType": 2,
                          "isVisible": true
                        },
                        "y": {
                          "axisType": 1,
                          "isVisible": true
                        }
                      },
                      "chartType": 2,
                      "legendVisualization": {
                        "hideHoverCard": false,
                        "hideLabelNames": true,
                        "isVisible": true,
                        "position": 2
                      }
                    }
                  }
                },
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "aggregationType": 4,
                        "metricVisualization": {
                          "displayName": "CPU percent",
                          "resourceDisplayName": "pagopa-p-weu-fdr-flexible-postgresql"
                        },
                        "name": "cpu_percent",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/pagopa-p-weu-fdr-db-rg/providers/microsoft.dbforpostgresql/flexibleservers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      },
                      {
                        "aggregationType": 4,
                        "metricVisualization": {
                          "displayName": "Memory percent",
                          "resourceDisplayName": "pagopa-p-weu-fdr-flexible-postgresql"
                        },
                        "name": "memory_percent",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/pagopa-p-weu-fdr-db-rg/providers/microsoft.dbforpostgresql/flexibleservers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      }
                    ],
                    "title": "Cpu and Memory",
                    "titleKind": 2,
                    "visualization": {
                      "axisVisualization": {
                        "x": {
                          "axisType": 2,
                          "isVisible": true
                        },
                        "y": {
                          "axisType": 1,
                          "isVisible": true
                        }
                      },
                      "chartType": 2,
                      "disablePinning": true,
                      "legendVisualization": {
                        "hideHoverCard": false,
                        "hideLabelNames": true,
                        "isVisible": true,
                        "position": 2
                      }
                    }
                  }
                }
              }
            }
          }
        },
        "21":{
          "position": {
            "x": 6,
            "y": 37,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "aggregationType": 4,
                        "metricVisualization": {
                          "displayName": "Storage percent",
                          "resourceDisplayName": "pagopa-p-weu-fdr-flexible-postgresql"
                        },
                        "name": "storage_percent",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/pagopa-p-weu-fdr-db-rg/providers/microsoft.dbforpostgresql/flexibleservers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      }
                    ],
                    "timespan": {
                      "grain": 1,
                      "relative": {
                        "duration": 14400000
                      },
                      "showUTCTime": false
                    },
                    "title": "Storage",
                    "titleKind": 2,
                    "visualization": {
                      "axisVisualization": {
                        "x": {
                          "axisType": 2,
                          "isVisible": true
                        },
                        "y": {
                          "axisType": 1,
                          "isVisible": true
                        }
                      },
                      "chartType": 2,
                      "legendVisualization": {
                        "hideHoverCard": false,
                        "hideLabelNames": true,
                        "isVisible": true,
                        "position": 2
                      }
                    }
                  }
                },
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "aggregationType": 4,
                        "metricVisualization": {
                          "displayName": "Storage percent",
                          "resourceDisplayName": "pagopa-p-weu-fdr-flexible-postgresql"
                        },
                        "name": "storage_percent",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/pagopa-p-weu-fdr-db-rg/providers/microsoft.dbforpostgresql/flexibleservers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      }
                    ],
                    "title": "Storage",
                    "titleKind": 2,
                    "visualization": {
                      "axisVisualization": {
                        "x": {
                          "axisType": 2,
                          "isVisible": true
                        },
                        "y": {
                          "axisType": 1,
                          "isVisible": true
                        }
                      },
                      "chartType": 2,
                      "disablePinning": true,
                      "legendVisualization": {
                        "hideHoverCard": false,
                        "hideLabelNames": true,
                        "isVisible": true,
                        "position": 2
                      }
                    }
                  }
                }
              }
            }
          }
        },
        "22":{
          "position": {
            "x": 12,
            "y": 37,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "aggregationType": 1,
                        "metricVisualization": {
                          "displayName": "Failed Connections",
                          "resourceDisplayName": "pagopa-p-weu-fdr-flexible-postgresql"
                        },
                        "name": "connections_failed",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-weu-fdr-db-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      },
                      {
                        "aggregationType": 1,
                        "metricVisualization": {
                          "displayName": "Succeeded Connections",
                          "resourceDisplayName": "pagopa-p-weu-fdr-flexible-postgresql"
                        },
                        "name": "connections_succeeded",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-weu-fdr-db-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      }
                    ],
                    "timespan": {
                      "grain": 1,
                      "relative": {
                        "duration": 14400000
                      },
                      "showUTCTime": false
                    },
                    "title": "DB Connections",
                    "titleKind": 2,
                    "visualization": {
                      "axisVisualization": {
                        "x": {
                          "axisType": 2,
                          "isVisible": true
                        },
                        "y": {
                          "axisType": 1,
                          "isVisible": true
                        }
                      },
                      "chartType": 2,
                      "legendVisualization": {
                        "hideHoverCard": false,
                        "hideLabelNames": true,
                        "isVisible": true,
                        "position": 2
                      }
                    }
                  }
                },
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "aggregationType": 1,
                        "metricVisualization": {
                          "displayName": "Failed Connections",
                          "resourceDisplayName": "pagopa-p-weu-fdr-flexible-postgresql"
                        },
                        "name": "connections_failed",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-weu-fdr-db-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      },
                      {
                        "aggregationType": 1,
                        "metricVisualization": {
                          "displayName": "Succeeded Connections",
                          "resourceDisplayName": "pagopa-p-weu-fdr-flexible-postgresql"
                        },
                        "name": "connections_succeeded",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-weu-fdr-db-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      }
                    ],
                    "title": "DB Connections",
                    "titleKind": 2,
                    "visualization": {
                      "axisVisualization": {
                        "x": {
                          "axisType": 2,
                          "isVisible": true
                        },
                        "y": {
                          "axisType": 1,
                          "isVisible": true
                        }
                      },
                      "chartType": 2,
                      "disablePinning": true,
                      "legendVisualization": {
                        "hideHoverCard": false,
                        "hideLabelNames": true,
                        "isVisible": true,
                        "position": 2
                      }
                    }
                  }
                }
              }
            }
          }
        },
        "23":{
          "position": {
            "x": 0,
            "y": 41,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "aggregationType": 4,
                        "metricVisualization": {
                          "displayName": "IOPS"
                        },
                        "name": "iops",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-weu-fdr-db-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      }
                    ],
                    "timespan": {
                      "grain": 1,
                      "relative": {
                        "duration": 86400000
                      },
                      "showUTCTime": false
                    },
                    "title": "Avg IOPS for pagopa-p-weu-fdr-flexible-postgresql",
                    "titleKind": 1,
                    "visualization": {
                      "axisVisualization": {
                        "x": {
                          "axisType": 2,
                          "isVisible": true
                        },
                        "y": {
                          "axisType": 1,
                          "isVisible": true
                        }
                      },
                      "chartType": 2,
                      "legendVisualization": {
                        "hideHoverCard": false,
                        "hideLabelNames": true,
                        "isVisible": true,
                        "position": 2
                      }
                    }
                  }
                },
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "aggregationType": 4,
                        "metricVisualization": {
                          "displayName": "IOPS"
                        },
                        "name": "iops",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-weu-fdr-db-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      }
                    ],
                    "title": "Avg IOPS for pagopa-p-weu-fdr-flexible-postgresql",
                    "titleKind": 1,
                    "visualization": {
                      "axisVisualization": {
                        "x": {
                          "axisType": 2,
                          "isVisible": true
                        },
                        "y": {
                          "axisType": 1,
                          "isVisible": true
                        }
                      },
                      "chartType": 2,
                      "disablePinning": true,
                      "legendVisualization": {
                        "hideHoverCard": false,
                        "hideLabelNames": true,
                        "isVisible": true,
                        "position": 2
                      }
                    }
                  }
                }
              }
            }
          }
        },
        "24":{
          "position": {
            "x": 6,
            "y": 41,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "aggregationType": 4,
                        "metricVisualization": {
                          "displayName": "Read Throughput Bytes/Sec"
                        },
                        "name": "read_throughput",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-weu-fdr-db-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      }
                    ],
                    "timespan": {
                      "grain": 1,
                      "relative": {
                        "duration": 86400000
                      },
                      "showUTCTime": false
                    },
                    "title": "Avg Read Throughput Bytes/Sec for pagopa-p-weu-fdr-flexible-postgresql",
                    "titleKind": 1,
                    "visualization": {
                      "axisVisualization": {
                        "x": {
                          "axisType": 2,
                          "isVisible": true
                        },
                        "y": {
                          "axisType": 1,
                          "isVisible": true
                        }
                      },
                      "chartType": 2,
                      "legendVisualization": {
                        "hideHoverCard": false,
                        "hideLabelNames": true,
                        "isVisible": true,
                        "position": 2
                      }
                    }
                  }
                },
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "aggregationType": 4,
                        "metricVisualization": {
                          "displayName": "Read Throughput Bytes/Sec"
                        },
                        "name": "read_throughput",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-weu-fdr-db-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      }
                    ],
                    "title": "Avg Read Throughput Bytes/Sec for pagopa-p-weu-fdr-flexible-postgresql",
                    "titleKind": 1,
                    "visualization": {
                      "axisVisualization": {
                        "x": {
                          "axisType": 2,
                          "isVisible": true
                        },
                        "y": {
                          "axisType": 1,
                          "isVisible": true
                        }
                      },
                      "chartType": 2,
                      "disablePinning": true,
                      "legendVisualization": {
                        "hideHoverCard": false,
                        "hideLabelNames": true,
                        "isVisible": true,
                        "position": 2
                      }
                    }
                  }
                }
              }
            }
          }
        },
        "25":{
          "position": {
            "x": 12,
            "y": 41,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "aggregationType": 4,
                        "metricVisualization": {
                          "displayName": "Write Throughput Bytes/Sec"
                        },
                        "name": "write_throughput",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-weu-fdr-db-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      }
                    ],
                    "timespan": {
                      "grain": 1,
                      "relative": {
                        "duration": 86400000
                      },
                      "showUTCTime": false
                    },
                    "title": "Avg Write Throughput Bytes/Sec for pagopa-p-weu-fdr-flexible-postgresql",
                    "titleKind": 1,
                    "visualization": {
                      "axisVisualization": {
                        "x": {
                          "axisType": 2,
                          "isVisible": true
                        },
                        "y": {
                          "axisType": 1,
                          "isVisible": true
                        }
                      },
                      "chartType": 2,
                      "legendVisualization": {
                        "hideHoverCard": false,
                        "hideLabelNames": true,
                        "isVisible": true,
                        "position": 2
                      }
                    }
                  }
                },
                "isOptional": true
              },
              {
                "name": "sharedTimeRange",
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "aggregationType": 4,
                        "metricVisualization": {
                          "displayName": "Write Throughput Bytes/Sec"
                        },
                        "name": "write_throughput",
                        "namespace": "microsoft.dbforpostgresql/flexibleservers",
                        "resourceMetadata": {
                          "id": "/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-weu-fdr-db-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/pagopa-p-weu-fdr-flexible-postgresql"
                        }
                      }
                    ],
                    "title": "Avg Write Throughput Bytes/Sec for pagopa-p-weu-fdr-flexible-postgresql",
                    "titleKind": 1,
                    "visualization": {
                      "axisVisualization": {
                        "x": {
                          "axisType": 2,
                          "isVisible": true
                        },
                        "y": {
                          "axisType": 1,
                          "isVisible": true
                        }
                      },
                      "chartType": 2,
                      "disablePinning": true,
                      "legendVisualization": {
                        "hideHoverCard": false,
                        "hideLabelNames": true,
                        "isVisible": true,
                        "position": 2
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
