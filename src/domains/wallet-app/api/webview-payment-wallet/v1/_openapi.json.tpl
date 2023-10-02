{
  "openapi": "3.0.3",
  "info": {
    "title": "pagoPA Wallet API for Webview",
    "version": "0.0.1",
    "description": "API to handle webview of wallets PagoPA, where a wallet is triple between user identifier, payment instrument and services (i.e pagoPA, bpd).",
    "termsOfService": "https://pagopa.it/terms/"
  },
  "tags": [
    {
      "name": "payment-wallet-methods",
      "description": "Api's for handle a webview wallet",
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
    "/payment-methods": {
      "get": {
        "tags": [
          "payment-wallet-methods"
        ],
        "operationId": "getAllPaymentMethods",
        "security": [
          {
            "bearerAuth": []
          }
        ],
        "summary": "Retrieve all Payment Methods (by filter)",
        "parameters": [
          {
            "name": "amount",
            "in": "query",
            "description": "Payment Amount",
            "required": false,
            "schema": {
              "type": "number"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "Payment method successfully retrieved",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentMethodsResponse"
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
      "PaymentMethodsResponse": {
        "type": "object",
        "description": "Payment methods response",
        "properties": {
          "paymentMethods": {
            "type": "array",
            "items": {
              "$ref": "#/components/schemas/PaymentMethodResponse"
            }
          }
        }
      },
      "PaymentMethodResponse": {
        "type": "object",
        "description": "Payment method Response",
        "properties": {
          "id": {
            "type": "string",
            "description": "Payment method ID"
          },
          "name": {
            "type": "string",
            "description": "Payment method name"
          },
          "description": {
            "type": "string",
            "description": "Payment method description"
          },
          "asset": {
            "type": "string",
            "description": "Payment method asset name"
          },
          "status": {
            "$ref": "#/components/schemas/PaymentMethodStatus"
          },
          "paymentTypeCode": {
            "type": "string",
            "description": "Payment method type code"
          },
          "ranges": {
            "description": "Payment amount range in eurocents",
            "type": "array",
            "minItems": 1,
            "items": {
              "$ref": "#/components/schemas/Range"
            }
          }
        },
        "required": [
          "id",
          "name",
          "description",
          "status",
          "paymentTypeCode",
          "ranges"
        ]
      },
      "PaymentMethodStatus": {
        "type": "string",
        "description": "Payment method status",
        "enum": [
          "ENABLED",
          "DISABLED",
          "INCOMING"
        ]
      },
      "Range": {
        "type": "object",
        "description": "Payment amount range in cents",
        "properties": {
          "min": {
            "type": "integer",
            "format": "int64",
            "minimum": 0,
            "description": "Range min amount"
          },
          "max": {
            "type": "integer",
            "format": "int64",
            "minimum": 0
          }
        }
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