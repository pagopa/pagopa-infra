{
  "openapi": "3.0.3",
  "info": {
    "title": "pagoPA Wallet API",
    "version": "0.0.1",
    "description": "Wallet",
    "termsOfService": "https://pagopa.it/terms/"
  },
  "tags": [
    {
      "name": "wallets",
      "description": "Api's for handle a wallet",
      "externalDocs": {
        "url": "https://pagopa.atlassian.net/wiki/spaces/WA/overview?homepageId=622658099",
        "description": "Documentation"
      }
    }
  ],
  "servers": [
    {
      "url": "https://${hostname}"
    }
  ],
  "paths": {
    "/wallets": {
      "post": {
        "tags": [
          "wallets"
        ],
        "summary": "Create a new wallet",
        "description": "Creates a new wallet",
        "operationId": "createWallet",
        "parameters": [
          {
            "in": "header",
            "name": "x-user-id",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "requestBody": {
          "description": "Create a new wallet",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/WalletCreateRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Wallet created successfully",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WalletCreateResponse"
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
    },
    "/wallets/{walletId}": {
      "get": {
        "tags": [
          "wallets"
        ],
        "summary": "Get wallet by id",
        "description": "Returns a single wallet",
        "operationId": "getWalletById",
        "parameters": [
          {
            "name": "walletId",
            "in": "path",
            "description": "ID of wallet to return",
            "required": true,
            "schema": {
              "$ref": "#/components/schemas/WalletId"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Wallet retrieved successfully",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WalletInfo"
                }
              }
            }
          },
          "400": {
            "description": "Invalid input id",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "404": {
            "description": "Wallet not found"
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
      "WalletId": {
        "description": "Wallet identifier",
        "type": "string",
        "format": "uuid"
      },
      "WalletType": {
        "type": "string",
        "description": "Wallet type enumeration",
        "enum": [
          "CARDS"
        ]
      },
      "Service": {
        "type": "string",
        "description": "Enumeration of services",
        "enum": [
          "PAGOPA"
        ]
      },
      "WalletStatus": {
        "type": "string",
        "description": "Enumeration of wallet statuses",
        "enum": [
          "INITIALIZED",
          "CREATED",
          "ERROR"
        ]
      },
      "CardPaymentInstrumentDetails": {
        "type": "object",
        "description": "Card payment instrument details",
        "properties": {
          "walletType": {
            "type": "string",
            "description": "Payment instrument details discriminator field"
          },
          "bin": {
            "description": "Card BIN (first 6 PAN digits)",
            "type": "string",
            "minLength": 1,
            "maxLength": 6,
            "example": "123456"
          },
          "maskedPan": {
            "description": "Card masked pan (first 6 digit and last 4 digit clear, other digit obfuscated)",
            "type": "string",
            "example": "123456******9876"
          },
          "expiryDate": {
            "type": "string",
            "description": "Credit card expiry date. The date format is `YYYYMM`",
            "pattern": "^\\d{6}$",
            "example": "203012"
          },
          "contractNumber": {
            "description": "User contract identifier to be used with payment instrument to make a new payment",
            "type": "string"
          },
          "holder": {
            "description": "Holder of the card payment instrument",
            "type": "string"
          },
          "brand": {
            "description": "Payment instrument brand",
            "type": "string",
            "enum": [
              "MASTERCARD",
              "VISA"
            ]
          }
        },
        "required": [
          "walletType",
          "bin",
          "maskedPan",
          "expiryDate",
          "contractNumber",
          "holder",
          "brand"
        ]
      },
      "WalletCreateRequest": {
        "type": "object",
        "description": "Wallet creation request",
        "properties": {
          "walletType": {
            "$ref": "#/components/schemas/WalletType"
          },
          "services": {
            "type": "array",
            "description": "List of services for which wallet is enabled",
            "minItems": 1,
            "items": {
              "$ref": "#/components/schemas/Service"
            }
          }
        },
        "required": [
          "walletType",
          "services"
        ]
      },
      "WalletCreateResponse": {
        "type": "object",
        "description": "Wallet creation response",
        "properties": {
          "walletId": {
            "$ref": "#/components/schemas/WalletId"
          },
          "redirectUrl": {
            "type": "string",
            "format": "url",
            "description": "Redirection URL to a payment gateway page where the user can input a payment instrument information",
            "example": "http://localhost/inputPage"
          }
        },
        "required": [
          "walletId",
          "redirectUrl"
        ]
      },
      "WalletInfo": {
        "type": "object",
        "description": "Wallet information",
        "properties": {
          "walletId": {
            "$ref": "#/components/schemas/WalletId"
          },
          "userId": {
            "type": "string",
            "description": "user identifier"
          },
          "status": {
            "$ref": "#/components/schemas/WalletStatus"
          },
          "creationDate": {
            "description": "Wallet creation date",
            "type": "string",
            "format": "date-time"
          },
          "updateDate": {
            "description": "Wallet update date",
            "type": "string",
            "format": "date-time"
          },
          "walletType": {
            "$ref": "#/components/schemas/WalletType"
          },
          "paymentInstrumentId": {
            "description": "Payment instrument identifier",
            "type": "string"
          },
          "services": {
            "description": "list of services for which this wallet is created for",
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Service"
            }
          },
          "details": {
            "description": "details for the specific payment instrument. This field is disciminated by the walletType field",
            "oneOf": [
              {
                "$ref": "#/components/schemas/CardPaymentInstrumentDetails"
              }
            ],
            "discriminator": {
              "propertyName": "walletType",
              "mapping": {
                "CARDS": "#/components/schemas/CardPaymentInstrumentDetails"
              }
            }
          }
        },
        "required": [
          "walletId",
          "userId",
          "status",
          "creationDate",
          "updateDate",
          "walletType",
          "services"
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
        "example": 502
      }
    }
  }
}