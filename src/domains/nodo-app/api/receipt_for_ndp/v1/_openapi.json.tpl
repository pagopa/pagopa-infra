{
  "openapi": "3.0.0",
  "info": {
    "version": "2.0.0",
    "title": "Receipt sendPaymentResult for NDP ${service}",
    "description": "PM Apis per Nodo"
  },
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "paths": {
    "/transactions/{transactionId}/user-receipts": {
      "post": {
        "operationId": "addUserReceipt",
        "parameters": [
          {
            "in": "query",
            "name": "clientId",
            "schema": {
              "type": "string",
              "enum": ["swclient","ecomm"]
            },
            "required": true,
            "description": "Identify who to call among `swclient` or `ecomm`"
          },
          {
            "in": "query",
            "name": "deviceId",
            "schema": {
              "type": "string"
            },
            "required": false,
            "description": "Used iff `clientId` is `swclient` shall contains `<AQUIRER_ID> + \"|\" + <CLIENT_ID>`"
          },            
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Transaction ID"
          },
        
        ],
        "summary": "Add receipt for user to specific transaction",
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
          "500": {
            "description": "Internal Server Error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "502": {
            "description": "Service Dependency Error",
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
                "companyName",
                "officeName",
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
      "HttpStatusCode": {
        "type": "integer",
        "format": "int32",
        "description": "The HTTP status code generated by the origin server for this occurrence\nof the problem.",
        "minimum": 100,
        "maximum": 600,
        "exclusiveMaximum": true,
        "example": 200
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
    }
  }
}