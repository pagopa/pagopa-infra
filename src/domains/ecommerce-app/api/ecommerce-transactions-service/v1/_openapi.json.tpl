{
  "openapi": "3.0.0",
  "info": {
    "version": "0.0.1",
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
      "delete": {
        "tags": [
          "transactions"
        ],
        "operationId": "requestTransactionUserCancellation",
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
        "summary": "Performs the transaction cancellation",
        "responses": {
          "202": {
            "description": "Transaction cancellation request successfully accepted"
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
            "description": "Timeout from PagoPA services",
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
          "transactions"
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
    "/transactions/{transactionId}/auth-requests": {
      "post": {
        "tags": [
          "transactions"
        ],
        "operationId": "requestTransactionAuthorization",
        "summary": "Request authorization",
        "description": "Request authorization for the transaction identified by payment token",
        "parameters": [
          {
            "in": "path",
            "name": "transactionId",
            "schema": {
              "type": "string"
            },
            "required": true,
            "description": "Transaction ID"
          },
          {
            "in": "header",
            "name": "x-pgs-id",
            "schema": {
              "type": "string",
              "pattern": "XPAY|VPOS|NPG|REDIRECT"
            },
            "required": false,
            "description": "Pgs identifier (populated by APIM policy)"
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
          "422": {
            "description": "Unprocessable entity",
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
      }
    }
  },
  "components": {
    "schemas": {
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
          "isAllCCP": {
            "type": "boolean",
            "description": "Check flag for psp validation"
          },
          "details": {
            "description": "Additional payment authorization details. Must match the correct format for the chosen payment method.",
            "oneOf": [
              {
                "$ref": "#/components/schemas/CardAuthRequestDetails"
              },
              {
                "$ref": "#/components/schemas/CardsAuthRequestDetails"
              },
              {
                "$ref": "#/components/schemas/WalletAuthRequestDetails"
              },
              {
                "$ref": "#/components/schemas/RedirectionAuthRequestDetails"
              },
              {
                "$ref": "#/components/schemas/ApmAuthRequestDetails"
              }
            ],
            "discriminator": {
              "propertyName": "detailType",
              "mapping": {
                "card": "#/components/schemas/CardAuthRequestDetails",
                "cards": "#/components/schemas/CardsAuthRequestDetails",
                "wallet": "#/components/schemas/WalletAuthRequestDetails",
                "redirect": "#/components/schemas/RedirectionAuthRequestDetails",
                "apm": "#/components/schemas/ApmAuthRequestDetails"
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
          "isAllCCP",
          "details"
        ]
      },
      "CardAuthRequestDetails": {
        "type": "object",
        "description": "Additional payment authorization details for credit cards",
        "properties": {
          "detailType": {
            "description": "property discriminator, used to discriminate the authorization request detail. Fixed value 'card'",
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
            "description": "Credit card expiry date. The date format is `YYYYMM`",
            "pattern": "^\\d{6}$"
          },
          "holderName": {
            "type": "string",
            "description": "The card holder name"
          },
          "brand": {
            "type": "string",
            "description": "The card brand name",
            "enum": [
              "VISA",
              "MASTERCARD",
              "UNKNOWN",
              "DINERS",
              "MAESTRO",
              "AMEX"
            ]
          },
          "threeDsData": {
            "type": "string",
            "description": "The 3ds data evaluated by the client"
          }
        },
        "required": [
          "detailType",
          "cvv",
          "pan",
          "expiryDate",
          "holderName",
          "brand",
          "threeDsData"
        ],
        "example": {
          "detailType": "card",
          "cvv": "000",
          "pan": "0123456789012345",
          "expiryDate": "209901",
          "holderName": "Name Surname",
          "brand": "VISA",
          "threeDsData": "threeDsData"
        }
      },
      "CardsAuthRequestDetails": {
        "type": "object",
        "description": "Additional payment authorization details for cards NPG authorization",
        "properties": {
          "detailType": {
            "description": "property discriminator, used to discriminate the authorization request detail. Fixed value 'cards'",
            "type": "string"
          },
          "orderId": {
            "type": "string",
            "description": "NPG transaction order id"
          }
        },
        "required": [
          "detailType",
          "orderId"
        ],
        "example": {
          "detailType": "cards",
          "orderId": "orderId"
        }
      },
      "WalletAuthRequestDetails": {
        "type": "object",
        "description": "Additional payment authorization details for wallet NPG authorization",
        "properties": {
          "detailType": {
            "description": "property discriminator, used to discriminate the authorization request detail. Fixed value 'wallet'",
            "type": "string"
          },
          "walletId": {
            "type": "string",
            "description": "The user wallet id"
          }
        },
        "required": [
          "detailType",
          "walletId"
        ],
        "example": {
          "detailType": "wallet",
          "walletId": "walletId"
        }
      },
      "RedirectionAuthRequestDetails": {
        "type": "object",
        "description": "Additional payment authorization details for Redirection authorization request",
        "properties": {
          "detailType": {
            "description": "property discriminator, used to discriminate the authorization request detail. Fixed value 'redirect'",
            "type": "string"
          }
        },
        "required": [
          "detailType"
        ],
        "example": {
          "detailType": "redirect"
        }
      },
      "ApmAuthRequestDetails": {
        "type": "object",
        "description": "Additional payment authorization details for payment apm authorization",
        "properties": {
          "detailType": {
            "description": "property discriminator, used to discriminate the authorization request detail. Fixed value 'apm'",
            "type": "string"
          }
        },
        "required": [
          "detailType"
        ],
        "example": {
          "detailType": "apm"
        }
      },
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
          "authorizationUrl": "https://example.com",
          "authorizationRequestId": "authRequestId"
        }
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
        "maximum": 99999999
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
      "RequestAuthorizationRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/RequestAuthorizationRequest"
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