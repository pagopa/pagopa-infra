{
  "openapi": "3.0.3",
  "info": {
    "title": "pagoPA Payment Wallet API for eCommerce",
    "version": "0.0.1",
    "description": "API dedicated to eCommerce to retrive wallet data useful to handle authorization request with eCommerce.",
    "termsOfService": "https://pagopa.it/terms/"
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
    "/wallets/{walletId}/auth-data": {
      "get": {
        "tags": [
          "wallets"
        ],
        "summary": "Get wallet auth data by id",
        "description": "Returns auth data for a single wallet",
        "operationId": "getWalletAuthDataById",
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
                  "$ref": "#/components/schemas/WalletAuthData"
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
          "500": {
            "description": "internal server error",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "504": {
            "description": "Timeout serving request",
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
    "/wallets/{walletId}/sessions/{orderId}/notifications/internal": {
      "post": {
        "tags": [
          "wallets"
        ],
        "summary": "Update Wallet on NPG onboarding authorization response",
        "description": "Update Wallet on NPG onboarding authorization response - internal api, means to be called in B2B interactions with internal systems",
        "operationId": "notifyWalletInternal",
        "parameters": [
          {
            "in": "path",
            "name": "walletId",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true,
            "description": "Unique identifier of the wallet"
          },
          {
            "in": "path",
            "name": "orderId",
            "schema": {
              "type": "string"
            },
            "required": true
          }
        ],
        "requestBody": {
          "description": "Notify wallet",
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/WalletNotificationRequest"
              }
            }
          },
          "required": true
        },
        "responses": {
          "200": {
            "description": "Notification handled successfully"
          },
          "400": {
            "description": "Invalid input",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "type": "https://example.com/problem/",
                  "title": "string",
                  "status": 400,
                  "detail": "Invalid input"
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                },
                "example": {
                  "type": "https://example.com/problem/",
                  "title": "string",
                  "status": 401,
                  "detail": "Unauthorized"
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
                },
                "example": {
                  "type": "https://example.com/problem/",
                  "title": "string",
                  "status": 500,
                  "detail": "Internal server error"
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
      "WalletAuthData": {
        "type": "object",
        "description": "Wallet information",
        "properties": {
          "walletId": {
            "$ref": "#/components/schemas/WalletId"
          },
          "contractId": {
            "description": "Payment method identifier",
            "type": "string"
          },
          "brand": {
            "description": "The card brand name",
            "type": "string"
          },
          "contextualOnboardDetails": {
            "$ref": "#/components/schemas/ContextualOnboardDetails"
          },
          "paymentMethodData": {
            "type": "object",
            "oneOf": [
              {
                "$ref": "#/components/schemas/WalletAuthCardData"
              },
              {
                "$ref": "#/components/schemas/WalletAuthAPMData"
              }
            ],
            "discriminator": {
              "propertyName": "paymentMethodType",
              "mapping": {
                "cards": "#/components/schemas/WalletAuthCardData",
                "apm": "#/components/schemas/WalletAuthAPMData"
              }
            }
          }
        },
        "required": [
          "contractId",
          "brand",
          "paymentMethodData"
        ]
      },
      "ContextualOnboardDetails": {
        "type": "object",
        "properties": {
          "transactionId": {
            "type": "string"
          },
          "amount": {
            "type": "integer",
            "format": "int64"
          },
          "orderId": {
            "type": "string"
          },
          "sessionId": {
            "type": "string"
          }
        }
      },
      "WalletAuthCardData": {
        "type": "object",
        "properties": {
          "paymentMethodType": {
            "type": "string"
          },
          "bin": {
            "type": "string",
            "description": "Bin of user card"
          }
        },
        "required": [
          "paymentMethodType",
          "bin"
        ]
      },
      "WalletAuthAPMData": {
        "type": "object",
        "properties": {
          "paymentMethodType": {
            "type": "string"
          }
        },
        "required": [
          "paymentMethodType"
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
      "WalletNotificationRequest": {
        "type": "object",
        "description": "Request body for execute wallet notification request",
        "properties": {
          "timestampOperation": {
            "type": "string",
            "format": "date-time",
            "description": "Onboarding timestamp"
          },
          "operationId": {
            "description": "Operation ID",
            "type": "string"
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
          "errorCode": {
            "type": "string",
            "description": "Error code for the onboarding operation received by NPG"
          },
          "details": {
            "description": "Wallet notified payment method details",
            "type": "object",
            "oneOf": [
              {
                "$ref": "#/components/schemas/WalletNotificationRequestCardDetails"
              }
            ],
            "discriminator": {
              "propertyName": "type",
              "mapping": {
                "CARD": "#/components/schemas/WalletNotificationRequestCardDetails"
              }
            }
          }
        },
        "required": [
          "timestampOperation",
          "operationResult"
        ]
      },
      "WalletNotificationRequestCardDetails": {
        "type": "object",
        "description": "Card wallet notification details for onboarding",
        "properties": {
          "type": {
            "type": "string",
            "description": "discriminator field, fixed value `CARD`"
          },
          "paymentInstrumentGatewayId": {
            "type": "string",
            "description": "gateway unique id associated to the card"
          }
        },
        "required": [
          "type",
          "paymentInstrumentGatewayId"
        ],
        "example": {
          "type": "CARD",
          "paymentInstrumentGatewayId": "c2402dcc-ef9d-4c68-8067-e4b6268a2e62"
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