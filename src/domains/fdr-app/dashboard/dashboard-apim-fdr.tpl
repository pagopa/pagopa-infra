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
                "value": "pagopa-${env_short}-apim",
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
                "Query": "AzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/nodo-per-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e')\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")\n\n"
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
                "Query": "let threshold = 1;\nAzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/nodo-per-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e')\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(DurationMs / 100.0, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n"
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
                "Query": "let threshold = 0.99;\nAzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/node-for-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3a', '63b6e2da2a92e811a8f338f8', '61e9633dea7c4a07cc7d480d')\n| summarize\n    Total=count(),\n    Success=count(responseCode_d < 500)\n    by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")\n\n"
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
                "Query": "AzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/nodo-per-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3a', '63b6e2da2a92e811a8f338f8', '61e9633dea7c4a07cc7d480d')\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")\n\n"
              }
            },
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
                "Query": "let threshold = 1;\nAzureDiagnostics\n//| where TimeGenerated > ago(30m)\n| where url_s matches regex \"/nodo-auth/nodo-per-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63ff73adea7c4a1860530e3a', '63b6e2da2a92e811a8f338f8', '61e9633dea7c4a07cc7d480d')\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(DurationMs / 100.0, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")\n\n"
              }
            },
            "partHeader": {
              "title": "Percentile Response Time (5m)",
              "subtitle": "nodo-chiedi-elenco-flussi-rendicontazioni"
            }
          }
        },
        "9": {
          "position": {
            "x": 0,
            "y": 12,
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
                "Query": "requests\n//| where timestamp > ago(30m)\n| where name matches regex \"nodo(-auth){0,1}/((nodo-per-psp))\" or name matches regex \"nodo(-auth){0,1}/((node-for-psp))\"\n| where tostring(customDimensions[\"Request-Body\"]) contains 'nodoInviaFlussoRendicontazione'\n| extend esito = extract(\"<esito>(.*?)</esito>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| extend faultCode = extract(\"<faultCode>(.*?)</faultCode>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| summarize Count = count() by esito,faultCode,resultCode\n| order by Count desc\n\n",
                "PartTitle": "sssss",
                "IsQueryContainTimeRange": false
              }
            },
            "partHeader": {
              "title": "Summary Esito nodo-invia-flusso-rendicontazione",
              "subtitle": "nodo-invia-flusso-rendicontazione"
            }
          }
        },
        "10": {
          "position": {
            "x": 9,
            "y": 12,
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
                "value": false,
                "isOptional": true
              }
            ],
            "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
            "settings": {
              "content": {
                "PartTitle": "Sum Esisto nodoChiediFlussoRendicontazion",
                "PartSubTitle": "nodoChiediFlussoRendicontazion"
              }
            }
          }
        },
        "11": {
          "position": {
            "x": 0,
            "y": 17,
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
        "12": {
          "position": {
            "x": 9,
            "y": 17,
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
                "value": false,
                "isOptional": true
              }
            ],
            "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
            "settings": {
              "content": {
                "Query": "requests\n//| where timestamp > ago(30m)\n| where name matches regex \"nodo(-auth){0,1}/((nodo-per-pa))\" or name matches regex \"nodo(-auth){0,1}/((node-for-pa))\"\n| where tostring(customDimensions[\"Request-Body\"]) contains 'nodoChiediFlussoRendicontazion'\n| extend esito = extract(\"<esito>(.*?)</esito>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| extend faultCode = extract(\"<faultCode>(.*?)</faultCode>\", 1, tostring(customDimensions[\"Response-Body\"]))\n| extend idDominio = extract(\"<identificativoDominio>(.*?)</identificativoDominio>\", 1, tostring(customDimensions[\"Request-Body\"]))\n//| where esito == \"\" and faultCode == \"\"\n| where faultCode != \"\"\n| summarize count() by user_AuthenticatedId, idDominio, faultCode\n| order by count_ desc\n\n",
                "PartTitle": "KO nodoChiediFlussoRendicontazion"
              }
            }
          }
        },
        "13": {
          "position": {
            "x": 0,
            "y": 22,
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
                    "/subscriptions/${subscription_id}/resourceGroups/pagopa-${env_short}-api-rg/providers/Microsoft.ApiManagement/service/pagopa-${env_short}-apim"
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
                "GridColumnsWidth": {
                  "backendUrl_s": "470px",
                  "count_": "443px",
                  "operationId_s": "338px",
                  "url_s": "488px"
                },
                "IsQueryContainTimeRange": false,
                "Query": "AzureDiagnostics\n//| where TimeGenerated > ago(8m)\n| where url_s matches regex \"/nodo-auth/node-for-psp\" or url_s matches regex \"/nodo-auth/nodo-per-psp\" or url_s matches regex \"/nodo/nodo-per-psp\" or url_s matches regex \"/nodo-auth/nodo-per-pa\" or url_s matches regex \"/nodo/nodo-per-pa\"\n| where operationId_s in ('63b6e2da2a92e811a8f33901', '63ff4f22aca2fd18dcc4a6f7', '61e9633eea7c4a07cc7d4811', // nodo-invia-flusso-rendicontazione\n                          '63ff73adea7c4a1860530e3b', '63b6e2da2a92e811a8f338f9', '61e9633dea7c4a07cc7d480e', // nodo-chiedi-flusso-rendicontazione\n                          '63ff73adea7c4a1860530e3a', '63b6e2da2a92e811a8f338f8', '61e9633dea7c4a07cc7d480d') // nodo-chiedi-elenco-flussi-rendicontazioni\n//| summarize count() by backendUrl_s, url_s, backendResponseCode_d, bin(TimeGenerated,2m)\n| summarize count() by backendUrl_s, operationId_s, url_s\n\n"
              }
            }
          }
        }
      }
    }
  }
}
