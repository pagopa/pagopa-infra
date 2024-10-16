{
  "openapi": "3.0.0",
  "info": {
    "version": "0.0.1",
    "title": "Pagopa eCommerce user stats service",
    "description": "This microservice handles statistics for payment performed by an authenticated used on eCommerce",
    "contact": {
      "name": "pagoPA - Touchpoints team"
    }
  },
  "tags": [
    {
      "name": "user-stats",
      "description": "Api's for tracing and retrieve user statistics",
      "externalDocs": {
        "url": "TODO",
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
    "/user/lastPaymentMethodUsed": {
      "put": {
        "operationId": "saveLastPaymentMethodUsed",
        "tags": [
          "user-stats"
        ],
        "description": "Save last payment method used by an user to perform a transaction on eCommerce",
        "summary": "Save last method used",
        "requestBody": {
          "$ref": "#/components/requestBodies/UserLastPaymentMethodRequest"
        },
        "responses": {
          "204": {
            "description": "User last payment method used updated successfully"
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
            "description": "Unauthorized, api key missing or invalid",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/ProblemJson"
                }
              }
            }
          },
          "500": {
            "description": "Unexpected error updating user last used payment method",
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
      "UserLastPaymentMethodRequest": {
        "type": "object",
        "description": "Request to update last payment method used by an user",
        "properties": {
          "userId": {
            "type": "string",
            "format": "uuid",
            "description": "the user unique identifier"
          },
          "details": {
            "$ref": "#/components/schemas/UserLastPaymentMethodData"
          }
        },
        "required": [
          "userId",
          "details"
        ]
      },
      "UserLastPaymentMethodData": {
        "description": "Last usage data for wallet or payment method (guest)",
        "oneOf": [
          {
            "$ref": "#/components/schemas/WalletLastUsageData"
          },
          {
            "$ref": "#/components/schemas/GuestMethodLastUsageData"
          }
        ],
        "discriminator": {
          "propertyName": "type",
          "mapping": {
            "wallet": "#/components/schemas/WalletLastUsageData",
            "guest": "#/components/schemas/GuestMethodLastUsageData"
          }
        }
      },
      "WalletLastUsageData": {
        "x-discriminator-value": "wallet",
        "type": "object",
        "description": "Last usage data for wallets.",
        "properties": {
          "walletId": {
            "$ref": "#/components/schemas/WalletId"
          },
          "date": {
            "type": "string",
            "format": "date-time"
          },
          "type": {
            "type": "string",
            "description": "Discriminant type for last usage of a wallet, fixed value 'wallet'"
          }
        },
        "required": [
          "walletId",
          "date",
          "type"
        ]
      },
      "GuestMethodLastUsageData": {
        "x-discriminator-value": "guest",
        "type": "object",
        "description": "Last usage data for guest method",
        "properties": {
          "paymentMethodId": {
            "type": "string",
            "format": "uuid",
            "description": "eCommerce payment method id associated to this last usage"
          },
          "date": {
            "type": "string",
            "format": "date-time"
          },
          "type": {
            "type": "string",
            "description": "Discriminant type for last usage of a guest (non-wallet) payment method, fixed value 'guest'"
          }
        },
        "required": [
          "paymentMethodId",
          "date",
          "type"
        ]
      },
      "WalletId": {
        "description": "Wallet identifier",
        "type": "string",
        "format": "uuid"
      }
    },
    "requestBodies": {
      "UserLastPaymentMethodRequest": {
        "required": true,
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/UserLastPaymentMethodRequest"
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