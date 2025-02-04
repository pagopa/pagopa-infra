{
  "lenses": {
    "0": {
      "order": 0,
      "parts": {
        "0": {
          "position": {
            "x": 0,
            "y": 0,
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
                "value": "let threshold = 0.99;\nAzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-psp\" or url_s matches regex \"/nodo/nodo-per-psp\"\n| where operationId_s in ('63b6e2da2a92e811a8f33901', '63ff4f22aca2fd18dcc4a6f7', '61e9633eea7c4a07cc7d4811')\n| summarize\n    Total=count(),\n    Success=count(responseCode_d < 500)\n    by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")\n",
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
                "value": true,
                "isOptional": true
              }
            ],
            "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
            "settings": {},
            "partHeader": {
              "title": "Availability (5m)",
              "subtitle": "nodo-invia-flusso-rendicontazione"
            }
          }
        },
        "1": {
          "position": {
            "x": 6,
            "y": 0,
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
                "value": "AzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-psp\" or url_s matches regex \"/nodo/nodo-per-psp\"\n| where operationId_s in ('63b6e2da2a92e811a8f33901', '63ff4f22aca2fd18dcc4a6f7', '61e9633eea7c4a07cc7d4811')\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")\n\n",
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
                "value": "pagopa-${env_short}-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "count_",
                      "type": "long"
                    }
                  ],
                  "splitBy": [
                    {
                      "name": "HTTPStatus",
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
            "settings": {},
            "partHeader": {
              "title": "Response Codes (5m)",
              "subtitle": "nodo-invia-flusso-rendicontazione"
            }
          }
        },
        "2": {
          "position": {
            "x": 12,
            "y": 0,
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
                "value": "let threshold = 1;\nAzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-psp\" or url_s matches regex \"/nodo/nodo-per-psp\"\n| where operationId_s in ('63b6e2da2a92e811a8f33901', '63ff4f22aca2fd18dcc4a6f7', '61e9633eea7c4a07cc7d4811')\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(DurationMs / 100.0, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n",
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
                "value": true,
                "isOptional": true
              }
            ],
            "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
            "settings": {},
            "partHeader": {
              "title": "Percentile Response Time (5m)",
              "subtitle": "nodo-invia-flusso-rendicontazione"
            }
          }
        },
        "3": {
          "position": {
            "x": 0,
            "y": 4,
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
                "value": true,
                "isOptional": true
              }
            ],
            "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
            "settings": {
              "content": {
                "Query": "let threshold = 0.99;\nAzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e')\n| summarize\n    Total=count(),\n    Success=count(responseCode_d < 500)\n    by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")\n\n",
                "ControlType": "FrameControlChart",
                "SpecificChart": "Line",
                "Dimensions": {
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
                  ],
                  "splitBy": [],
                  "aggregation": "Sum"
                },
                "LegendOptions": {
                  "isEnabled": true,
                  "position": "Bottom"
                }
              }
            },
            "partHeader": {
              "title": "Availability (5m)",
              "subtitle": "nodo-chiedi-flusso-rendicontazione"
            }
          }
        },
        "4": {
          "position": {
            "x": 6,
            "y": 4,
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
                "value": "pagopa-${env_short}-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "count_",
                      "type": "long"
                    }
                  ],
                  "splitBy": [
                    {
                      "name": "HTTPStatus",
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
                "Query": "AzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e')\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")\n\n"
              }
            },
            "partHeader": {
              "title": "Response Codes (5m)",
              "subtitle": "nodo-chiedi-flusso-rendicontazione"
            }
          }
        },
        "5": {
          "position": {
            "x": 12,
            "y": 4,
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
                "value": "pagopa-${env_short}-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
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
                "value": true,
                "isOptional": true
              }
            ],
            "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
            "settings": {
              "content": {
                "Query": "let threshold = 1;\nAzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e')\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(DurationMs / 100.0, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n",
                "Dimensions": {
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
                  ],
                  "splitBy": [],
                  "aggregation": "Sum"
                }
              }
            },
            "partHeader": {
              "title": "Percentile Response Time (5m)",
              "subtitle": "nodo-chiedi-flusso-rendicontazione"
            }
          }
        },
        "6": {
          "position": {
            "x": 0,
            "y": 8,
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
                "value": "pagopa-${env_short}-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
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
                "value": true,
                "isOptional": true
              }
            ],
            "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
            "settings": {
              "content": {
                "Query": "let threshold = 0.99;\nAzureDiagnostics\n| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3a', '63b6e2da2a92e811a8f338f8', '61e9633dea7c4a07cc7d480d')\n| summarize\n    Total=count(),\n    Success=count(responseCode_d < 500)\n    by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")\n\n"
              }
            },
            "partHeader": {
              "title": "Availability (5m)",
              "subtitle": "nodo-chiedi-elenco-flussi-rendicontazioni"
            }
          }
        },
        "7": {
          "position": {
            "x": 6,
            "y": 8,
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
                "value": "pagopa-${env_short}-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
                  "xAxis": {
                    "name": "TimeGenerated",
                    "type": "datetime"
                  },
                  "yAxis": [
                    {
                      "name": "count_",
                      "type": "long"
                    }
                  ],
                  "splitBy": [
                    {
                      "name": "HTTPStatus",
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
            "settings": {},
            "partHeader": {
              "title": "Response Codes (5m)",
              "subtitle": "nodo-chiedi-elenco-flussi-rendicontazioni"
            }
          }
        },
        "8": {
          "position": {
            "x": 12,
            "y": 8,
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
                "value": "pagopa-${env_short}-apim",
                "isOptional": true
              },
              {
                "name": "Dimensions",
                "value": {
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
                "value": true,
                "isOptional": true
              }
            ],
            "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
            "settings": {},
            "partHeader": {
              "title": "Percentile Response Time (5m)",
              "subtitle": "nodo-chiedi-elenco-flussi-rendicontazioni"
            }
          }
        }
      }
    }
  }
}
