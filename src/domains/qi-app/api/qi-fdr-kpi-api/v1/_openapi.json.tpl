{
  "openapi": "3.0.3",
  "info": {
    "version": "1.0.0",
    "title": "pagoPA FdR KPI",
    "description": "API for retrieving FdR (Flusso di Rendicontazione) KPI metrics for both PSPs and PSP Brokers.\nFor direct PSP queries, use the PSP's fiscal code in the path.\nFor broker queries, use the broker's fiscal code in the path and specify the PSP code as a query parameter.\n"
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "tags": [
    {
      "name": "qiFdr",
      "description": "Api's for performing KPI calculation"
    }
  ],
  "paths": {
    "/fdr-kpi/{kpiType}": {
      "get": {
        "tags": [
          "qiFdr"
        ],
        "operationId": "calculateKpi",
        "parameters": [
          {
            "name": "kpiType",
            "in": "path",
            "required": true,
            "schema": {
              "type": "string",
              "enum": [
                "NRFDR",
                "LFDR",
                "WAFDR",
                "WPNFDR"
              ]
            },
            "description": "The type of KPI to calculate\n"
          },
          {
            "name": "brokerFiscalCode",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            },
            "description": "Broker fiscal code    \n"
          },
          {
            "name": "period",
            "in": "query",
            "required": true,
            "schema": {
              "type": "string",
              "enum": [
                "daily",
                "monthly"
              ]
            },
            "description": "The time period granularity (single day or calendar month)\n"
          },
          {
            "name": "date",
            "in": "query",
            "required": true,
            "schema": {
              "type": "string",
              "pattern": "^\\d{4}-(?:0[1-9]|1[0-2])(?:-(?:0[1-9]|[12]\\d|3[01]))?$",
              "example": "2024-09"
            },
            "description": "For daily KPIs: Specify the full date (YYYY-MM-DD). Must be at least 10 days before current date.\nFor monthly KPIs: Specify year and month (YYYY-MM).\n"
          },
          {
            "name": "pspId",
            "in": "query",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "KPI calculated",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/KPIResponse"
                }
              }
            }
          },
          "400": {
            "description": "Formally invalid input\nPossible error types:\n- DATE_TOO_RECENT: Daily KPI requests must be for dates at least 10 days in the past\n",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "examples": {
                  "dateTooRecent": {
                    "value": {
                      "title": "Date Too Recent",
                      "status": 400,
                      "detail": "Daily KPI requests must be for dates at least 10 days in the past"
                    }
                  }
                }
              }
            }
          },
          "404": {
            "description": "PSP or Broker not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500": {
            "description": "Internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "BaseKPIResponse": {
        "type": "object",
        "required": [
          "kpiDescription",
          "kpiDescriptionUrl"
        ],
        "properties": {
          "kpiDescription": {
            "type": "string"
          },
          "kpiDescriptionUrl": {
            "type": "string",
            "format": "uri",
            "example": "https://developer.pagopa.it/pago-pa/guides/sanp/prestatore-di-servizi-di-pagamento/quality-improvement"
          }
        }
      },
      "KPIEntityResponse": {
        "type": "object",
        "properties": {
          "idPsp": {
            "type": "string",
            "example": "CIPBITMM"
          },
          "entityType": {
            "type": "string",
            "enum": [
              "psp",
              "broker"
            ]
          },
          "kpiName": {
            "type": "string",
            "enum": [
              "NRFDR",
              "LFDR",
              "WAFDR",
              "WPNFDR"
            ]
          }
        },
        "allOf": [
          {
            "$ref": "#/components/schemas/BaseKPIResponse"
          },
          {
            "type": "object",
            "discriminator": {
              "propertyName": "entityType",
              "mapping": {
                "psp": "#/components/schemas/PSPIdentifier",
                "broker": "#/components/schemas/BrokerIdentifier"
              }
            }
          }
        ]
      },
      "DailyKPIBase": {
        "type": "object",
        "required": [
          "dailyPayment",
          "totalReports"
        ],
        "properties": {
          "dailyPayment": {
            "type": "string",
            "format": "date-time"
          },
          "totalReports": {
            "type": "integer"
          }
        }
      },
      "MonthlyKPIBase": {
        "type": "object",
        "required": [
          "kpiValue"
        ],
        "properties": {
          "kpiValue": {
            "type": "string",
            "example": "0.05"
          }
        }
      },
      "NRFDRMetrics": {
        "type": "object",
        "required": [
          "missingReports",
          "foundReports"
        ],
        "properties": {
          "missingReports": {
            "type": "integer"
          },
          "foundReports": {
            "type": "integer"
          }
        }
      },
      "LFDRMetrics": {
        "type": "object",
        "required": [
          "lateFdrV1",
          "lateFdrV2"
        ],
        "properties": {
          "lateFdrV1": {
            "type": "integer"
          },
          "lateFdrV2": {
            "type": "integer"
          },
          "kpiLfdrV1Value": {
            "type": "string"
          },
          "kpiLfdrV2Value": {
            "type": "string"
          }
        }
      },
      "WAFDRMetrics": {
        "type": "object",
        "required": [
          "totalDiffAmount"
        ],
        "properties": {
          "totalDiffAmount": {
            "type": "integer"
          }
        }
      },
      "WPNFDRMetrics": {
        "type": "object",
        "required": [
          "totalDiffNum"
        ],
        "properties": {
          "totalDiffNum": {
            "type": "integer"
          }
        }
      },
      "KPIResponse": {
        "type": "object",
        "properties": {
          "responseType": {
            "type": "string"
          }
        },
        "required": [
          "responseType"
        ],
        "oneOf": [
          {
            "$ref": "#/components/schemas/DailyKPIResponse"
          },
          {
            "$ref": "#/components/schemas/MonthlyKPIResponse"
          }
        ],
        "discriminator": {
          "propertyName": "responseType",
          "mapping": {
            "daily": "#/components/schemas/DailyKPIResponse",
            "monthly": "#/components/schemas/MonthlyKPIResponse"
          }
        }
      },
      "DailyKPIResponse": {
        "allOf": [
          {
            "$ref": "#/components/schemas/KPIEntityResponse"
          },
          {
            "$ref": "#/components/schemas/DailyKPIBase"
          },
          {
            "type": "object",
            "required": [
              "responseType"
            ],
            "properties": {
              "responseType": {
                "type": "string",
                "default": "daily"
              }
            }
          },
          {
            "oneOf": [
              {
                "$ref": "#/components/schemas/NRFDRMetrics"
              },
              {
                "$ref": "#/components/schemas/LFDRMetrics"
              },
              {
                "$ref": "#/components/schemas/WAFDRMetrics"
              },
              {
                "$ref": "#/components/schemas/WPNFDRMetrics"
              }
            ]
          }
        ],
        "discriminator": {
          "propertyName": "kpiName",
          "mapping": {
            "NRFDR": "#/components/schemas/NRFDRMetrics",
            "LFDR": "#/components/schemas/LFDRMetrics",
            "WAFDR": "#/components/schemas/WAFDRMetrics",
            "WPNFDR": "#/components/schemas/WPNFDRMetrics"
          }
        }
      },
      "MonthlyKPIResponse": {
        "allOf": [
          {
            "$ref": "#/components/schemas/KPIEntityResponse"
          },
          {
            "type": "object",
            "required": [
              "responseType"
            ],
            "properties": {
              "responseType": {
                "type": "string",
                "default": "monthly"
              }
            }
          },
          {
            "oneOf": [
              {
                "$ref": "#/components/schemas/MonthlyKPIBase"
              },
              {
                "$ref": "#/components/schemas/LFDRMetrics"
              }
            ]
          }
        ],
        "discriminator": {
          "propertyName": "kpiName",
          "mapping": {
            "NRFDR": "#/components/schemas/MonthlyKPIBase",
            "LFDR": "#/components/schemas/LFDRMetrics",
            "WAFDR": "#/components/schemas/MonthlyKPIBase",
            "WPNFDR": "#/components/schemas/MonthlyKPIBase"
          }
        }
      },
      "ProblemJson": {
        "type": "object",
        "properties": {
          "type": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the problem type. When dereferenced,\nit SHOULD provide human-readable documentation for the problem type\n(e.g., using HTML).",
            "default": "about:blank",
            "example": "https://example.com/problem/constraint-violation"
          },
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable\nfor engineers (usually not suited for non technical stakeholders and\nnot localized); example: Service Unavailable"
          },
          "status": {
            "$ref": "#/components/schemas/HttpStatusCode"
          },
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the\nproblem.",
            "example": "There was an error processing the request"
          },
          "instance": {
            "type": "string",
            "format": "uri",
            "description": "An absolute URI that identifies the specific occurrence of the problem.\nIt may or may not yield further information if dereferenced."
          }
        }
      },
      "HttpStatusCode": {
        "type": "integer",
        "format": "int32",
        "description": "The HTTP status code generated by the origin server for this occurrence\nof the problem.",
        "minimum": 100,
        "maximum": 600,
        "exclusiveMaximum": true,
        "example": 200
      }
    }
  }
}