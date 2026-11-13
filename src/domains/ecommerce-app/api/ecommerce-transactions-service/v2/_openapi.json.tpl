{
  "openapi": "3.0.0",
  "info": {
    "version": "2.0.0",
    "title": "Pagopa eCommerce payment transactions service",
    "description": "This microservice handles transaction's lifecycle and workflow.",
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
    "/transactions/{transactionId}": {
      "get": {
        "tags": [
          "transactions"
        ],
        "operationId": "getTransactionInfo",
        "summary": "Get transaction information",
        "description": "Return information for the input specific transaction resource",
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
    },
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
          },
          "transferList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Transfer"
            },
            "minItems": 1,
            "maxItems": 5
          },
          "isAllCCP": {
            "type": "boolean",
            "description": "Flag for poste psp enabling in gec request"
          },
          "creditorReferenceId": {
            "type": "string",
            "description": "Creditor notice number's"
          }
        },
        "required": [
          "rptId",
          "amount",
          "transferList",
          "isAllCCP"
        ],
        "example": {
          "rptId": "77777777777302012387654312384",
          "paymentToken": "paymentToken1",
          "reason": "reason1",
          "amount": 600,
          "isAllCCP": false,
          "transferList": [
            {
              "paFiscalCode": "77777777777",
              "digitalStamp": false,
              "transferCategory": "transferCategory1",
              "transferAmount": 500
            },
            {
              "paFiscalCode": "11111111111",
              "digitalStamp": true,
              "transferCategory": "transferCategory2",
              "transferAmount": 100
            }
          ]
        }
      },
      "TransactionInfo": {
        "description": "Transaction data returned when querying for an existing transaction",
        "type": "object",
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
                "amount": 600,
                "transferList": [
                  {
                    "paFiscalCode": "77777777777",
                    "digitalStamp": false,
                    "transferCategory": "transferCategory1",
                    "transferAmount": 500
                  },
                  {
                    "paFiscalCode": "11111111111",
                    "digitalStamp": true,
                    "transferCategory": "transferCategory2",
                    "transferAmount": 100
                  }
                ]
              }
            ]
          },
          "status": {
            "$ref": "#/components/schemas/TransactionStatus"
          },
          "feeTotal": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "clientId": {
            "description": "transaction client id",
            "enum": [
              "IO",
              "CHECKOUT",
              "CHECKOUT_CART"
            ]
          },
          "nodeInfo":{
            "type": "object",
            "description": "Gateway infos",
            "properties": {
              "closePaymentResultError": {
                "type": "object",
                "description": "Error details for close payment result",
                "properties": {
                  "statusCode": {
                    "description": "Status code (4xx, 5xx) of the error received on the node",
                    "type": "number"
                  },
                  "description": {
                    "description": "Description of the error received on the node",
                    "type": "string"
                  }
                }
              },
              "sendPaymentResultOutcome": {
                "description": "The outcome of sendPaymentResult api (OK, KO, NOT_RECEIVED)",
                "type": "string",
                "enum": [
                  "OK",
                  "KO",
                  "NOT_RECEIVED"
                ]
              },
            }
          },
          "gatewayInfo":{
            "type": "object",
            "description": "Gateway infos",
            "properties": {
              "gateway": {
                "type": "string",
                "pattern": "NPG|REDIRECT",
                "description": "Payment gateway identifier"
              },
              "authorizationStatus": {
                "type": "string",
                "description": "Payment gateway authorization status"
              },
              "authorizationCode": {
                "type": "string",
                "description": "Payment gateway-specific authorization code related to the transaction"
              },
              "errorCode": {
                "type": "string",
                "description": "Payment gateway-specific error code from the gateway"
              },
            }
          },
        },
        "required": [
          "status",
          "transactionId",
          "payments"
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
      "Transfer": {
        "type": "object",
        "description": "The dto that contains information about the creditor entities",
        "properties": {
          "paFiscalCode": {
            "type": "string",
            "description": "The creditor institution fiscal code",
            "pattern": "^[a-zA-Z0-9]{11}"
          },
          "digitalStamp": {
            "type": "boolean",
            "description": "True if it is a digital stamp. False otherwise"
          },
          "transferCategory": {
            "type": "string",
            "description": "The taxonomy of the transfer"
          },
          "transferAmount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "paFiscalCode",
          "digitalStamp",
          "transferAmount"
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
    },
    "requestBodies": {
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
