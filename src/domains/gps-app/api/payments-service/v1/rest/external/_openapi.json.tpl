{
  "openapi": "3.0.1",
  "info": {
    "title": "PagoPA API Payments",
    "description": "Payments",
    "termsOfService": "https://www.pagopa.gov.it/",
    "version": "0.8.0-1-PAGOPA-1140-sviluppo-gpd-payments-gestione-enti-pluri-intermediati"
  },
  "servers": [
    {
      "url": "${host}",
      "description": "Generated server url"
    }
  ],
  "tags": [
    {
      "name": "Payments receipts API"
    }
  ],
  "paths": {
    "/info": {
      "get": {
        "tags": [
          "Home"
        ],
        "summary": "health check",
        "description": "Return OK if application is started",
        "operationId": "healthCheck",
        "responses": {
          "200": {
            "description": "OK",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AppInfo"
                }
              }
            }
          },
          "400": {
            "description": "Bad Request",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "403": {
            "description": "Forbidden",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "429": {
            "description": "Too many requests",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ]
      },
      "parameters": [
        {
          "name": "X-Request-Id",
          "in": "header",
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/payments/{organizationfiscalcode}/receipts": {
      "get": {
        "tags": [
          "Payments receipts API"
        ],
        "summary": "Return the list of the organization receipts.",
        "operationId": "getOrganizationReceipts",
        "parameters": [
          {
            "name": "organizationfiscalcode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "pageNum",
            "in": "query",
            "description": "Page number",
            "required": true,
            "schema": {
              "minimum": 0,
              "type": "integer",
              "format": "int32"
            }
          },
          {
            "name": "pageSize",
            "in": "query",
            "description": "Number of elements per page. Default = 50",
            "required": false,
            "schema": {
              "maximum": 100,
              "type": "integer",
              "format": "int32",
              "default": 50
            }
          },
          {
            "name": "debtor",
            "in": "query",
            "description": "Filter by debtor",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "service",
            "in": "query",
            "description": "Filter by service",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "from",
            "in": "query",
            "description": "Filter by date, from this date",
            "required": false,
            "schema": {
              "type": "string"
            }
          },
          {
            "name": "to",
            "in": "query",
            "description": "Filter by date, to this date",
            "required": false,
            "schema": {
              "type": "string"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Obtained all organization payment positions.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ReceiptsInfo"
                }
              }
            }
          },
          "401": {
            "description": "Wrong or missing function key.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "description": "No receipts found.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ]
      },
      "parameters": [
        {
          "name": "X-Request-Id",
          "in": "header",
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "schema": {
            "type": "string"
          }
        }
      ]
    },
    "/payments/{organizationfiscalcode}/receipts/{iuv}": {
      "get": {
        "tags": [
          "Payments receipts API"
        ],
        "summary": "Return the details of a specific receipt.",
        "operationId": "getReceiptByIUV",
        "parameters": [
          {
            "name": "organizationfiscalcode",
            "in": "path",
            "description": "Organization fiscal code, the fiscal code of the Organization.",
            "required": true,
            "schema": {
              "type": "string"
            },
            "example": 12345
          },
          {
            "name": "iuv",
            "in": "path",
            "description": "IUV (Unique Payment Identification). Alphanumeric code that uniquely associates and identifies three key elements of a payment: reason, payer, amount",
            "required": true,
            "schema": {
              "type": "string"
            },
            "example": "ABC123"
          }
        ],
        "responses": {
          "200": {
            "description": "Obtained receipt details.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/xml": {
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "401": {
            "description": "Wrong or missing function key.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            }
          },
          "404": {
            "description": "No receipt found.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/xml": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "422": {
            "description": "Unable to process the request.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/xml": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500": {
            "description": "Service unavailable.",
            "headers": {
              "X-Request-Id": {
                "description": "This header identifies the call",
                "schema": {
                  "type": "string"
                }
              }
            },
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          }
        },
        "security": [
          {
            "ApiKey": []
          },
          {
            "Authorization": []
          }
        ]
      },
      "parameters": [
        {
          "name": "X-Request-Id",
          "in": "header",
          "description": "This header identifies the call, if not passed it is self-generated. This ID is returned in the response.",
          "schema": {
            "type": "string"
          }
        }
      ]
    }
  },
  "components": {
    "schemas": {
      "ProblemJson": {
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
          },
          "status": {
            "maximum": 600,
            "minimum": 100,
            "type": "integer",
            "description": "The HTTP status code generated by the origin server for this occurrence of the problem.",
            "format": "int32",
            "example": 200
          },
          "detail": {
            "type": "string",
            "description": "A human readable explanation specific to this occurrence of the problem.",
            "example": "There was an error processing the request"
          }
        }
      },
      "ReceiptModelResponse": {
        "type": "object",
        "properties": {
          "organizationFiscalCode": {
            "type": "string"
          },
          "iuv": {
            "type": "string"
          },
          "debtor": {
            "type": "string"
          },
          "paymentDateTime": {
            "type": "string"
          },
          "status": {
            "type": "string"
          }
        }
      },
      "ReceiptsInfo": {
        "required": [
          "receipts_list"
        ],
        "type": "object",
        "properties": {
          "receipts_list": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/ReceiptModelResponse"
            }
          }
        }
      },
      "AppInfo": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          },
          "version": {
            "type": "string"
          },
          "environment": {
            "type": "string"
          }
        }
      }
    },
    "securitySchemes": {
      "ApiKey": {
        "type": "apiKey",
        "description": "The API key to access this function app.",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      },
      "Authorization": {
        "type": "http",
        "description": "JWT token get after Azure Login",
        "scheme": "bearer",
        "bearerFormat": "JWT"
      }
    }
  }
}
