{
  "openapi": "3.0.0",
  "info": {
    "version": "0.1.0",
    "title": "Pagopa eCommerce transaction results update service",
    "description": "This microservice handles transaction results update according SendPaymentResult."
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/transactions/{transactionId}": {
      "patch": {
        "operationId": "patchTransactionStatus",
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
        "summary": "Patch status of specific transaction",
        "requestBody": {
          "$ref": "#/components/requestBodies/UpdateTransactionStatusRequest"
        },
        "responses": {
          "200": {
            "description": "Transaction data successfully updated",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TransactionInfo"
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
          "409": {
            "description": "Illegal transaction status",
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
      "RptId": {
        "type": "string",
        "pattern": "([a-zA-Z\\d]{1,35})|(RF\\d{2}[a-zA-Z\\d]{1,21})"
      },
      "NewTransactionResponse": {
        "type": "object",
        "description": "Transaction data returned when creating a new transaction",
        "properties": {
          "transactionId": {
            "type": "string"
          },
          "paymentToken": {
            "type": "string"
          },
          "rptId": {
            "$ref": "#/components/schemas/RptId"
          },
          "reason": {
            "type": "string"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents",
            "minLength": 1,
            "maxLength": 140
          },
          "authToken": {
            "type": "string"
          }
        },
        "required": [
          "transactionId",
          "amount"
        ],
        "example": {
          "amount": 200
        }
      },
      "UpdateTransactionStatusRequest": {
        "type": "object",
        "description": "Request body for updating a transaction",
        "properties": {
          "authorizationResult": {
            "$ref": "#/components/schemas/AuthorizationResult"
          },
          "timestampOperation": {
            "type": "string",
            "format": "date-time",
            "description": "Payment timestamp"
          },
          "authorizationCode": {
            "type": "string",
            "description": "Payment gateway-specific authorization code related to the transaction"
          }
        },
        "required": [
          "authorizationResult",
          "timestampOperation",
          "authorizationCode"
        ]
      },
      "TransactionInfo": {
        "description": "Transaction data returned when querying for an existing transaction",
        "allOf": [
          {
            "$ref": "#/components/schemas/NewTransactionResponse"
          },
          {
            "type": "object",
            "properties": {
              "status": {
                "$ref": "#/components/schemas/TransactionStatus"
              }
            },
            "required": [
              "status"
            ]
          }
        ],
        "example": {
          "amount": 200,
          "status": "INITIALIZED"
        }
      },
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 99999999
      },
      "AuthorizationResult": {
        "description": "Authorization result",
        "type": "string",
        "enum": [
          "OK",
          "KO"
        ]
      },
      "TransactionStatus": {
        "type": "string",
        "description": "Possible statuses a transaction can be in",
        "enum": [
          "INITIALIZED",
          "AUTHORIZATION_REQUESTED",
          "AUTHORIZED",
          "AUTHORIZATION_FAILED",
          "CLOSED",
          "CLOSURE_FAILED",
          "NOTIFIED",
          "NOTIFIED_FAILED"
        ]
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
    },
    "requestBodies": {
      "UpdateTransactionStatusRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/UpdateTransactionStatusRequest"
            }
          }
        }
      }
    }
  }
}