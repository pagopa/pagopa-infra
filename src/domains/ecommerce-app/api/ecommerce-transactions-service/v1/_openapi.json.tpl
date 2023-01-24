{
  "openapi": "3.0.0",
  "info": {
    "version": "0.1.0",
    "title": "Pagopa eCommerce payment transactions service",
    "description": "This microservice that handles transactions' lifecycle and workflow."
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/transactions": {
      "post": {
        "operationId": "newTransaction",
        "summary": "Make a new transaction",
        "requestBody": {
          "$ref": "#/components/requestBodies/NewTransactionRequest"
        },
        "responses": {
          "200": {
            "description": "New transaction successfully created",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/NewTransactionResponse"
                }
              }
            }
          }
        }
      }
    },
    "/transactions/{transactionId}": {
      "get": {
        "operationId": "getTransactionInfo",
        "security": [
          {
            "bearerAuth": []
          }
        ],
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
        "summary": "Get information about a specific transaction",
        "responses": {
          "200": {
            "description": "Transaction data successfully retrieved",
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
      "PaymentContextCode": {
        "description": "Payment context code used for verifivaRPT/attivaRPT",
        "type": "string",
        "minLength": 32,
        "maxLength": 32
      },
      "PaymentNoticeInfo": {
        "description": "Informations about a single payment notice",
        "type": "object",
        "properties": {
          "rptId": {
            "$ref": "#/components/schemas/RptId"
          },
          "paymentContextCode": {
            "$ref": "#/components/schemas/PaymentContextCode"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "rptId",
          "amount"
        ],
        "example": {
          "rptId": "string",
          "paymentContextCode": "paymentContextCode",
          "amount": 100
        }
      },
      "PaymentInfo": {
        "description": "Informations about transaction payments",
        "type": "object",
        "properties": {
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
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "rptId",
          "amount"
        ],
        "example": {
          "rptId": "77777777777302012387654312384",
          "paymentToken": "paymentToken1",
          "reason": "reason1",
          "amount": 100
        }
      },
      "NewTransactionRequest": {
        "type": "object",
        "description": "Request body for creating a new transaction",
        "properties": {
          "paymentNotices": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentNoticeInfo"
            },
            "minItems": 1,
            "maxItems": 5,
            "example": [
              {
                "rptId": "77777777777302012387654312384",
                "paymentContextCode": "paymentContextCode1",
                "amount": 100
              },
              {
                "rptId": "77777777777302012387654312385",
                "paymentContextCode": "paymentContextCode2",
                "amount": 200
              }
            ]
          },
          "email": {
            "type": "string"
          }
        },
        "required": [
          "paymentNotices",
          "email"
        ]
      },
      "NewTransactionResponse": {
        "type": "object",
        "description": "Transaction data returned when creating a new transaction",
        "properties": {
          "transactionId": {
            "type": "string"
          },
          "payments": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentInfo"
            },
            "minItems": 1,
            "maxItems": 5,
            "example": [
              {
                "rptId": "77777777777302012387654312384",
                "paymentToken": "paymentToken1",
                "reason": "reason1",
                "amount": 100
              },
              {
                "rptId": "77777777777302012387654312385",
                "paymentToken": "paymentToken2",
                "reason": "reason2",
                "amount": 100
              }
            ]
          },
          "status": {
            "$ref": "#/components/schemas/TransactionStatus"
          },
          "amountTotal": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "feeTotal": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "clientId": {
            "description": "transaction client id",
            "type": "string",
            "enum": [
              "IO",
              "CHECKOUT",
              "CHECKOUT_CART",
              "UNKNOWN"
            ]
          },
          "authToken": {
            "type": "string"
          }
        },
        "required": [
          "transactionId",
          "amountTotal",
          "status",
          "payments"
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
        ]
      },
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 99999999
      },
      "TransactionStatus": {
        "type": "string",
        "description": "Possible statuses a transaction can be in",
        "enum": [
          "ACTIVATION_REQUESTED",
          "ACTIVATED",
          "AUTHORIZATION_REQUESTED",
          "AUTHORIZED",
          "AUTHORIZATION_FAILED",
          "CLOSED",
          "CLOSURE_FAILED",
          "NOTIFIED",
          "NOTIFIED_FAILED",
          "EXPIRED",
          "REFUNDED"
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
      "NewTransactionRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/NewTransactionRequest"
            }
          }
        }
      }
    },
    "securitySchemes": {
      "bearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "bearerFormat": "JWT"
      }
    }
  }
}