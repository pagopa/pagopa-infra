{
  "openapi": "3.0.3",
  "info": {
    "title": "pagoPA Wallet API",
    "version": "0.0.1",
    "description": "API to handle wallets PagoPA, where a wallet is triple between user identifier, payment instrument and services (i.e pagoPA, bpd).",
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
        "security": [
          {
            "bearerAuth": []
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
          "201": {
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
      },
      "get": {
        "tags": [
          "wallets"
        ],
        "summary": "Get wallet by user identifier",
        "description": "Returns a of wallets related to user",
        "operationId": "getWalletsByIdUser",
        "security": [
          {
            "bearerAuth": []
          }
        ],
        "responses": {
          "200": {
            "description": "Wallet retrieved successfully",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Wallets"
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
    },
    "/wallets/{walletId}": {
      "get": {
        "tags": [
          "wallets"
        ],
        "summary": "Get wallet by id",
        "description": "Returns a single wallet",
        "operationId": "getWalletById",
        "security": [
          {
            "bearerAuth": []
          }
        ],
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
      },
      "delete": {
        "tags": [
          "wallets"
        ],
        "summary": "Delete wallet by id",
        "description": "Returns a single wallet",
        "operationId": "deleteWalletById",
        "security": [
          {
            "bearerAuth": []
          }
        ],
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
          "204": {
            "description": "Wallet deleted successfully"
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
      "ServiceName": {
        "type": "string",
        "description": "Enumeration of services",
        "enum": [
          "PAGOPA"
        ]
      },
      "Service": {
        "type": "object",
        "properties": {
          "name": {
            "$ref": "#/components/schemas/ServiceName"
          },
          "status": {
            "$ref": "#/components/schemas/ServiceStatus"
          },
          "updateDate": {
            "description": "Service last update date",
            "type": "string",
            "format": "date-time"
          }
        }
      },
      "ServiceStatus": {
        "type": "string",
        "description": "Enumeration of wallet statuses",
        "enum": [
          "ENABLED",
          "DISABLED"
        ]
      },
      "WalletStatus": {
        "type": "string",
        "description": "Enumeration of wallet statuses",
        "enum": [
          "INITIALIZED",
          "CREATED",
          "DELETED",
          "ERROR"
        ]
      },
      "WalletCardDetails": {
        "type": "object",
        "description": "Card payment instrument details",
        "properties": {
          "type": {
            "type": "string",
            "description": "Wallet details discriminator field."
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
          "type",
          "bin",
          "maskedPan",
          "expiryDate",
          "holder",
          "brand"
        ]
      },
      "WalletPaypalDetails": {
        "type": "object",
        "description": "Paypal instrument details",
        "properties": {
          "type": {
            "type": "string",
            "description": "Wallet details discriminator field."
          },
          "abi": {
            "description": "bank idetifier",
            "type": "string",
            "minLength": 1,
            "maxLength": 5,
            "example": "12345"
          },
          "maskedEmail": {
            "description": "email masked pan",
            "type": "string",
            "example": "test***@***test.it"
          }
        },
        "required": [
          "type",
          "abi",
          "maskedEmail"
        ]
      },
      "WalletCreateRequest": {
        "type": "object",
        "description": "Wallet creation request",
        "properties": {
          "services": {
            "type": "array",
            "description": "List of services for which wallet is enabled",
            "items": {
              "$ref": "#/components/schemas/ServiceName"
            }
          },
          "useDiagnosticTracing": {
            "type": "boolean"
          }
        },
        "required": [
          "type",
          "services",
          "useDiagnosticTracing"
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
          "paymentInstrumentId": {
            "description": "Payment instrument identifier",
            "type": "string"
          },
          "contractNumber": {
            "description": "User contract identifier to be used with payment instrument to make a new payment",
            "type": "string"
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
          "services": {
            "description": "list of services for which this wallet is created for",
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/Service"
            }
          },
          "details": {
            "description": "details for the specific payment instrument. This field is disciminated by the type field",
            "type": "object",
            "oneOf": [
              {
                "$ref": "#/components/schemas/WalletCardDetails"
              },
              {
                "$ref": "#/components/schemas/WalletPaypalDetails"
              }
            ],
            "discriminator": {
              "propertyName": "type",
              "mapping": {
                "CARDS": "#/components/schemas/WalletCardDetails",
                "PAYPAL": "#/components/schemas/WalletPaypalDetails"
              }
            }
          }
        },
        "required": [
          "walletId",
          "userId",
          "status",
          "creationDate",
          "contractNumber",
          "updateDate",
          "type",
          "services"
        ]
      },
      "Wallets": {
        "type": "object",
        "description": "Wallets information",
        "properties": {
          "wallets": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/WalletInfo"
            }
          }
        }
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
    },
    "securitySchemes": {
      "bearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "description": "wallet token"
      }
    }
  }
}