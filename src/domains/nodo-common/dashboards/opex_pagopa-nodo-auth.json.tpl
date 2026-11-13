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
                  "value": "a828a5c4-539b-4ef5-b987-32c11941a7c7",
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
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_verifyPaymentNotice}\" // verifyPaymentNotice\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                "subtitle": "verifyPaymentNotice"
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
                  "value": "fe4c1b60-01bd-4e9f-aa06-68cd2b28ff13",
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
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_verifyPaymentNotice}\" // verifyPaymentNotice\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                "subtitle": "verifyPaymentNotice"
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
                  "value": "43d66f78-20f0-4ccc-9f8b-53c12a904efb",
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
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_verifyPaymentNotice}\" // verifyPaymentNotice\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                "subtitle": "verifyPaymentNotice"
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
                  "value": "44f3444d-afe7-4d4e-b03f-d6e4263cc394",
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
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_activatePaymentNotice}\" // activatePaymentNotice\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                "subtitle": "activatePaymentNotice"
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
                  "value": "ab6200e9-f388-4d37-9b2b-afcfcd42a713",
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
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_activatePaymentNotice}\" // activatePaymentNotice\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                "subtitle": "activatePaymentNotice"
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
                  "value": "fc651b3c-b27c-465b-9983-96f269c72575",
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
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_activatePaymentNotice}\" // activatePaymentNotice\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                "subtitle": "activatePaymentNotice"
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
                  "value": "74f5420a-1d30-43a6-be82-9e7c2aa8c68a",
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
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_activatePaymentNoticeV2}\" // activatePaymentNoticeV2\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                "subtitle": "activatePaymentNoticeV2"
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
                  "value": "2f2e1a18-daec-4c8e-b75b-26196098ecff",
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
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_activatePaymentNoticeV2}\" // activatePaymentNoticeV2\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                "subtitle": "activatePaymentNoticeV2"
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
                  "value": "c94ac27c-56d1-43e9-b1b9-acd878b13826",
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
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_activatePaymentNoticeV2}\" // activatePaymentNoticeV2\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                "subtitle": "activatePaymentNoticeV2"
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
                  "value": "b43074c4-32f2-407c-b18c-4fc4bbb00085",
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
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_sendPaymentOutcome}\" // sendPaymentOutcome\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                "subtitle": "sendPaymentOutcome"
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
                  "value": "2fd27afb-b47e-497b-aa8a-c76e7d8ab462",
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
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_sendPaymentOutcome}\" // sendPaymentOutcome\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                "subtitle": "sendPaymentOutcome"
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
                  "value": "72a909de-5e4d-4908-8bc7-73f49138eb50",
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
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_sendPaymentOutcome}\" // sendPaymentOutcome\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                "subtitle": "sendPaymentOutcome"
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
                  "value": "11ef6116-386a-4022-ada5-4a2fe003edc1",
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
                  "value": "let threshold = 0.99;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_sendPaymentOutcomeV2}\" // sendPaymentOutcomeV2\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| summarize\n  Total=count(),\n  Success=count(responseCode_d < 500 and responseCode_d != 0) by bin(TimeGenerated, 5m)\n| extend availability=toreal(Success) / Total\n| project TimeGenerated, availability, watermark=threshold\n| render timechart with (xtitle = \"time\", ytitle= \"availability(%)\")",
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
                "subtitle": "sendPaymentOutcomeV2"
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
                  "value": "2431a623-d327-496a-a432-d085f946c20d",
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
                  "value": "AzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_sendPaymentOutcomeV2}\" // sendPaymentOutcomeV2\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| extend HTTPStatus = case(\n  responseCode_d between (100 .. 199), \"1XX\",\n  responseCode_d between (200 .. 299), \"2XX\",\n  responseCode_d between (300 .. 399), \"3XX\",\n  responseCode_d between (400 .. 499), \"4XX\",\n  \"5XX\")\n| summarize count() by HTTPStatus, bin(TimeGenerated, 5m)\n| render areachart with (xtitle = \"time\", ytitle= \"count\")",
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
                "subtitle": "sendPaymentOutcomeV2"
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
                  "value": "ed29796e-8565-4c87-bd9b-b9e82d7af1d3",
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
                  "value": "let threshold = 7.0;\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s == \"${op_sendPaymentOutcomeV2}\" // sendPaymentOutcomeV2\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| summarize\n    watermark=threshold,\n    duration_percentile_95=percentiles(todouble(DurationMs)/1000, 95) by bin(TimeGenerated, 5m)\n| render timechart with (xtitle = \"time\", ytitle= \"response time(s)\")",
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
                "subtitle": "sendPaymentOutcomeV2"
              }
            }
          },
          {
            "position": {
              "x": 0,
              "y": 20,
              "colSpan": 18,
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
                  "value": "ae9b8444-d297-4055-9022-fbf3a854e3d9",
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
                  "value": "let opNames = datatable(operationId_s:string, apiName:string) [ ${operation_names_kql} ];\nAzureDiagnostics\n| where url_s matches regex \"/nodo-auth/node-for-psp/v1\"\n| where operationId_s !in (${handled_operation_ids_kql})\n| where backendUrl_s !startswith \"${excluded_backend_url}\"\n| summarize count() by operationId_s, bin(TimeGenerated, 1d)\n| lookup kind=leftouter opNames on operationId_s\n| project TimeGenerated, apiName=iff(isempty(operationId_s), \"ResourceNotFound-404\", coalesce(apiName, operationId_s)), count_\n| render columnchart with (xtitle = \"time\", ytitle = \"count\")",
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
                        "name": "apiName",
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
                "title": "Unhandled API invocations (1d)",
                "subtitle": "APIs not handled by Nodo"
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
                "StartboardPart-LogsDashboardPart-c0ffee00-0000-4a00-9000-000000000016"
              ]
            }
          }
        }
      }
    }
  },
  "name": "opex_pagopa-nodo-auth-nm3-only-PagoPA-node",
  "type": "Microsoft.Portal/dashboards",
  "location": "INSERT LOCATION",
  "tags": {
    "hidden-title": "opex_pagopa-nodo-auth-nm3-only-PagoPA-node"
  },
  "apiVersion": "2022-12-01-preview"
}