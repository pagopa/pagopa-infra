{
  "openapi": "3.0.3",
  "info": {
    "title": "Pagopa Debt Position Handler API",
    "description": "API's that will be used for pagoPA POS flow integration",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    },
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "tags": [
    {
      "name": "pagopa-internal",
      "description": "APIs that will be implemented/exposed by pagoPA internal services to handle payment position creation, payment and reporting"
    }
  ],
  "externalDocs": {
    "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/2813689945/DR+PFM-1+-+Vista+Dinamica+delle+Componenti",
    "description": "Design review"
  },
  "security": [
    {
      "PagopaInternalApiKeyAuth": []
    }
  ],
  "paths": {
    "/debt-positions/{orgFiscalCode}": {
      "post": {
        "tags": [
          "pagopa-internal"
        ],
        "summary": "Create a new debt position",
        "security": [
          {
            "PagopaInternalApiKeyAuth": []
          }
        ],
        "description": "Trigger a position creation invoking external service",
        "operationId": "createDebtPosition",
        "parameters": [
          {
            "$ref": "#/components/parameters/CorrelationId"
          },
          {
            "name": "orgFiscalCode",
            "in": "path",
            "required": true,
            "description": "The creditor institution fiscal code",
            "schema": {
              "type": "string",
              "example": "77777777777"
            }
          },
          {
            "name": "toPublish",
            "in": "query",
            "required": false,
            "schema": {
              "type": "boolean",
              "default": true
            }
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/DebtPositionRequest"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Debt position created successfully",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/DebtPositionResponse"
                }
              }
            }
          },
          "400": {
            "description": "Formally invalid input",
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
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "status": 401,
                  "detail": "Unauthorized"
                }
              }
            }
          },
          "404": {
            "description": "Not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "409": {
            "description": "Conflict",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "429": {
            "description": "Too many requests",
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
          },
          "502": {
            "description": "Bad gateway",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "503": {
            "description": "Service unavailable",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "504": {
            "description": "Gateway timeout",
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
    "parameters": {
      "CorrelationId": {
        "name": "x-correlation-id",
        "in": "header",
        "required": true,
        "schema": {
          "type": "string",
          "format": "uuid"
        },
        "description": "Subsequent api call correlation field. This should be the same for all api's invoked in a given user session to track each call and for troubleshooting"
      }
    },
    "schemas": {
      "Amount": {
        "minimum": 1,
        "type": "integer",
        "description": "Amount expressed in eurocents",
        "format": "int64"
      },
      "Debtor": {
        "type": "object",
        "required": [
          "type",
          "fiscalCode",
          "fullName"
        ],
        "properties": {
          "type": {
            "type": "string",
            "enum": [
              "G",
              "F"
            ],
            "description": "debtor type. F -> physical person, G -> legal entity"
          },
          "fiscalCode": {
            "maxLength": 16,
            "minLength": 11,
            "type": "string",
            "example": "ROSMRI87A04H501K",
            "description": "debtor fiscal code"
          },
          "fullName": {
            "maxLength": 140,
            "minLength": 0,
            "type": "string",
            "example": "Mario Rossi",
            "description": "debtor full name"
          }
        }
      },
      "DebtPositionRequest": {
        "type": "object",
        "required": [
          "companyName",
          "iupd",
          "officeName",
          "debtor",
          "paymentOption",
          "switchToExpired"
        ],
        "properties": {
          "companyName": {
            "maxLength": 140,
            "minLength": 0,
            "type": "string",
            "example": "Comune di Fantasia"
          },
          "iupd": {
            "type": "string",
            "example": "IUPD-2024-XYZ-001"
          },
          "officeName": {
            "maxLength": 140,
            "minLength": 0,
            "type": "string",
            "example": "Ufficio Anagrafe"
          },
          "switchToExpired": {
            "type": "boolean",
            "default": false
          },
          "debtor": {
            "$ref": "#/components/schemas/Debtor"
          },
          "paymentOption": {
            "$ref": "#/components/schemas/PaymentOption"
          }
        }
      },
      "PaymentOption": {
        "type": "object",
        "required": [
          "installment"
        ],
        "properties": {
          "installment": {
            "$ref": "#/components/schemas/InstallmentDetail"
          }
        }
      },
      "TransferItem": {
        "type": "object",
        "required": [
          "amount",
          "remittanceInformation",
          "iban",
          "category"
        ],
        "properties": {
          "amount": {
            "$ref": "#/components/schemas/Amount"
          },
          "remittanceInformation": {
            "maxLength": 140,
            "minLength": 0,
            "type": "string",
            "description": "remittance information following EACT standard as /RFB/{iuv}/CNR/{userFiscalCode}/TXT/{TransferDescription})",
            "example": "/RFB/00000000000000000/CNR/AAAAAAAAAAAAAAAA/TXT/The payment description"
          },
          "iban": {
            "maxLength": 35,
            "minLength": 1,
            "pattern": "^[A-Za-z0-9]{1,35}$",
            "type": "string",
            "example": "IT0000000000000000000000000"
          },
          "category": {
            "type": "string",
            "description": "collection services pagoPA taxonomy code",
            "pattern": "(?:6|7|8|9)\\/\\d{7}(?:IM|TS|SP|SA|AP)\\/",
            "maxLength": 12,
            "minLength": 12
          }
        }
      },
      "InstallmentDetail": {
        "type": "object",
        "required": [
          "iuv",
          "description",
          "dueDate",
          "transferList"
        ],
        "properties": {
          "transferList": {
            "type": "array",
            "minItems": 1,
            "maxItems": 5,
            "items": {
              "$ref": "#/components/schemas/TransferItem"
            }
          },
          "iuv": {
            "type": "string",
            "example": "020001000000123456"
          },
          "description": {
            "maxLength": 140,
            "minLength": 0,
            "type": "string",
            "description": "payment description",
            "example": "Tassa Rifiuti 2024"
          },
          "dueDate": {
            "type": "string",
            "format": "date-time",
            "example": "2024-12-31T23:59:59Z"
          },
          "installmentMetadata": {
            "type": "object",
            "example": {
              "channel": "POS"
            }
          }
        }
      },
      "DebtPositionResponse": {
        "type": "object",
        "required": [
          "creditorInstitutionFiscalCode",
          "noticeNumber",
          "iuv",
          "iupd"
        ],
        "properties": {
          "creditorInstitutionFiscalCode": {
            "type": "string",
            "example": "80001230456"
          },
          "noticeNumber": {
            "type": "string",
            "example": "302000100000012345"
          },
          "iuv": {
            "type": "string",
            "example": "020001000000123456"
          },
          "iupd": {
            "type": "string",
            "example": "IUPD-2024-XYZ-001"
          },
          "status": {
            "type": "string",
            "enum": [
              "DRAFT",
              "PUBLISHED",
              "VALID",
              "UNPAYABLE",
              "PARTIALLY_PAID",
              "PAID"
            ]
          }
        }
      },
      "ProblemJson": {
        "description": "Body definition for error responses containing failure details",
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
            "description": "A short, summary of the problem type. Written in english and readable for engineers (usually not suited for non technical stakeholders and not localized); example: Service Unavailable"
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
            "description": "An absolute URI that identifies the specific occurrence of the problem. It may or may not yield further information if dereferenced."
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
    },
    "securitySchemes": {
      "PagopaInternalApiKeyAuth": {
        "type": "apiKey",
        "in": "header",
        "name": "Ocp-Apim-Subscription-Key",
        "description": "api key authentication, with subscriptions handled by single products that will release api key to POS gateway components"
      }
    }
  }
}
