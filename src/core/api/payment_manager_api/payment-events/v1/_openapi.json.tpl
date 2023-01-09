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
          "transaction": {
            "$ref": "#/components/schemas/TransactionEvent"
          },
          "wallet": {
            "$ref": "#/components/schemas/WalletEvent"
          },
          "user": {
            "$ref": "#/components/schemas/UserEvent"
          }
        }
      },
      "TransactionEvent": {
        "type": "object",
        "properties": {
          "idTransaction": {
            "type": "number"
          },
          "grandTotal": {
            "type": "number"
          },
          "amount": {
            "type": "number"
          },
          "fee": {
            "type": "number"
          },
          "transactionStatus": {
            "type": "string"
          },
          "accountingStatus": {
            "type": "string"
          },
          "rrn": {
            "type": "string"
          },
          "authorizationCode": {
            "type": "string"
          },
          "creationDate": {
            "type": "string",
            "format": "date-time"
          },
          "numaut": {
            "type": "string"
          },
          "accountCode": {
            "type": "string"
          },
          "psp": {
            "$ref": "#/components/schemas/PspEvent"
          }
        }
      },
      "PspEvent": {
        "type": "object",
        "properties": {
          "idChannel": {
            "type": "string"
          },
          "businessName": {
            "type": "string"
          },
          "serviceName": {
            "type": "string"
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
      },      
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