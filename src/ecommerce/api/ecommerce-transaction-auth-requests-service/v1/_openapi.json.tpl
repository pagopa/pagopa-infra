{
  "openapi": "3.0.0",
  "info": {
    "version": "0.1.0",
    "title": "Pagopa eCommerce transaction auth requests service",
    "description": "This microservice handles transaction auth requests update"
  },
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/transactions/{transactionId}/auth-request": {
      "summary": "Request authorization for the transaction identified by payment token",
      "patch": {
        "operationId": "updateTransactionAuthorization",
        "parameters": [
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Transaction Id"
          }
        ],
        "requestBody": {
          "$ref": "#/components/requestBodies/UpdateAuthorizationRequest"
        },
        "responses": {
          "200": {
            "description": "Transaction authorization request successfully updated",
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
    "schemas": {
      "RptId": {
        "type": "string",
        "pattern": "([a-zA-Z\\d]{1,35})|(RF\\d{2}[a-zA-Z\\d]{1,21})"
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
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "rptId",
          "email",
          "amount"
        ],
        "example": {
          "rptId": "string"
        }
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
      "RequestAuthorizationRequest": {
        "type": "object",
        "description": "Request body for requesting an authorization for a transaction",
        "properties": {
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "fee": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "paymentInstrumentId": {
            "type": "string",
            "description": "Payment instrument id"
          },
          "pspId": {
            "type": "string",
            "description": "PSP id"
          },
          "language": {
            "type": "string",
            "enum": [
              "IT",
              "EN",
              "FR",
              "DE",
              "SL"
            ],
            "description": "Requested language"
          }
        },
        "required": [
          "amount",
          "fee",
          "paymentInstrumentId",
          "pspId",
          "language"
        ]
      },
      "RequestAuthorizationResponse": {
        "type": "object",
        "description": "Response body for requesting an authorization for a transaction",
        "properties": {
          "authorizationUrl": {
            "type": "string",
            "format": "url",
            "description": "URL where to redirect clients to continue the authorization process"
          }
        },
        "required": [
          "authorizationUrl"
        ],
        "example": {
          "authorizationUrl": "https://example.com"
        }
      },
      "UpdateAuthorizationRequest": {
        "type": "object",
        "description": "Request body for updating an authorization for a transaction",
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
        ],
        "example": {
          "authorizationResult": "OK",
          "timestampOperation": "2022-02-11T12:00:00.000Z"
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
      "AuthorizationResult": {
        "description": "Authorization result",
        "type": "string",
        "enum": [
          "OK",
          "KO"
        ]
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
          "INITIALIZED",
          "AUTHORIZATION_REQUESTED",
          "AUTHORIZED",
          "AUTHORIZATION_FAILED",
          "CLOSED",
          "CLOSURE_FAILED"
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
      },
      "RequestAuthorizationRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/RequestAuthorizationRequest"
            }
          }
        }
      },
      "UpdateAuthorizationRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/UpdateAuthorizationRequest"
            }
          }
        }
      }
    }
  }
}