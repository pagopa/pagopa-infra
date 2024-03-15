{
  "openapi": "3.0.3",
  "info": {
    "title": "pagoPA Payment Wallet API dedicated to PM migration",
    "version": "0.0.1",
    "description": "API to handle payment wallets PagoPA for App IO to migrate from Payment Manager",
    "termsOfService": "https://pagopa.it/terms/"
  },
  "tags": [
    {
      "name": "migration",
      "description": "Api's dedicate to migration phase"
    }
  ],
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
    "/migrations/wallets": {
      "put": {
        "tags": [
          "migration"
        ],
        "summary": "Initializes a new wallet or returns details for pm of an existing one",
        "description": "Create the association between the new pair (walletId, contractId) and the old PM's walletId.\nThe API has an idempotent behaviour.\n",
        "operationId": "createWalletByPM",
        "requestBody": {
          "description": "Initialize a new wallet",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/WalletPmAssociationRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Wallet initialized successfully and details about new association.",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WalletPmAssociationResponse"
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
          "429": {
            "description": "Too many requests",
            "headers": {
              "Retry-After": {
                "description": "The number of milliseconds after which request can be retried",
                "schema": {
                  "type": "number"
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
          }
        }
      }
    },
    "/migrations/wallets/updateDetails": {
      "post": {
        "tags": [
          "migration"
        ],
        "summary": "Update wallet details by Payment Manager.",
        "description": "Update Wallet with its details by Payment Manager during the migration process. Also the Wallet goes to VALIDATED status.\n",
        "operationId": "updateWalletDetailsByPM",
        "requestBody": {
          "description": "Wallet details by Payment Manager",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/WalletPmCardDetailsRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "ID of updated Wallet",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/WalletPmCardDetailsResponse"
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
          "404": {
            "description": "Wallet not found",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "429": {
            "description": "Too many requests",
            "headers": {
              "Retry-After": {
                "description": "The number of milliseconds after which request can be retried",
                "schema": {
                  "type": "number"
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
      "WalletIdPm": {
        "type": "integer",
        "format": "int64"
      },
      "WalletPmAssociationRequest": {
        "type": "object",
        "properties": {
          "walletIdPm": {
            "$ref": "#/components/schemas/WalletIdPm"
          },
          "fiscalCode": {
            "type": "string",
            "description": "User registered's fiscal code"
          }
        },
        "required": [
          "walletIdPm",
          "fiscalCode"
        ]
      },
      "WalletPmAssociationResponse": {
        "type": "object",
        "properties": {
          "walletId": {
            "$ref": "#/components/schemas/WalletId"
          },
          "walletIdPm": {
            "$ref": "#/components/schemas/WalletIdPm"
          },
          "contractId": {
            "description": "Payment method identifier",
            "type": "string"
          },
          "status": {
            "$ref": "#/components/schemas/WalletStatus"
          }
        },
        "required": [
          "walletId",
          "walletIdPm",
          "contractId",
          "status"
        ]
      },
      "WalletStatus": {
        "type": "string",
        "description": "Enumeration of wallet statuses",
        "enum": [
          "INITIALIZED",
          "CREATED",
          "VALIDATION_REQUESTED",
          "VALIDATED",
          "DELETED",
          "ERROR"
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
      },
      "WalletPmCardDetailsResponse": {
        "type": "object",
        "properties": {
          "walletId": {
            "$ref": "#/components/schemas/WalletId"
          }
        }
      },
      "WalletPmCardDetailsRequest": {
        "type": "object",
        "properties": {
          "cardBin": {
            "type": "string",
            "description": "Card BIN (first 6/8 PAN digits)",
            "pattern": "^(\\d{6})|(\\d{8})$",
            "example": "123456"
          },
          "panTail": {
            "type": "string",
            "description": "The last 4 digits of PAN",
            "pattern": "^\\d{4}$",
            "minLength": 4,
            "maxLength": 4
          },
          "expireDate": {
            "type": "string",
            "description": "Credit card expiry date. The date format is `MM/YY`",
            "pattern": "^\\d{2}\\/\\d{2}$",
            "example": "12/25"
          },
          "paymentGatewayCardId": {
            "type": "string"
          },
          "paymentCircuit": {
            "type": "string",
            "example": "VISA",
            "description": "Card payment's circuit"
          },
          "originalContractIdentifier": {
            "type": "string",
            "description": "The old PM contract Id"
          },
          "newContractIdentifier": {
            "type": "string",
            "description": "The contract Id generated by Wallet for NPG"
          }
        },
        "required": [
          "cardBin",
          "panTail",
          "expireDate",
          "paymentGatewayCardId",
          "paymentCircuit",
          "originalContractIdentifier",
          "newContractIdentifier"
        ]
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