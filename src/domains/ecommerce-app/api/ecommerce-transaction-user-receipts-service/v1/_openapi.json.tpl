{
  "openapi": "3.0.0",
  "info": {
    "version": "0.0.1",
    "title": "Pagopa eCommerce user receipt service",
    "description": "This microservice handle transaction user receipt generation",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "tags": [
    {
      "name": "transactions",
      "description": "Api for handle transaction user receipts",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/611287199/-servizio+transactions+service",
        "description": "Technical specifications"
      }
    }
  ],
  "externalDocs": {
    "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/492339720/pagoPA+eCommerce+Design+Review",
    "description": "Design review"
  },
  "security": [
    {
      "ApiKeyAuth": []
    }
  ],
  "paths": {
    "/transactions/{transactionId}/user-receipts": {
      "post": {
        "tags": [
          "transactions"
        ],
        "operationId": "addUserReceipt",
        "parameters": [
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Transaction ID"
          }
        ],
        "summary": "Add user receipt",
        "description": "Callback endpoint used for generate user receipt for the transaction",
        "requestBody": {
          "$ref": "#/components/requestBodies/AddUserReceiptRequest"
        },
        "responses": {
          "200": {
            "description": "Receipt successfully added",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/AddUserReceiptResponse"
                }
              }
            }
          },
          "400": {
            "description": "Invalid transaction id",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized, access token missing or invalid"
          },
          "404": {
            "description": "Transaction not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "422": {
            "description": "Unprocessable entity (most likely the transaction is in an invalid state)",
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
      "AddUserReceiptRequest": {
        "type": "object",
        "description": "Request body for adding a user receipt to a transaction",
        "properties": {
          "outcome": {
            "type": "string",
            "description": "Nodo outcome enum",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "paymentDate": {
            "type": "string",
            "description": "Timestamp of transaction verification/activation",
            "format": "date-time"
          },
          "payments": {
            "type": "array",
            "description": "Payments associated to this transaction",
            "items": {
              "type": "object",
              "description": "Payment",
              "properties": {
                "paymentToken": {
                  "type": "string",
                  "description": "Payment token associated to this payment"
                },
                "description": {
                  "type": "string",
                  "description": "Payment description"
                },
                "creditorReferenceId": {
                  "type": "string",
                  "description": "Creditor reference id"
                },
                "fiscalCode": {
                  "type": "string",
                  "description": "Receiving body fiscal code"
                },
                "companyName": {
                  "type": "string",
                  "description": "Receiving body public name"
                },
                "officeName": {
                  "type": "string",
                  "description": "Receiving office name"
                },
                "debtor": {
                  "type": "string",
                  "description": "Debtor's id"
                }
              },
              "required": [
                "paymentToken",
                "description",
                "creditorReferenceId",
                "fiscalCode",
                "debtor"
              ]
            },
            "minItems": 1,
            "maxItems": 5
          }
        },
        "required": [
          "outcome",
          "paymentDate",
          "payments"
        ]
      },
      "AddUserReceiptResponse": {
        "type": "object",
        "description": "Response body for adding user receipt",
        "properties": {
          "outcome": {
            "type": "string",
            "description": "Nodo outcome enum",
            "enum": [
              "OK",
              "KO"
            ]
          }
        },
        "required": [
          "outcome"
        ]
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
    },
    "requestBodies": {
      "AddUserReceiptRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/AddUserReceiptRequest"
            }
          }
        }
      }
    },
    "securitySchemes": {
      "ApiKeyAuth": {
        "type": "apiKey",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  }
}
