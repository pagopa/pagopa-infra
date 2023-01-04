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
        "parameters": [
          {
            "in": "header",
            "name": "x-transaction-origin",
            "schema": {
              "type": "string",
              "pattern": "IO|CHECKOUT|CHECKOUT_CART"
            },
            "required": false,
            "description": "Transaction origin (populated by APIM policy)"
          }
        ],
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
    "/transactions/{paymentToken}": {
      "get": {
        "operationId": "getTransactionInfo",
        "parameters": [
          {
            "in": "path",
            "name": "paymentToken",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Payment token associated to transaction"
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
      "Iban": {
        "type": "string",
        "pattern": "[a-zA-Z]{2}[0-9]{2}[a-zA-Z0-9]{1,30}"
      },
      "NewTransactionRequest": {
        "type": "object",
        "description": "Request body for creating a new transaction",
        "properties": {
          "rptId": {
            "$ref": "#/components/schemas/RptId"
          },
          "email": {
            "type": "string"
          }
        },
        "required": [
          "rptId",
          "email"
        ],
        "example": {
          "rptId": "string"
        }
      },
      "NewTransactionResponse": {
        "type": "object",
        "description": "Transaction data returned when creating a new transaction",
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
            "$ref": "#/components/schemas/AmountEuroCents",
            "minLength": 1,
            "maxLength": 140
          },
          "authToken": {
            "type": "string"
          }
        },
        "required": [
          "amount"
        ],
        "example": {
          "amount": 200
        }
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
      "Beneficiary": {
        "description": "Beneficiary institution related to a payment",
        "type": "object",
        "properties": {
          "beneficiaryId": {
            "type": "string",
            "minLength": 1,
            "maxLength": 35
          },
          "denominazioneBeneficiario": {
            "type": "string",
            "minLength": 1,
            "maxLength": 70
          },
          "codiceUnitOperBeneficiario": {
            "type": "string",
            "minLength": 1,
            "maxLength": 35
          },
          "denomUnitOperBeneficiario": {
            "type": "string",
            "minLength": 1,
            "maxLength": 70
          },
          "address": {
            "type": "string",
            "minLength": 1,
            "maxLength": 70
          },
          "streetNumber": {
            "type": "string",
            "minLength": 1,
            "maxLength": 16
          },
          "postalCode": {
            "type": "string",
            "minLength": 1,
            "maxLength": 16
          },
          "city": {
            "type": "string",
            "minLength": 1,
            "maxLength": 35
          },
          "province": {
            "type": "string",
            "minLength": 1,
            "maxLength": 35
          },
          "country": {
            "type": "string",
            "pattern": "[A-Z]{2}"
          }
        },
        "required": [
          "beneficiaryId",
          "denominazioneBeneficiario"
        ]
      },
      "PaymentInstallments": {
        "description": "Payment installments (optional)",
        "type": "array",
        "items": {
          "$ref": "#/components/schemas/Installment"
        }
      },
      "Installment": {
        "description": "Payment installment",
        "type": "object",
        "properties": {
          "installment": {
            "type": "string",
            "minLength": 1,
            "maxLength": 35
          },
          "data": {
            "$ref": "#/components/schemas/InstallmentDetails"
          }
        }
      },
      "InstallmentDetails": {
        "description": "Amount and reason related to a payment installment",
        "type": "object",
        "properties": {
          "reason": {
            "type": "string",
            "minLength": 1,
            "maxLength": 25
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        }
      },
      "TransactionStatus": {
        "type": "string",
        "description": "Possible statuses a transaction can be in",
        "enum": [
          "INITIALIZED"
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
    }
  }
}