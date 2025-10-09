{
  "openapi": "3.0.0",
  "info": {
    "version": "0.0.1",
    "title": "Pagopa eCommerce transaction auth requests service",
    "description": "This microservice handles transaction auth requests update",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "tags": [
    {
      "name": "transactions",
      "description": "Api's for performing a transaction",
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
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "security": [
    {
      "ApiKeyAuth": []
    }
  ],
  "paths": {
    "/transactions/{transactionId}/auth-requests": {
      "patch": {
        "tags": [
          "transactions"
        ],
        "operationId": "updateTransactionAuthorization",
        "summary": "Update authorization",
        "description": "Callback endpoint used for notify authorization outcome",
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
          "$ref": "#/components/requestBodies/UpdateAuthorizationRequest"
        },
        "responses": {
          "200": {
            "description": "Transaction authorization request successfully updated",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/UpdateAuthorizationResponse"
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
        "description": "Digital payment receipt identifier",
        "type": "string",
        "pattern": "([a-zA-Z\\d]{1,35})|(RF\\d{2}[a-zA-Z\\d]{1,21})"
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
      "NewTransactionResponse": {
        "type": "object",
        "description": "Transaction data returned when creating a new transaction",
        "properties": {
          "transactionId": {
            "description": "the transaction unique identifier",
            "type": "string"
          },
          "status": {
            "$ref": "#/components/schemas/TransactionStatus"
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
          "clientId": {
            "description": "transaction client id",
            "enum": [
              "IO",
              "CHECKOUT",
              "CHECKOUT_CART"
            ]
          },
          "authToken": {
            "description": "authorization token",
            "type": "string"
          }
        },
        "required": [
          "transactionId",
          "amountTotal",
          "status",
          "payments",
          "clientId"
        ]
      },
      "UpdateAuthorizationRequest": {
        "type": "object",
        "description": "Request body for updating an authorization for a transaction",
        "properties": {
          "outcomeGateway": {
            "type": "object",
            "oneOf": [
              {
                "$ref": "#/components/schemas/OutcomeNpgGateway"
              },
              {
                "$ref": "#/components/schemas/OutcomeRedirectGateway"
              }
            ],
            "discriminator": {
              "propertyName": "paymentGatewayType",
              "mapping": {
                "NPG": "#/components/schemas/OutcomeNpgGateway",
                "REDIRECT": "#/components/schemas/OutcomeRedirectGateway"
              }
            }
          },
          "timestampOperation": {
            "type": "string",
            "format": "date-time",
            "description": "Payment timestamp"
          }
        },
        "required": [
          "outcomeGateway",
          "timestampOperation"
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
              "feeTotal": {
                "$ref": "#/components/schemas/AmountEuroCents"
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
          "ACTIVATED",
          "AUTHORIZATION_REQUESTED",
          "AUTHORIZATION_COMPLETED",
          "CLOSURE_REQUESTED",
          "CLOSED",
          "CLOSURE_ERROR",
          "NOTIFIED_OK",
          "NOTIFIED_KO",
          "NOTIFICATION_ERROR",
          "NOTIFICATION_REQUESTED",
          "EXPIRED",
          "REFUNDED",
          "CANCELED",
          "EXPIRED_NOT_AUTHORIZED",
          "UNAUTHORIZED",
          "REFUND_ERROR",
          "REFUND_REQUESTED",
          "CANCELLATION_REQUESTED",
          "CANCELLATION_EXPIRED"
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
      },
      "UpdateAuthorizationResponse": {
        "type": "object",
        "description": "Update authorization response",
        "properties": {
          "status": {
            "$ref": "#/components/schemas/TransactionStatus"
          }
        },
        "required": [
          "status"
        ]
      },
      "OutcomeNpgGateway": {
        "type": "object",
        "properties": {
          "paymentGatewayType": {
            "type": "string",
            "example": "NPG"
          },
          "operationResult": {
            "type": "string",
            "description": "outcome received by NPG - https://developer.nexi.it/it/api/notifica",
            "enum": [
              "AUTHORIZED",
              "EXECUTED",
              "DECLINED",
              "DENIED_BY_RISK",
              "THREEDS_VALIDATED",
              "THREEDS_FAILED",
              "PENDING",
              "CANCELED",
              "VOIDED",
              "REFUNDED",
              "FAILED"
            ]
          },
          "orderId": {
            "description": "Operator unique order ID",
            "type": "string"
          },
          "operationId": {
            "description": "Operation ID",
            "type": "string"
          },
          "authorizationCode": {
            "type": "string",
            "description": "Authorization code"
          },
          "errorCode": {
            "type": "string",
            "description": "Error code"
          },
          "paymentEndToEndId": {
            "description": "Circuit unique transaction ID",
            "type": "string"
          },
          "rrn": {
            "type": "string",
            "description": "Transaction rrn"
          },
          "validationServiceId": {
            "description": "Validation service id",
            "type": "string"
          },
          "cardId4": {
            "description": "NPG unique card identifier",
            "type": "string"
          },
          "securityToken": {
            "description": "NPG security token",
            "type": "string"
          }
        },
        "required": [
          "paymentGatewayType",
          "operationResult"
        ]
      },
      "OutcomeRedirectGateway": {
        "type": "object",
        "properties": {
          "paymentGatewayType": {
            "type": "string",
            "example": "REDIRECT",
            "description": "disciminator field. fixed value `REDIRECT`"
          },
          "pspTransactionId": {
            "type": "string",
            "description": "PSP transaction unique ID"
          },
          "outcome": {
            "$ref": "https://raw.githubusercontent.com/pagopa/pagopa-api/SANP3.6.1/openapi/redirect.yaml#/components/schemas/AuthorizationOutcome"
          },
          "pspId": {
            "type": "string",
            "description": "PSP ID from which the authorization outcome request come"
          },
          "authorizationCode": {
            "type": "string",
            "description": "payment authorization code"
          },
          "errorCode": {
            "type": "string",
            "description": "payment error code"
          }
        },
        "required": [
          "paymentGatewayType",
          "pspId",
          "outcome",
          "pspTransactionId"
        ]
      }
    },
    "requestBodies": {
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