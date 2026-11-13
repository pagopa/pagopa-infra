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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "cb1572cb-571d-4d02-b15a-c298ae7dafbf",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_verifyPaymentNotice}\" // verifyPaymentNotice\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "NM3 - verifyPaymentNotice"
              }
            }
          },
          {
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "d1848f2b-b707-43e4-93ca-cfca559684c9",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_verifyPaymentNotice}\" // verifyPaymentNotice\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "NM3 - verifyPaymentNotice"
              }
            }
          },
          {
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "4d1a5fef-d08e-4351-85f6-63e50b59b553",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_verifyPaymentNotice}\" // verifyPaymentNotice\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "NM3 - verifyPaymentNotice"
              }
            }
          },
          {
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "f7bfa7b3-8f16-444a-84c7-dd27d8d28b12",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_activatePaymentNotice}\" // activatePaymentNotice\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "NM3 - activatePaymentNotice"
              }
            }
          },
          {
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "3016ade1-d650-4e22-9548-2ec7feb85fcd",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_activatePaymentNotice}\" // activatePaymentNotice\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "NM3 - activatePaymentNotice"
              }
            }
          },
          {
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "dae73eaf-0659-4424-9f57-9166a0823718",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_activatePaymentNotice}\" // activatePaymentNotice\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "NM3 - activatePaymentNotice"
              }
            }
          },
          {
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "4191e87a-455e-48bf-b88c-ef76cbf270b6",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_sendPaymentOutcome}\" // sendPaymentOutcome\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "NM3 - sendPaymentOutcome"
              }
            }
          },
          {
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "417c59c8-580b-4363-998f-1bdb435becaa",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_sendPaymentOutcome}\" // sendPaymentOutcome\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "NM3 - sendPaymentOutcome"
              }
            }
          },
          {
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "c5395dd2-876b-4bca-96d5-d12ecaeb6eda",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_sendPaymentOutcome}\" // sendPaymentOutcome\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "NM3 - sendPaymentOutcome"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 12,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "20dbdc4c-6bec-4c12-a777-5098ec6dad29",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_verificaBollettino}\" // verificaBollettino\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "NM3 - verificaBollettino"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 12,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "71fb37a6-87f4-48f9-9b5f-6cf88b475cfd",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_verificaBollettino}\" // verificaBollettino\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "NM3 - verificaBollettino"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 12,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "8c48623e-bcbe-4715-8e4c-47954a1d81aa",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_verificaBollettino}\" // verificaBollettino\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "NM3 - verificaBollettino"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 16,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "6e52004b-29a4-44c5-80ad-03f7cab62511",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_demandPaymentNotice}\" // demandPaymentNotice\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "NM3 - demandPaymentNotice"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 16,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "7bdb0822-1e27-481b-aed4-75f49106bcce",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_demandPaymentNotice}\" // demandPaymentNotice\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "NM3 - demandPaymentNotice"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 16,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "91ada8c0-74ab-4d68-bed6-48985ae65077",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_demandPaymentNotice}\" // demandPaymentNotice\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "NM3 - demandPaymentNotice"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 20,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "5b7c7763-80a3-438b-a1fe-9c67ef3505a2",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_nodoChiediCatalogoServiziV2}\" // nodoChiediCatalogoServiziV2\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "NM3 - nodoChiediCatalogoServiziV2"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 20,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "5ab155ce-603f-4391-a60a-519431a18704",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_nodoChiediCatalogoServiziV2}\" // nodoChiediCatalogoServiziV2\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "NM3 - nodoChiediCatalogoServiziV2"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 20,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "3c8631d6-813e-4fa2-b5b9-0dc65775ba3d",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_nodoChiediCatalogoServiziV2}\" // nodoChiediCatalogoServiziV2\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "NM3 - nodoChiediCatalogoServiziV2"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 24,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "edcadce7-dae2-4735-b04e-623d9e59d801",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_activatePaymentNoticeV2}\" // activatePaymentNoticeV2\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "NM3 - activatePaymentNoticeV2"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 24,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "29ffa350-dd29-4999-8dcf-333ad8bc6ec4",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_activatePaymentNoticeV2}\" // activatePaymentNoticeV2\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "NM3 - activatePaymentNoticeV2"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 24,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "ac037706-ab35-4d33-b2e6-4d21490ca850",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_activatePaymentNoticeV2}\" // activatePaymentNoticeV2\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "NM3 - activatePaymentNoticeV2"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 28,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "9e4b5f4f-d498-47e9-a863-3ee087dd248d",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_sendPaymentOutcomeV2}\" // sendPaymentOutcomeV2\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "NM3 - sendPaymentOutcomeV2"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 28,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "d62a695d-5a10-4a3a-9f2f-61c276412b4d",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_sendPaymentOutcomeV2}\" // sendPaymentOutcomeV2\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "NM3 - sendPaymentOutcomeV2"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 28,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "cca169e9-2e42-4267-beae-8546e0610944",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_sendPaymentOutcomeV2}\" // sendPaymentOutcomeV2\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "NM3 - sendPaymentOutcomeV2"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 32,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "cdbd4c77-3bcc-40d8-ab84-a6be7034252a",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_nodoChiediInformativaPA}\" // nodoChiediInformativaPA\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "NM3 - nodoChiediInformativaPA"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 32,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "49c4d4a4-eea0-4b2b-94b4-c64a70701d96",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_nodoChiediInformativaPA}\" // nodoChiediInformativaPA\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "NM3 - nodoChiediInformativaPA"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 32,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "8a81d352-3b53-433a-afcb-ac30ecc2ffc7",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_nodoChiediInformativaPA}\" // nodoChiediInformativaPA\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "NM3 - nodoChiediInformativaPA"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 36,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "48bbac3b-c5ed-49ef-b691-0b269a648b8c",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_nodoChiediTemplateInformativaPSP}\" // nodoChiediTemplateInformativaPSP\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "NM3 - nodoChiediTemplateInformativaPSP"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 36,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "8987d597-6fdb-4ff6-9870-5bc81b57a1b7",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_nodoChiediTemplateInformativaPSP}\" // nodoChiediTemplateInformativaPSP\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "NM3 - nodoChiediTemplateInformativaPSP"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 36,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "f8d70798-b5a2-44c7-8802-f3e8a5d87b68",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${ops.nm3_nodoChiediTemplateInformativaPSP}\" // nodoChiediTemplateInformativaPSP\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "NM3 - nodoChiediTemplateInformativaPSP"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 40,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "b99b8121-a8f2-41c6-8d11-44cc6f0464ee",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediStatoRPT}\" // nodoChiediStatoRPT\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PA - nodoChiediStatoRPT"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 40,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "1a90351f-0601-4d9e-a84a-4797687390f3",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediStatoRPT}\" // nodoChiediStatoRPT\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PA - nodoChiediStatoRPT"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 40,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "3e1094bb-fa7a-421d-90c5-d5882a079d6b",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediStatoRPT}\" // nodoChiediStatoRPT\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PA - nodoChiediStatoRPT"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 44,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "42580bf6-f973-4315-8f65-5697c14f4a2a",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediListaPendentiRPT}\" // nodoChiediListaPendentiRPT\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PA - nodoChiediListaPendentiRPT"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 44,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "635e93a0-c83f-4b9d-9a3f-90f6580c4ed4",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediListaPendentiRPT}\" // nodoChiediListaPendentiRPT\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PA - nodoChiediListaPendentiRPT"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 44,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "48e3a39e-08eb-47c3-9703-c7bee5cd4677",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediListaPendentiRPT}\" // nodoChiediListaPendentiRPT\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PA - nodoChiediListaPendentiRPT"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 48,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "904cbca8-050a-414e-9d61-19aeef853e83",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoInviaRPT}\" // nodoInviaRPT\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PA - nodoInviaRPT"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 48,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "e5a84fde-d49d-4641-862c-a84a07a0a83b",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoInviaRPT}\" // nodoInviaRPT\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PA - nodoInviaRPT"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 48,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "823e4f5c-f947-4537-bade-82ee5f654a47",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoInviaRPT}\" // nodoInviaRPT\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PA - nodoInviaRPT"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 52,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "dac97c7e-1bcf-4fec-8c7e-b757e7b71ea3",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoInviaCarrelloRPT}\" // nodoInviaCarrelloRPT\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PA - nodoInviaCarrelloRPT"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 52,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "9e2fc803-f272-40ab-a759-a34dbdf1dac1",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoInviaCarrelloRPT}\" // nodoInviaCarrelloRPT\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PA - nodoInviaCarrelloRPT"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 52,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "8ea48d7a-98d8-4804-b8cd-3c09ebf1bd19",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoInviaCarrelloRPT}\" // nodoInviaCarrelloRPT\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PA - nodoInviaCarrelloRPT"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 56,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "ecb4a79a-81b9-48c6-8b79-da19401d6cf9",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediCopiaRT}\" // nodoChiediCopiaRT\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PA - nodoChiediCopiaRT"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 56,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "ba3e9405-bafb-4624-9c6c-ef0417f2a504",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediCopiaRT}\" // nodoChiediCopiaRT\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PA - nodoChiediCopiaRT"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 56,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "04025799-59f4-400e-ad98-592a02694791",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediCopiaRT}\" // nodoChiediCopiaRT\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PA - nodoChiediCopiaRT"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 60,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "3aec5626-7cc9-4e63-8fdb-1894b5ca7636",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediInformativaPSP}\" // nodoChiediInformativaPSP\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PA - nodoChiediInformativaPSP"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 60,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "bd42ed18-4e14-4ee7-8881-0109405eedd1",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediInformativaPSP}\" // nodoChiediInformativaPSP\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PA - nodoChiediInformativaPSP"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 60,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "a2bb630c-9330-44c4-81ac-0166c9076d27",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediInformativaPSP}\" // nodoChiediInformativaPSP\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PA - nodoChiediInformativaPSP"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 64,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "86be31b8-cb4d-4ade-a6e9-02a9da1c0d60",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoPAChiediInformativaPA}\" // nodoPAChiediInformativaPA\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PA - nodoPAChiediInformativaPA"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 64,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "898cdfb7-acbc-4baf-951f-d1a1802f36df",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoPAChiediInformativaPA}\" // nodoPAChiediInformativaPA\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PA - nodoPAChiediInformativaPA"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 64,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "bcd981cd-9f33-4ffd-abbb-08d366e92aba",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoPAChiediInformativaPA}\" // nodoPAChiediInformativaPA\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PA - nodoPAChiediInformativaPA"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 68,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "95d1e675-73bf-4ef6-9176-0b16fae4b2a4",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediElencoQuadraturePA}\" // nodoChiediElencoQuadraturePA\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PA - nodoChiediElencoQuadraturePA"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 68,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "1a9ad71e-0294-4ad5-9d5f-4e15620594c4",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediElencoQuadraturePA}\" // nodoChiediElencoQuadraturePA\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PA - nodoChiediElencoQuadraturePA"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 68,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "4910a87e-bbe5-4422-99a7-0c8683c19258",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediElencoQuadraturePA}\" // nodoChiediElencoQuadraturePA\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PA - nodoChiediElencoQuadraturePA"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 72,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "06be74ce-dc26-4f9d-ae96-e237e5cdb3da",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediQuadraturaPA}\" // nodoChiediQuadraturaPA\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PA - nodoChiediQuadraturaPA"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 72,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "04e91ea4-6ad8-4a88-a4b9-7a279f1b0f2f",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediQuadraturaPA}\" // nodoChiediQuadraturaPA\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PA - nodoChiediQuadraturaPA"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 72,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "00b82b5e-7c7e-48f7-aa6a-6e1b6b146405",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-pa/v1\"\n| where operationId_s == \"${ops.pa_nodoChiediQuadraturaPA}\" // nodoChiediQuadraturaPA\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PA - nodoChiediQuadraturaPA"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 76,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "88ef7d3d-790b-4e12-9bd8-19b6aa995314",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoVerificaRPT}\" // nodoVerificaRPT\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PSP - nodoVerificaRPT"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 76,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "a1924402-3787-4d1c-9030-ded7dfd52a57",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoVerificaRPT}\" // nodoVerificaRPT\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PSP - nodoVerificaRPT"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 76,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "22cfa58a-a24c-488f-ad6b-e3b3bf4fa974",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoVerificaRPT}\" // nodoVerificaRPT\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PSP - nodoVerificaRPT"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 80,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "cb9a56e7-3ae7-4c07-9fc8-35031b7008fa",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoAttivaRPT}\" // nodoAttivaRPT\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PSP - nodoAttivaRPT"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 80,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "1afca220-c1b6-4976-9715-a60bb2352999",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoAttivaRPT}\" // nodoAttivaRPT\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PSP - nodoAttivaRPT"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 80,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "e1102144-3bc9-48c6-8655-7ed0ef83aeb6",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoAttivaRPT}\" // nodoAttivaRPT\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PSP - nodoAttivaRPT"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 84,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "3bd1f156-fc58-40d3-933d-350bf2061d4b",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoInviaRT}\" // nodoInviaRT\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PSP - nodoInviaRT"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 84,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "3506c1d7-0cf0-4692-a5ab-f3e94c3716ef",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoInviaRT}\" // nodoInviaRT\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PSP - nodoInviaRT"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 84,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "f757b14f-67f5-4215-a112-885f1f726365",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoInviaRT}\" // nodoInviaRT\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PSP - nodoInviaRT"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 88,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "51d7c63f-ae62-4e40-b73c-a48c6b29192a",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoChiediInformativaPA}\" // nodoChiediInformativaPA\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PSP - nodoChiediInformativaPA"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 88,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "bd3d906e-9e76-46a9-8a5e-4160ce9a2f50",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoChiediInformativaPA}\" // nodoChiediInformativaPA\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PSP - nodoChiediInformativaPA"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 88,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "76b37d7f-4844-439d-beb6-f87b2ebe22b9",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoChiediInformativaPA}\" // nodoChiediInformativaPA\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PSP - nodoChiediInformativaPA"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 92,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "7ddae659-8e8a-479d-8d7d-009bce6125a4",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoChiediTemplateInformativaPSP}\" // nodoChiediTemplateInformativaPSP\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PSP - nodoChiediTemplateInformativaPSP"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 92,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "743602b0-12b4-4496-8031-61e673b432c3",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoChiediTemplateInformativaPSP}\" // nodoChiediTemplateInformativaPSP\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PSP - nodoChiediTemplateInformativaPSP"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 92,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "168364d6-585b-4d2d-bb3a-18996cb8dc1a",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoChiediTemplateInformativaPSP}\" // nodoChiediTemplateInformativaPSP\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PSP - nodoChiediTemplateInformativaPSP"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 96,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "1dd341cd-c342-432c-bc78-e711ed95c771",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoChiediElencoQuadraturePSP}\" // nodoChiediElencoQuadraturePSP\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "PSP - nodoChiediElencoQuadraturePSP"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 96,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "eec3a58a-f675-4f10-84f0-37a647b72774",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoChiediElencoQuadraturePSP}\" // nodoChiediElencoQuadraturePSP\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "PSP - nodoChiediElencoQuadraturePSP"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 96,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "7d581a05-0277-433e-8cce-0eeed851de35",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp/v1\"\n| where operationId_s == \"${ops.psp_nodoChiediElencoQuadraturePSP}\" // nodoChiediElencoQuadraturePSP\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "PSP - nodoChiediElencoQuadraturePSP"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 100,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "0c0e0c82-3019-4323-a54a-08f32187833d",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp-richiesta-avvisi/v1\"\n| where operationId_s == \"${ops.ra_nodoChiediNumeroAvviso}\" // nodoChiediNumeroAvviso\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "RichiestaAvvisi - nodoChiediNumeroAvviso"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 100,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "8fc1ddbe-551d-44a0-a21c-f3497b909d8a",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp-richiesta-avvisi/v1\"\n| where operationId_s == \"${ops.ra_nodoChiediNumeroAvviso}\" // nodoChiediNumeroAvviso\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "RichiestaAvvisi - nodoChiediNumeroAvviso"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 100,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "e329eb46-bb73-48af-a643-5b71d8b742f1",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp-richiesta-avvisi/v1\"\n| where operationId_s == \"${ops.ra_nodoChiediNumeroAvviso}\" // nodoChiediNumeroAvviso\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "RichiestaAvvisi - nodoChiediNumeroAvviso"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 104,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "197c42a8-090d-4805-87cc-535ba50a05bb",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp-richiesta-avvisi/v1\"\n| where operationId_s == \"${ops.ra_nodoChiediCatalogoServizi}\" // nodoChiediCatalogoServizi\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Availability (5m)",
                "subtitle": "RichiestaAvvisi - nodoChiediCatalogoServizi"
              }
            }
          },
          {
            "position": {
              "x": 6,
              "y": 104,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "fb706e82-9609-43df-8aa2-f0c9f01e308a",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp-richiesta-avvisi/v1\"\n| where operationId_s == \"${ops.ra_nodoChiediCatalogoServizi}\" // nodoChiediCatalogoServizi\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Response Codes (5m)",
                "subtitle": "RichiestaAvvisi - nodoChiediCatalogoServizi"
              }
            }
          },
          {
            "position": {
              "x": 12,
              "y": 104,
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
                      "${apim_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "5bf4e534-7936-4616-bddc-814297eed182",
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
                  "value": {
                    "scope": "hierarchy"
                  },
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/nodo-per-psp-richiesta-avvisi/v1\"\n| where operationId_s == \"${ops.ra_nodoChiediCatalogoServizi}\" // nodoChiediCatalogoServizi\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                  "value": "Log Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${apim_name}",
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
                        "type": "real"
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
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {},
              "partHeader": {
                "title": "Percentile Response Time (5m)",
                "subtitle": "RichiestaAvvisi - nodoChiediCatalogoServizi"
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
              "duration": 4,
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
                "relative": "4h"
              },
              "displayCache": {
                "name": "Local Time",
                "value": "Past 4 hours"
              },
              "filteredPartIds": [
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000001",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000002",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000003",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000004",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000005",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000006",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000007",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000008",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000009",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000010",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000011",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000012",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000013",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000014",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000015",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000016",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000017",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000018",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000019",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000020",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000021",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000022",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000023",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000024",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000025",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000026",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000027",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000028",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000029",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000030",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000031",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000032",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000033",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000034",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000035",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000036",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000037",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000038",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000039",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000040",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000041",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000042",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000043",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000044",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000045",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000046",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000047",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000048",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000049",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000050",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000051",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000052",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000053",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000054",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000055",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000056",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000057",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000058",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000059",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000060",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000061",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000062",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000063",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000064",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000065",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000066",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000067",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000068",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000069",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000070",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000071",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000072",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000073",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000074",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000075",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000076",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000077",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000078",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000079",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000080",
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000081"
              ]
            }
          }
        }
      }
    }
  },
  "name": "opex_pagopa-nodo-auth-all",
  "type": "Microsoft.Portal/dashboards",
  "location": "INSERT LOCATION",
  "tags": {
    "hidden-title": "opex_pagopa-nodo-auth-all"
  },
  "apiVersion": "2022-12-01-preview"
}