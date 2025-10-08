{
  "openapi": "3.0.0",
  "info": {
    "version": "0.0.1",
    "title": "Pagopa eCommerce services for app IO",
    "description": "API's exposed from eCommerce services to io webview to allow get transaction.",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "tags": [
    {
      "name": "ecommerce-transactions",
      "description": "Api's for performing a transaction",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/611287199/-servizio+transactions+service",
        "description": "Technical specifications"
      }
    }
  ],
  "servers": [
    {
      "url": "https://${host}"
    }
  ],
  "externalDocs": {
    "url": "https://pagopa.atlassian.net/wiki/spaces/I/pages/492339720/pagoPA+eCommerce+Design+Review",
    "description": "Design review"
  },
  "paths": {
    "/transactions/{transactionId}": {
      "get": {
        "tags": [
          "ecommerce-transactions"
        ],
        "operationId": "getTransactionInfo",
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
        "security": [
          {
            "eCommerceSessionToken": []
          }
        ],
        "summary": "Get transaction information",
        "description": "Return information for the input specific transaction resource",
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
      "/transactions/{transactionId}/outcomes": {
      "get": {
        "tags": [
          "ecommerce-transactions"
        ],
        "operationId": "getTransactionOutcomes",
        "summary": "Get transaction outcome",
        "description": "Return outcome information for the input specific transaction resource",
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
        "security": [
          {
            "eCommerceSessionToken": []
          }
        ],
        "responses": {
          "200": {
            "description": "Transaction authorization request successfully updated",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/TransactionOutcomeInfo"
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
    },
    "/payment-methods/{id}/sessions": {
        "post": {
          "tags": [
            "ecommerce-methods"
          ],
          "operationId": "createSessionWebview",
          "security": [
            {
              "eCommerceSessionToken": []
            }
          ],
          "summary": "Create frontend field data paired with a payment gateway session",
          "description": "This endpoint returns an object containing data on how a frontend can build a form\nto allow direct exchanging of payment information to the payment gateway without eCommerce\nhaving to store PCI data (or other sensitive data tied to the payment method).\nThe returned data is tied to a session on the payment gateway identified by the field `orderId`.",
          "parameters": [
            {
              "name": "id",
              "in": "path",
              "description": "Payment Method id",
              "required": true,
              "schema": {
                "type": "string"
              }
            },
            {
              "in": "header",
              "name": "lang",
              "required": false,
              "description": "Language requested by the user",
              "schema": {
                "type": "string"
              }
            },
            {
              "name": "x-client-id",
              "in": "header",
              "description": "client id related to a given touchpoint",
              "required": true,
              "schema": {
                "type": "string",
                "enum": [
                  "IO",
                  "CHECKOUT",
                  "CHECKOUT_CART"
                ]
              }
            }
          ],
          "responses": {
            "200": {
              "description": "Payment form data successfully created",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/CreateSessionResponse"
                  }
                }
              }
            },
            "401": {
              "description": "Unauthorized, access token missing or invalid"
            },
            "404": {
              "description": "Payment method not found",
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/ProblemJson"
                  }
                }
              }
            },
            "502": {
              "description": "Payment gateway did return error",
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
    "/transactions/{transactionId}/wallets": {
      "post": {
        "tags": [
          "wallets"
        ],
        "summary": "Create wallet for payment with contextual onboard",
        "description": "Create wallet for payment with contextual onboard",
        "security": [
          {
            "pagoPAPlatformSessionToken": []
          }
        ],
        "operationId": "createWalletForTransactionsForIO",
        "parameters": [
          {
            "name": "transactionId",
            "in": "path",
            "description": "ecommerce transaction id",
            "required": true,
            "schema": {
              "type": "string"
            }
          }
        ],
        "requestBody": {
          "description": "Create a new wallet",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/WalletTransactionCreateRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "201": {
            "description": "Wallet created successfully",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WalletTransactionCreateResponse"
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
            "description": "Unauthorized, access token missing or invalid"
          },
          "500": {
            "description": "Internal server error serving request",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "502": {
            "description": "Gateway error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "504": {
            "description": "Timeout serving request"
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
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
        "example": 500
      },
      "RptId": {
        "type": "string",
        "pattern": "([a-zA-Z0-9]{1,35})|(RFd{2}[a-zA-Z0-9]{1,21})"
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
          "isAllCCP": {
            "description": "Flag for the inclusion of Poste bundles. false -> excluded, true -> included",
            "type": "boolean"
          },
          "transferList": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Transfer"
            },
            "minItems": 1,
            "maxItems": 5
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
          "amount": 600,
          "authToken": "authToken1",
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
            "maxItems": 1,
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
            "type": "string",
            "enum": [
              "IO"
            ]
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
          "authorizationCode": {
            "type": "string",
            "description": "Payment gateway-specific authorization code related to the transaction"
          },
          "errorCode": {
            "type": "string",
            "description": "Payment gateway-specific error code from the gateway"
          },
          "gateway": {
            "type": "string",
            "pattern": "XPAY|VPOS|NPG|REDIRECT",
            "description": "Pgs identifier"
          }
        },
        "required": [
          "transactionId",
          "status",
          "payments"
        ]
      },
      "TransactionOutcomeInfo" : {
        "type": "object",
        "description": "Transaction outcome info returned when querying for an existing transaction outcome status. The field totalAmount, if present, is intended as the total amount paid for the transaction in eurocents fees excluded. Fees too, if present, is in eurocents",
        "properties": {
          "outcome": {
            "type": "number",
            "enum": [
              0, 1, 2, 3, 4, 7, 8, 10, 17, 18, 25, 99, 116, 117, 121
            ],
            "description": "`0` - Success `1` - Generic error `2` - Authorization error `3` - Invalid data `4` - Timeout `7` - Invalid card: expired card etc `8` - Canceled by the user `10` - Excessive amount `17` - Taken in charge `18` - Refunded `25` - PSP Error `99` - Backend Error `116` - Balance not available `117` - CVV Error `121` - Limit exceeded"
          },
          "isFinalStatus": {
            "type": "boolean",
            "description": "A flag that describe the outcome as final or not. If true, the outcome will not change in the future and the client can interrupt polling."
          },
          "totalAmount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          },
          "fees": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "outcome",
          "isFinalStatus"
        ]
      },
      "AmountEuroCents": {
        "description": "Amount for payments, in euro cents",
        "type": "integer",
        "minimum": 0,
        "maximum": 99999999999
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
              },
              "gatewayAuthorizationStatus": {
                "type": "string",
                "description": "Payment gateway authorization status"
              }
            },
            "required": [
              "status"
            ]
          }
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
      "CreateSessionResponse": {
              "type": "object",
              "description": "Form data needed to create a payment method input form",
              "properties": {
                "orderId": {
                  "type": "string",
                  "description": "Identifier of the payment gateway session associated to the form"
                },
                "correlationId": {
                  "type": "string",
                  "format": "uuid",
                  "description": "Identifier of the payment session associated to the transaction flow"
                },
                "paymentMethodData": {
                  "$ref": "#/components/schemas/CardFormFields"
                }
              },
              "required": [
                "paymentMethodData",
                "orderId",
                "correlationId"
              ]
            },
            "CardFormFields": {
              "type": "object",
              "description": "Form fields for credit cards",
              "properties": {
                "paymentMethod": {
                  "type": "string"
                },
                "form": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/Field"
                  }
                }
              },
              "required": [
                "paymentMethod",
                "form"
              ]
            },
            "Field": {
              "type": "object",
              "properties": {
                "type": {
                  "type": "string",
                  "example": "text"
                },
                "class": {
                  "type": "string",
                  "example": "cardData"
                },
                "id": {
                  "type": "string",
                  "example": "cardholderName"
                },
                "src": {
                  "type": "string",
                  "format": "uri",
                  "example": "https://<fe>/field.html?id=CARDHOLDER_NAME&sid=052211e8-54c8-4e0a-8402-e10bcb8ff264"
                }
              }
            },
      "WalletTransactionCreateRequest": {
        "type": "object",
        "description": "Wallet for transaction with contextual onboarding creation request",
        "properties": {
          "useDiagnosticTracing": {
            "type": "boolean"
          },
          "paymentMethodId": {
            "type": "string",
            "format": "uuid"
          },
          "amount": {
            "$ref": "#/components/schemas/AmountEuroCents"
          }
        },
        "required": [
          "useDiagnosticTracing",
          "paymentMethodId",
          "amount"
        ]
      },
      "WalletTransactionCreateResponse": {
        "type": "object",
        "description": "Wallet for transaction with contextual onboarding creation response",
        "properties": {
          "walletId": {
            "$ref": "#/components/schemas/WalletId"
          },
          "redirectUrl": {
            "type": "string",
            "format": "url",
            "description": "Redirection URL to a payment gateway page where the user can input a payment instrument information with walletId and useDiagnosticTracing as query param",
            "example": "http://localhost/inputPage?walletId=123&useDiagnosticTracing=true&sessionToken=sessionToken"
          }
        },
        "required": [
          "walletId"
        ]
      },
      "WalletId": {
        "description": "Wallet identifier",
        "type": "string",
        "format": "uuid"
      }
    },
    "securitySchemes": {
      "eCommerceSessionToken": {
        "type": "http",
        "scheme": "bearer",
        "description": "JWT session token taken from /sessions response body"
      },
      "pagoPAPlatformSessionToken": {
        "type": "http",
        "scheme": "bearer",
        "description": "JWT session token taken according to pagoPA platform auth for IO app"
      }
    }
  }
}
