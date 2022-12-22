{
  "openapi": "3.0.1",
  "info": {
    "title": "OpenAPI definition for payment events - payment-manager",
    "version": "v1"
  },
  "servers": [
    {
      "url": "${host}/payment-manager/events/v1"
    }
  ],
  "security": [
    {
      "ApiKey": []
    }
  ],
  "paths": {
    "/payment-events/{idPayment}": {
      "get": {
        "summary": "API to retrive info related to payment given idPayment",
        "tags": [
          "payment-manager-events"
        ],
        "operationId": "payment-events",
        "parameters": [
          {
            "in": "path",
            "name": "idPayment",
            "schema": {
              "type": "string",
              "format": "uuid"
            },
            "required": true,
            "description": "paymentId for nodo",
            "example": "77e1c83b-7bb0-437b-bc50-a7a58e5660ac"
          }
        ],
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/PaymentEvent"
                }
              }
            }
          },
          "400": {
            "description": "Bad request - invalid idPayment"
          },
          "401": {
            "description": "Access denied due to invalid subscription key"
          },
          "500": {
            "description": "Internal server error"
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "PaymentEvent": {
        "type": "object",
        "properties": {
          "transactionDetails": {
            "$ref": "#/components/schemas/TransactionDetails"
          }
        }
      },
      "TransactionDetails": {
        "type": "object",
        "properties": {
          "user": {
            "$ref": "#/components/schemas/UserEvent"
          },
          "paymentAuthorizationRequest": {
            "$ref": "#/components/schemas/PaymentAuthorizationRequest"
          },
          "wallet": {
            "$ref": "#/components/schemas/WalletEvent"
          }
        }
      },
      "PaymentAuthorizationRequest": {
        "type": "object",
        "properties": {
          "authOutcome": {
            "type": "string",
            "enum": [
              "OK",
              "KO"
            ]
          },
          "requestId": {
            "type": "string"
          },
          "correlationId": {
            "type": "string"
          },
          "authCode": {
            "type": "string"
          },
          "paymentMethodType": {
            "type": "string",
            "example": "CP or PPAY or PPAL, so paymentTypeCode of Nodo"
          },
          "details": {
            "type": "object",
            "description": "details related to paymentMethodType",
            "example": {
              "blurredNumber": "************1234",
              "holder": "M**** *****I",
              "circuit": "VISA"
            }
          }
        }
      },
      "WalletEvent": {
        "type": "object",
        "properties": {
          "idWallet": {
            "type": "number"
          },
          "walletType": {
            "type": "string"
          },
          "enableableFunctions": {
            "type": "array",
            "items": {
              "type": "string"
            }
          },
          "pagoPa": {
            "type": "boolean"
          },
          "onboardingChannel": {
            "type": "string"
          },
          "favourite": {
            "type": "boolean"
          },
          "createDate": {
            "type": "string",
            "format": "date-time"
          },
          "info": {
            "type": "object"
          }
        }
      },
      "UserEvent": {
        "type": "object",
        "properties": {
          "idUser": {
            "type": "number"
          },
          "userStatus": {
            "type": "number"
          },
          "userStatusDescription": {
            "type": "string"
          }
        }
      }
    },
    "securitySchemes": {
      "ApiKey": {
        "type": "apiKey",
        "description": "The API key to access this function app.",
        "name": "Ocp-Apim-Subscription-Key",
        "in": "header"
      }
    }
  }
}