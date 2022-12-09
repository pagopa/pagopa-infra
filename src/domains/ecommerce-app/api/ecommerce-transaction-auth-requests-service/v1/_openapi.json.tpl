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
    "/transactions/{transactionId}/auth-requests": {
      "post": {
        "operationId": "requestTransactionAuthorization",
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
        "requestBody": {
          "$ref": "#/components/requestBodies/RequestAuthorizationRequest"
        },
        "responses": {
          "200": {
            "description": "Transaction authorization request successfully processed, redirecting client to authorization web page",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/RequestAuthorizationResponse"
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
            "description": "Transaction already processed",
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
      },
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
      "RequestAuthorizationResponse": {
        "type": "object",
        "description": "Response body for requesting an authorization for a transaction",
        "properties": {
          "authorizationUrl": {
            "type": "string",
            "format": "url",
            "description": "URL where to redirect clients to continue the authorization process"
          },
          "authorizationRequestId": {
            "type": "string",
            "description": "Authorization request id"
          }
        },
        "required": [
          "authorizationUrl",
          "authorizationRequestId"
        ],
        "example": {
          "authorizationUrl": "https://example.com"
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
          "status": "ACTIVATED"
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
          "status": {
            "$ref": "#/components/schemas/TransactionStatus"
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
          "amount",
          "status"
        ],
        "example": {
          "amount": 200
        }
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
          },
          "details": {
            "description": "Additional payment authorization details. Must match the correct format for the chosen payment method.",
            "oneOf": [
              {
                "$ref": "#/components/schemas/PostePayAuthRequestDetails"
              },
              {
                "$ref": "#/components/schemas/CardAuthRequestDetails"
              }
            ],
            "discriminator": {
              "propertyName": "detailType",
              "mapping": {
                "postepay": "#/components/schemas/PostePayAuthRequestDetails",
                "card": "#/components/schemas/CardAuthRequestDetails"
              }
            }
          }
        },
        "required": [
          "amount",
          "fee",
          "paymentInstrumentId",
          "pspId",
          "language",
          "details"
        ]
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
      "RptId": {
        "type": "string",
        "pattern": "([a-zA-Z\\d]{1,35})|(RF\\d{2}[a-zA-Z\\d]{1,21})"
      },
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 99999999
      },
      "PostePayAuthRequestDetails": {
        "type": "object",
        "description": "Additional payment authorization details for the PostePay payment method",
        "properties": {
          "detailType": {
            "type": "string"
          },
          "accountEmail": {
            "type": "string",
            "format": "email",
            "description": "PostePay account email"
          }
        },
        "required": [
          "detailType",
          "accountEmail"
        ],
        "example": {
          "detailType": "postepay",
          "accountEmail": "user@example.com"
        }
      },
      "CardAuthRequestDetails": {
        "type": "object",
        "description": "Additional payment authorization details for credit cards",
        "properties": {
          "detailType": {
            "type": "string"
          },
          "cvv": {
            "type": "string",
            "description": "Credit card CVV",
            "pattern": "^[0-9]{3,4}$"
          },
          "pan": {
            "type": "string",
            "description": "Credit card PAN",
            "pattern": "^[0-9]{14,16}$"
          },
          "expiryDate": {
            "type": "string",
            "description": "Credit card expiry date. Note that only the month and year components are taken into account.",
            "format": "date"
          },
          "holderName": {
            "type": "string",
            "description": "The card holder name"
          }
        },
        "required": [
          "detailType",
          "cvv",
          "pan",
          "expiryDate",
          "holderName"
        ],
        "example": {
          "detailType": "card",
          "cvv": 0,
          "pan": 123456789012345,
          "expiryDate": "2099-01-01T00:00:00.000Z",
          "holderName": "Name Surname"
        }
      },
      "AuthorizationResult": {
        "description": "Authorization result",
        "type": "string",
        "enum": [
          "OK",
          "KO"
        ]
      }
    },
    "requestBodies": {
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